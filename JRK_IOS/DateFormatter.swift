//
//  DateFormatter.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 28/12/2024.
//
import Foundation

struct GlobalDateFormatter {
    static let shared = GlobalDateFormatter()
    
    private init() {
        
    }
    
    private static var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()
    
    func dateString(from date: Date) -> String {
        return Self.dateFormatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        return Self.dateFormatter.date(from: string)
    }
}
