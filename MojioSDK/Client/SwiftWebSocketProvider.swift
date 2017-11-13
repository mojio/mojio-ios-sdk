/******************************************************************************
 * Moj.io Inc. CONFIDENTIAL
 * 2017 Copyright Moj.io Inc.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains, the property of
 * Moj.io Inc. and its suppliers, if any.  The intellectual and technical
 * concepts contained herein are proprietary to Moj.io Inc. and its suppliers
 * and may be covered by Patents, pending patents, and are protected by trade
 * secret or copyright law.
 *
 * Dissemination of this information or reproduction of this material is strictly
 * forbidden unless prior written permission is obtained from Moj.io Inc.
 *******************************************************************************/

import SwiftWebSocket

class SwiftWebSocketWrapper: WebSocketProvider {
    var onConnect: () -> Void = { }
    var onDisconnect: (Error?) -> Void = { _ in }
    var onMessage: (Any) -> Void = { _ in }
    var onPong: (Any) -> Void = { _ in }
    
    private let webSocket: WebSocket
    
    required init(request: URLRequest) {
        self.webSocket = WebSocket(request: request)

        self.configure()
    }
    
    required init(webSocket: WebSocket) {
        self.webSocket = webSocket

        self.configure()
    }
    
    func connect() {
        webSocket.open()
    }

    func disconnect() {
        webSocket.close()
    }
    
    private func configure() {
        self.webSocket.event.open = {
            self.onConnect()
        }
        self.webSocket.event.end = { _, _, _, error in
            self.onDisconnect(error)
        }
        self.webSocket.event.message = { data in
            self.onMessage(data)
        }
        self.webSocket.event.pong = { data in
            self.onPong(data)
        }
    }
}

