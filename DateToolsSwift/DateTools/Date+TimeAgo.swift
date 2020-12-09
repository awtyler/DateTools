//
//  Date+TimeAgo.swift
//  DateToolsTests
//
//  Created by Matthew York on 8/23/16.
//  Copyright © 2016 Matthew York. All rights reserved.
//

import Foundation

/**
 *  Extends the Date class by adding convenient methods to display the passage of
 *  time in String format.
 */
public extension Date {
    
    //MARK: - Time Ago
    
    /**
     *  Takes in a date and returns a string with the most convenient unit of time representing
     *  how far in the past that date is from now.
     *
     *  - parameter date: Date to be measured from now
     *
     *  - returns String - Formatted return string
     */
    static func timeAgo(since date:Date) -> String{
        return date.timeAgo(since: Date(), numericDates: false, numericTimes: false)
    }
    
    /**
     *  Takes in a date and returns a shortened string with the most convenient unit of time representing
     *  how far in the past that date is from now.
     *
     *  - parameter date: Date to be measured from now
     *
     *  - returns String - Formatted return string
     */
    static func shortTimeAgo(since date:Date) -> String {
        return date.shortTimeAgo(since:Date())
    }
    
    /**
     *  Returns a string with the most convenient unit of time representing
     *  how far in the past that date is from now.
     *
     *  - returns String - Formatted return string
     */
    var timeAgoSinceNow: String {
        return self.timeAgo(since:Date())
    }
    
    /**
     *  Returns a shortened string with the most convenient unit of time representing
     *  how far in the past that date is from now.
     *
     *  - returns String - Formatted return string
     */
    var shortTimeAgoSinceNow: String {
        return self.shortTimeAgo(since:Date())
    }
    
