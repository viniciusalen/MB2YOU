//
//  NSError+Extensions.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/21/21.
//

import Foundation

public let NSErrorDataKey: String = "NSErrorDataKey"

public extension NSError {
    
    convenience init(domain: String = Bundle.main.bundleIdentifier ?? "", code: Int = -1, message: String = "") {
        self.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    convenience init(domain: String, message: String, code: Int = 0, data: Data? = nil) {
        var userInfo: [String: Any] = [:]
        
        userInfo[NSLocalizedDescriptionKey] = message
        if let data: Data = data {
            userInfo[NSErrorDataKey] = data
        }
        
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}
