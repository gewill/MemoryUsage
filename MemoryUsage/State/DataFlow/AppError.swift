//
//  AppError.swift
//  MemoryUsage
//
//  Created by Will on 16/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }

    case outOfMemory
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .outOfMemory:
            return "内存溢出"
        }
    }
}
