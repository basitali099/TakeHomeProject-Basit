//
//  DetailModel.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import Foundation

// Enumeration for different tab sections
enum TabSection: Int {
    case arKit
    case sceneKit
}

// Struct representing DetailModel.
struct DetailModel: Identifiable, Equatable, Hashable {
    let id = UUID().uuidString
    var name: String
    var fileName: String
    
    var url: URL? {
        return Bundle.main.url(forResource: fileName, withExtension: "usdz")
    }

    var filenameWithExt: String {
        return fileName + ".usdz"
    }
}
