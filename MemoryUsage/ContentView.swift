//
//  ContentView.swift
//  MemoryUsage
//
//  Created by Will on 15/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store

    var homepage: AppState.Homepage {
        store.appState.homepage
    }

    @State var data: [Data] = []

    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text("App的CPU使用率:\(homepage.checker.deviceState.cpuUsage)")
                Text("App已使用内存:\(homepage.checker.deviceState.memoryUsage)MB, 亦:\(homepage.checker.deviceState.memoryUsage.toKilo)GB")
                Text("设备总内存:\(homepage.checker.deviceState.totalMemory)MB, 亦:\(homepage.checker.deviceState.totalMemory.toKilo)GB")
                Divider()
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
        DispatchQueue.global().async {
            self.data.append(Data(repeating: 1, count: count * 1024 * 1024))
        }
    }

    private func updateUI() {
        store.dispatch(.updateUsage(deviceState: AppState.DeviceState()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
            .environmentObject(Store())
    }
}
