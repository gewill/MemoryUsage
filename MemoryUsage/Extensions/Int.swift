//
//  Int.swift
//  MemoryUsage
//
//  Created by Will on 16/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import Foundation

extension Int {
    var toKilo: String {
        return String(format: "%.2f", Double(self) / 1024)
    }
}
