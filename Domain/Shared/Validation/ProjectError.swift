//
//  ProjectError.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 13/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Foundation

public enum ProjectError: Error {
    case getMovieListFalied
    case lostInternetConnection
    case tokenInvalids
    case other(error: Error)
    case undefine
    case noProductIDsFound
    case noProductsFound
    case paymentWasCancelled
    case productRequestFailed
    case premiumRegisterFailed
}

public extension ProjectError {
    
    var debugDescription: String? {
        switch self {
        case .lostInternetConnection:
            return "Lost internet connection"
        case .getMovieListFalied:
            return "Get movie list falied!"
        case .tokenInvalids:
            return "Token Invalid!!!"
        case .other(let error):
            return error.localizedDescription
        case .undefine:
            return "Undefined error!"
        case .noProductIDsFound:
            return "Không tìm thấy id sản phẩm."
        case .noProductsFound:
            return "Không tìm thấy sản phẩm nào."
        case .productRequestFailed:
            return "Không thể lấy thông tin sản phẩm. Vui lòng thử lại sau."
        case .paymentWasCancelled:
            return "Thanh toán đã bị huỷ."
        case .premiumRegisterFailed:
            return "Đăng ký Yummy Premium không thành công. Vui lòng thử lại sau"
        }
    }
    
}

extension ProjectError: DomainErrorConvertible {
    public func asDomainError() -> ProjectError {
        return self
    }
}
