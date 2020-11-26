//
//  RepositoryProtocol.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//
//swiftlint:disable type_name

import Foundation

protocol RepositoryProtocol {
    associatedtype T
    associatedtype A

    func create(data: A) -> T?
    func read(identifier: String) -> T?
    func readAll() -> [T]
    func update(model: A) -> Bool
    func delete(identifier: String) -> Bool
}
