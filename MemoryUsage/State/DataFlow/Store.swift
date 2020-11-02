//
//  Store.swift
//  MemoryUsage
//
//  Created by Will on 16/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()

    private var disposeBag = Set<AnyCancellable>()

    // MARK: - life cycle

    init() {
        setupObservers()
    }

    func setupObservers() {
        appState.homepage.checker.startMonitoring.sink { deviceState in
            self.dispatch(.updateUsage(deviceState: deviceState))
        }.store(in: &disposeBag)
    }

    // MARK: - dispatch

    func dispatch(_ action: AppAction) {
        #if DEBUG
            print("[ACTION]: \(action)")
        #endif

        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            #if DEBUG
                print("[COMMAND]: \(command)")
            #endif

            command.execute(in: self)
        }
    }

    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appCommand: AppCommand?

        switch action {
        case let .updateUsage(deviceState):
            appCommand = LogAppCommand(deviceState: deviceState)
        }

        return (state, appCommand)
    }
}
