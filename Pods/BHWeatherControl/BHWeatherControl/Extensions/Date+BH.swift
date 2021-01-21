//
//  Extensions.swift
//  BHWeatherControl
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

extension Date {
    
    init(dateInt: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(dateInt))
    }
    
    //get time from timezone
    func getCurrentTime(timezoneOffset: Int) -> String {
        
        let format = DateFormatter()
        
        format.timeZone = TimeZone(secondsFromGMT: timezoneOffset)
        
        format.dateFormat = DateFormat.timeFormat
        
        return format.string(from: self)
    }
    
    //get day name of week
    var dayNameFromTimezone: String {
        
        let format = DateFormatter()
        
        format.timeZone = .current
        
        format.locale = Locale(identifier: Constants.appLang)
        
        format.dateFormat = DateFormat.dayNameFormat
        
        return format.string(from: self).capitalized
    }
}
