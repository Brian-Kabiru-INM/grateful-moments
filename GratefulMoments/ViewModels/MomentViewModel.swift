//
//  MomentViewModel.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 30/03/2026.
//
import SwiftData
import Foundation
import Combine

class MomentViewModel: ObservableObject {
    @Published var moments: [MomentDTO] = []
    private var cancellables = Set<AnyCancellable>()
    private let apiClient = APIClient()
    
    func fetchMoments(context: ModelContext) {
        apiClient.request(.fetchMoments)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching moments : \(error)")
                }
            }, receiveValue: { [weak self] (moments: [MomentDTO]) in
                self?.moments = moments
                for dto in moments {
                                    let moment = Moment(
                                        title: dto.title,
                                        note: dto.note,
                                        timeStamp: dto.timeStamp
                                    )
                                    context.insert(moment)
                                }
                                try? context.save()
            })
            .store(in: &cancellables)
    }
    func addMoment(_ moment: MomentDTO) {
        apiClient.request(.addMoment, body: moment)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error adding moment: \(error)")
                }
            }, receiveValue: { [weak self] newMoment in
                self?.moments.append(newMoment)
            })
            .store(in: &cancellables)
    }
}
