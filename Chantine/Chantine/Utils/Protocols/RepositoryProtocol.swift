//
//  RepositoryProtocol.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype T

    func create() -> T
    func read() -> T?
    func readAll() -> [T]
    func update(model: T) -> Bool
    func delete(identifier: String) -> Bool
}
