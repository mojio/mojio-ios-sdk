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

import Foundation

public protocol WebSocketProvider {
    init(request: URLRequest)
    
    var onConnect: () -> Void { get set }
    var onDisconnect: (_ error: Error?) -> Void { get set }
    var onMessage: (_ data: Any) -> Void { get set }
    var onPong: (_ data: Any) -> Void { get set }
    
    func connect()
    func disconnect()
    func ping()
}
