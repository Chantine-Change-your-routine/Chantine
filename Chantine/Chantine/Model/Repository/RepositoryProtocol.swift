//
//  RepositoryProtocol.swift
//  Chantine
//
//  Created by Brena Amorim on 24/11/20.
//

import Foundation

protocol RepositoryProtocol {
    
    associatedtype T
    
    func create() -> Bool
    func readAll() -> [T]
    func read(identifier: String) -> T?
    func update(item: T) -> Bool
    func delete(identifier: String) -> Bool
    
}