    func timeAgo(since date:Date, numericDates: Bool = false, numericTimes: Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.second,.minute,.hour,.day,.weekOfYear,.month,.year])
        let earliest = self.earlierDate(date)
        let latest = (earliest == self) ? date : self //Should be triple equals, but not extended to Date at this time
        let inFuture = earliest == date
        
        let components = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        let yesterday = date.subtract(1.days)
        let isYesterday = yesterday.day == self.day
        
        //Not Yet Implemented/Optional
        //The following strings are present in the translation files but lack logic as of 2014.04.05
        //@"Today", @"This week", @"This month", @"This year"
        //and @"This morning", @"This afternoon"
        
        if (components.year! >= 2) {
            let format = inFuture ? "In %%d %@years" : "%%d %@years ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.year!)
        }
        else if (components.year! >= 1) {
            var text = inFuture ? "Next year" : "Last year"
            if (numericDates) {
                text = inFuture ? "In 1 year" : "1 year ago"
            }
            
            return DateToolsLocalizedStrings(text);
        }
        else if (components.month! >= 2) {
            let format = inFuture ? "In %%d %@months" : "%%d %@months ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.month!)
        }
        else if (components.month! >= 1) {
            
            var text = inFuture ? "Next month" : "Last month"
            if (numericDates) {
                text = inFuture ? "In 1 month" : "1 month ago";
            }
            
            return DateToolsLocalizedStrings(text);
        }
        else if (components.weekOfYear! >= 2) {
            let format = inFuture ? "In %%d %@weeks" : "%%d %@weeks ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.weekOfYear!)
        }
        else if (components.weekOfYear! >= 1) {
            
            var text = inFuture ? "Next week": "Last week"
            if (numericDates) {
                text = inFuture ? "In 1 week": "1 week ago");
            }
            
            return DateToolsLocalizedStrings(text);
        }
        else if (components.day! >= 2) {
            let format = inFuture ? "In %%d %@days" : "%%d %@days ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.day!)
        }
        else if (isYesterday) {
            var text = inFuture ? "Tomorrow" : "Yesterday"
            if (numericDates) {
                text = inFuture ? "In 1 day" : "1 day ago";
            }
            
            return DateToolsLocalizedStrings(text);
        }
        else if (components.hour! >= 2) {
            let format = inFuture ? "In %%d %@hours" : "%%d %@hours ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.hour!)
        }
        else if (components.hour! >= 1) {
            
            var text = inFuture ? "In an hour" : "An hour ago"
            if (numericTimes) {
                text = inFuture ? "In 1 hour" : "1 hour ago";
            }
            
            return DateToolsLocalizedStrings(text);
        }
        else if (components.minute! >= 2) {
            let format = inFuture ? "in %%d %@minutes" : "%%d %@minutes ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.minute!)
        }
        else if (components.minute! >= 1) {
            
            var text = inFuture ? "In a minute" : "A minute ago"
            if (numericTimes) {
                text = inFuture ? "In 1 minute" : "1 minute ago";
            }
            
            return DateToolsLocalizedStrings(text);
        }
        else if (components.second! >= 3) {
            let format = inFuture ? "In %%d %@seconds" : "%%d %@seconds ago"
            return self.logicalLocalizedStringFromFormat(format: format, value: components.second!)
        }
        else {
            
            var text = inFuture ? "Right now" : "Just now"
            if (numericTimes) {
                text = inFuture ? "In 1 second" : "1 second ago";
            }
            
            return DateToolsLocalizedStrings(text);
        }
    }
    
    
    func shortTimeAgo(since date:Date) -> String {
        let calendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.second,.minute,.hour,.day,.weekOfYear,.month,.year])
        let earliest = self.earlierDate(date)
        let latest = (earliest == self) ? date : self //Should pbe triple equals, but not extended to Date at this time
        
        
        let components = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        let yesterday = date.subtract(1.days)
        let isYesterday = yesterday.day == self.day
        
        
        if (components.year! >= 1) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@y", value: components.year!)
        }
        else if (components.month! >= 1) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@M", value: components.month!)
        }
        else if (components.weekOfYear! >= 1) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@w", value: components.weekOfYear!)
        }
        else if (components.day! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@d", value: components.day!)
        }
        else if (isYesterday) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@d", value: 1)
        }
        else if (components.hour! >= 1) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@h", value: components.hour!)
        }
        else if (components.minute! >= 1) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@m", value: components.minute!)
        }
        else if (components.second! >= 3) {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@s", value: components.second!)
        }
        else {
            return self.logicalLocalizedStringFromFormat(format: "%%d%@s", value: components.second!)
            //return DateToolsLocalizedStrings(@"Now"); //string not yet translated 2014.04.05
        }
    }
    
    
    private func logicalLocalizedStringFromFormat(format: String, value: Int) -> String{
        #if os(Linux)
            let localeFormat = String.init(format: format, getLocaleFormatUnderscoresWithValue(Double(value)) as! CVarArg)  // this may not work, unclear!!
        #else
            let localeFormat = String.init(format: format, getLocaleFormatUnderscoresWithValue(Double(value)))
        #endif
        
        return String.init(format: DateToolsLocalizedStrings(localeFormat), value)
    }
    
    
    private func getLocaleFormatUnderscoresWithValue(_ value: Double) -> String{
        let localCode = Bundle.main.preferredLocalizations[0]
        if (localCode == "ru" || localCode == "uk") {
            let XY = Int(floor(value).truncatingRemainder(dividingBy: 100))
            let Y = Int(floor(value).truncatingRemainder(dividingBy: 10))
            
            if(Y == 0 || Y > 4 || (XY > 10 && XY < 15)) {
                return ""
            }
            
            if(Y > 1 && Y < 5 && (XY < 10 || XY > 20))  {
                return "_"
            }
            
            if(Y == 1 && XY != 11) {
                return "__"
            }
        }
        
        return ""
    }
    
    
    // MARK: - Localization
    
    private func DateToolsLocalizedStrings(_ string: String) -> String {
        //let classBundle = Bundle(for:TimeChunk.self as! AnyClass.Type).resourcePath!.appending("DateTools.bundle")
        
        //let bundelPath = Bundle(path:classBundle)!
        #if os(Linux)
        // NSLocalizedString() is not available yet, see: https://github.com/apple/swift-corelibs-foundation/blob/16f83ddcd311b768e30a93637af161676b0a5f2f/Foundation/NSData.swift
        // However, a seemingly-equivalent method from NSBundle is: https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSBundle.swift
            return Bundle.main.localizedString(forKey: string, value: "", table: "DateTools")
        #else
            return NSLocalizedString(string, tableName: "DateTools", bundle: Bundle.dateToolsBundle(), value: "", comment: "")
        #endif
    }
    
    
    // MARK: - Date Earlier/Later
    
    /**
     *  Return the earlier of two dates, between self and a given date.
     *  
     *  - parameter date: The date to compare to self
     *
     *  - returns: The date that is earlier
     */
    func earlierDate(_ date:Date) -> Date{
        return (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
    }
    
    /**
     *  Return the later of two dates, between self and a given date.
     *
     *  - parameter date: The date to compare to self
     *
     *  - returns: The date that is later
     */
    func laterDate(_ date:Date) -> Date{
        return (self.timeIntervalSince1970 >= date.timeIntervalSince1970) ? self : date
    }
    
}
