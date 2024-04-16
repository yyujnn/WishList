//
//  Double+.swift
//  WishList
//
//  Created by 정유진 on 2024/04/16.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 0 // 소수점 이하 자리 수 설정
        
        var formattedString = formatter.string(from: NSNumber(value: self)) ?? ""
        formattedString = formattedString.replacingOccurrences(of: " ", with: "")
        formattedString += "$"
        
        return formattedString
    }
}
