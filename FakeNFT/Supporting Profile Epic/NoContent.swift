//
//  NoContent.swift
//  FakeNFT
//
//  Created by Ann Goncharova on 23.11.2023.
//

import Foundation

enum NoContent: String {
    case noInternet = "No interner" // добавить локаль
    
    func stringValue() -> String {
        return self.rawValue
    }
}
