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
    
    private static var dateFormatterDayMonthYear: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()
    
    private static var dateFormatterIsoSubstring: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    func dateISOString(from date: Date) -> String {
        return date.ISO8601Format()
    }
    
    func date(fromIsoSubstring string: String) -> Date? {
        return Self.dateFormatterIsoSubstring.date(from: string)
    }
    
    func dateString(from date: Date) -> String {
        return Self.dateFormatterDayMonthYear.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        return Self.dateFormatterDayMonthYear.date(from: string)
    }
}
