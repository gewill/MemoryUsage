//
//  AppCommand.swift
//  MemoryUsage
//
//  Created by Will on 16/01/2020.
//  Copyright © 2020 gewill.org. All rights reserved.
//

import Combine
import Foundation

protocol AppCommand {
    func execute(in store: Store)
}

struct LogAppCommand: AppCommand {
    var deviceState: AppState.DeviceState

    func execute(in store: Store) {
        let token = SubscriptionToken()
        Just(deviceState).sink { deviceState in
            print(deviceState)
            token.unseal()
        }.seal(in: token)
    }
}

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}
