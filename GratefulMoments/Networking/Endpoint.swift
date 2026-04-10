//
//  Endpoint.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 30/03/2026.
//

import Foundation

enum Endpoint {
    case fetchMoments
    case addMoment
    case updateMoment(id: String)
    case deleteMoment(id: String)
    
    var url: URL {
        switch self {
        case.fetchMoments:
            return URL(string: "http://localhost:3000/moments")!
        case .addMoment:
            return URL(string: "http://localhost:3000/moments")!
        case .updateMoment(let id):
            return URL(string: "http://localhost:3000/moments/\(id)")!
        case .deleteMoment(let id):
            return URL(string: "http://localhost:3000/moments/\(id)")!
        }
    }
    var method: String {
        switch self {
        case.fetchMoments: return "GET"
        case.addMoment: return "POST"
        case.updateMoment: return "PUT"
        case.deleteMoment: return "DELETE"
        }
    }
}
