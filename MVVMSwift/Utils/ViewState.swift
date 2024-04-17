//
//  ViewState.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
