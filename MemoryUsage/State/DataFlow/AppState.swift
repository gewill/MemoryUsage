//
//  AppState.swift
//  MemoryUsage
//
//  Created by Will on 16/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import Combine

struct AppState {
    var homepage = Homepage()
}

extension AppState {
    struct DeviceState: Codable {
        var cpuUsage: CGFloat = DoraemonCPUUtil.cpuUsageForApp()
        var memoryUsage: Int = DoraemonMemoryUtil.useMemoryForApp()
        var totalMemory: Int = DoraemonMemoryUtil.totalMemoryForDevice()
        var date: Date = Date()
    }

    struct Homepage {
        class DeviceStateChecker {
            @Published var deviceState: DeviceState = DeviceState()

            var startMonitoring: AnyPublisher<DeviceState, Never> {
//                Future<DeviceState, Never> { promise in
//                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
//                        self.deviceState = DeviceState()
//                        promise(.success(self.deviceState))
//                    }
//                }
//                .receive(on: DispatchQueue.main)
//                .eraseToAnyPublisher()

                let subject = PassthroughSubject<DeviceState, Never>()
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    self.deviceState = DeviceState()
                    subject.send(self.deviceState)
                }
                return subject
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            }
        }

        var checker = DeviceStateChecker()

//        @FileStorage(directory: .cachesDirectory, fileName: "deviceStates.json")
//        var deviceStates: [AppState.DeviceState]?
    }
}
