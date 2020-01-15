//
//  ContentView.swift
//  MemoryUsage
//
//  Created by Will on 15/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var useMemoryForApp: Int = DoraemonMemoryUtil.useMemoryForApp()
    @State var totalMemoryForDevice: Int = DoraemonMemoryUtil.totalMemoryForDevice()

    @State var data: [Data] = []

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text("已使用内存:\(useMemoryForApp)MB, 亦:\(useMemoryForApp.toKilo)GB")
                Text("设备总内存:\(totalMemoryForDevice)MB, 亦:\(totalMemoryForDevice.toKilo)GB")
                Button(action: {
                    self.updateUI()
                }) {
                    Text("获取内存使用情况")
                }
                Button(action: {
                    self.increaseMemory(1)
                    self.updateUI()
                }) {
                    Text("增加约1MB内存使用")
                }
                Button(action: {
                    self.increaseMemory(10)
                    self.updateUI()
                }) {
                    Text("增加约10MB内存使用")
                }
                Button(action: {
                    self.increaseMemory(100)
                    self.updateUI()
                }) {
                    Text("增加约100MB内存使用")
                }
                Button(action: {
                    self.increaseMemory(1024)
                    self.updateUI()
                }) {
                    Text("增加约1GB内存使用")
                }
                Button(action: {
                    self.increaseMemory(1024 * 10)
                    self.updateUI()
                }) {
                    Text("增加约10GB内存使用")
                }
            }
        }
    }

    private func increaseMemory(_ count: Int) {
        data.append(Data(repeating: 1, count: count * 1024 * 1024))
    }

    private func updateUI() {
        useMemoryForApp = DoraemonMemoryUtil.useMemoryForApp()
        totalMemoryForDevice = DoraemonMemoryUtil.totalMemoryForDevice()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Int {
    var toKilo: String {
        return String(format: "%.2f", Double(self) / 1024)
    }
}
