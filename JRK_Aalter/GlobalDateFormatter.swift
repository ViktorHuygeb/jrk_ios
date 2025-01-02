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
    
    func getDateISOString(from date: Date) -> String {
        return date.ISO8601Format()
    }
    
    func getDate(fromIsoSubstring string: String) -> Date? {
        return Self.dateFormatterIsoSubstring.date(from: string)
    }
    
    func getDateString(from date: Date) -> String {
        return Self.dateFormatterDayMonthYear.string(from: date)
    }
    
    func getDate(from string: String) -> Date? {
        return Self.dateFormatterDayMonthYear.date(from: string)
    }
}
