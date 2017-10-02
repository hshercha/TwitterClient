//
//  Utils.swift
//  Twitter
//
//  Created by hsherchan on 10/1/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import Foundation

class Utils {
    class func timeAgoSinceDate(date:Date) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now as Date
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 1) && (components.month! >= 1) && (components.month! >= 1) && (components.weekOfYear! >= 1) && (components.day! >= 1) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/DD/YY"
            return formatter.string(from: date)
        }else if (components.hour! >= 1){
            return "\(components.hour!)h"
        } else if (components.minute! >= 1){
            return "\(components.minute!)m"
        } else if (components.second! >= 3) {
            return "\(components.second!)s"
        } else {
            return "Just now"
        }
        
    }

}
