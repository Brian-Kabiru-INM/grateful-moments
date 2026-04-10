//
//  SyncManager.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 01/04/2026.
//

import Foundation
import SwiftData
import Combine

@MainActor
class SyncManager {
    static let shared = SyncManager()
    
    private let api = APIClient()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Main sync entry
    func sync(moment: Moment) {
        if moment.backendID == nil {
            create(moment)
        } else {
            update(moment)
        }
    }
}
extension SyncManager {
    private func create(_ moment: Moment) {
        let dto = MomentDTO(from: moment)
        
        api.request(Endpoint.addMoment, body: dto)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Create failed:", error)
                }
            } receiveValue: { (response: MomentDTO) in
                moment.backendID = response.id
                moment.isSynced = true
            }
            .store(in: &cancellables)
    }
}
extension SyncManager {
    private func update(_ moment: Moment) {
        guard let id = moment.backendID else { return }
        
        let dto = MomentDTO(from: moment)
        
        api.request(Endpoint.updateMoment(id: id), body: dto)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Update failed:", error)
                }
            } receiveValue: { (_: MomentDTO) in
                moment.isSynced = true
            }
            .store(in: &cancellables)
    }
}
extension SyncManager {
    func delete(moment: Moment) {
        guard let id = moment.backendID else { return }
        
        api.request(Endpoint.deleteMoment(id: id))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Delete failed:", error)
                }
            } receiveValue: { (_: EmptyResponse) in
                print("Deleted from backend")
            }
            .store(in: &cancellables)
    }
}

struct EmptyResponse: Decodable {}
