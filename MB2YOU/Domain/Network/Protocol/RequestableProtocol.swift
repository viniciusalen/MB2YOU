//
//  RequestableProtocol.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/20/21.
//

import Foundation

public protocol RequestableProtocol {
    var url: URL { get }
    var method: NetworkMethod { get }
    var titleError: String { get }
}
