//
//  Date.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation

extension DateFormatter {

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmmss"
        return formatter
    }

}

// MARK: - DATE TOOLS: https://github.com/MatthewYork/DateTools -

/**
 *  Time conversions used across DateTools
 */
public class Constants {
    public static let SecondsInYear: TimeInterval = 31536000
    public static let SecondsInLeapYear: TimeInterval = 31622400
    public static let SecondsInMonth28: TimeInterval = 2419200
    public static let SecondsInMonth29: TimeInterval = 2505600
    public static let SecondsInMonth30: TimeInterval = 2592000
    public static let SecondsInMonth31: TimeInterval = 2678400
    public static let SecondsInWeek: TimeInterval = 604800
    public static let SecondsInDay: TimeInterval = 86400
    public static let SecondsInHour: TimeInterval = 3600
    public static let SecondsInMinute: TimeInterval = 60
    public static let MillisecondsInDay: TimeInterval = 86400000
    
    public static let AllCalendarUnitFlags: Set<Calendar.Component> = [.year, .quarter, .month, .weekOfYear, .weekOfMonth, .day, .hour, .minute, .second, .era, .weekday, .weekdayOrdinal, .weekOfYear]
}


public extension Bundle {
  
  class func dateToolsBundle() -> Bundle {
    let assetPath = Bundle(for: Constants.self).resourcePath!
    return Bundle(path: NSString(string: assetPath).appendingPathComponent("DateTools.bundle"))!
  }
}


public extension Int {
    
    //MARK: TimePeriod
    
    /**
     *  A `TimeChunk` with its seconds component set to the value of self
     */
    var seconds: TimeChunk {
        return TimeChunk(seconds: self, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its minutes component set to the value of self
     */
    var minutes: TimeChunk {
        return TimeChunk(seconds: 0, minutes: self, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its hours component set to the value of self
     */
    var hours: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: self, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its days component set to the value of self
     */
    var days: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: self, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its weeks component set to the value of self
     */
    var weeks: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: self, months: 0, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its months component set to the value of self
     */
    var months: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: self, years: 0)
    }
    
    /**
     *  A `TimeChunk` with its years component set to the value of self
     */
    var years: TimeChunk {
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: self)
    }
}


// MARK: - Enums

/**
 *  There may come a need, say when you are making a scheduling app, when
 *  it might be good to know how two time periods relate to one another.
 *  Are they the same? Is one inside of another? All these questions may be
 *  asked using the relationship methods of DTTimePeriod.
 *
 *  Further reading: [GitHub](https://github.com/MatthewYork/DateTools#relationships),
 *  [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
 */
public enum Relation {
    case after
    case startTouching
    case startInside
    case insideStartTouching
    case enclosingStartTouching
    case enclosing
    case enclosingEndTouching
    case exactMatch
    case inside
    case insideEndTouching
    case endInside
    case endTouching
    case before
    case none // One or more of the dates does not exist
}


/**
 *  Whether the time period is Open or Closed
 *
 *  Closed: The boundary moment of time is included in calculations.
 *
 *  Open: The boundary moment of time represents a boundary value which is excluded in regard to calculations.
 */
public enum Interval {
    case open
    case closed
}

/**
 *  When a time periods is lengthened or shortened, it does so anchoring one date
 *  of the time period and then changing the other one. There is also an option to
 *  anchor the centerpoint of the time period, changing both the start and end dates.
 */
public enum Anchor {
    case beginning
    case center
    case end
}

/**
 *  When a time periods is lengthened or shortened, it does so anchoring one date
 *  of the time period and then changing the other one. There is also an option to
 *  anchor the centerpoint of the time period, changing both the start and end dates.
 */
public enum Component {
    case year
    case month
    case day
    case hour
    case minute
    case second
}

/**
 *  Time units that include weeks, but not months since their exact size is dependent
 *  on the date. Used for TimeChunk conversions.
 */
public enum TimeUnits {
    case years
    case weeks
    case days
    case hours
    case minutes
    case seconds
}


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
        
        
        let components = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        let yesterday = date.subtract(1.days)
        let isYesterday = yesterday.day == self.day
        
        //Not Yet Implemented/Optional
        //The following strings are present in the translation files but lack logic as of 2014.04.05
        //@"Today", @"This week", @"This month", @"This year"
        //and @"This morning", @"This afternoon"
        
        if (components.year! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@years ago", value: components.year!)
        }
        else if (components.year! >= 1) {
            
            if (numericDates) {
                return DateToolsLocalizedStrings("1 year ago");
            }
            
            return DateToolsLocalizedStrings("Last year");
        }
        else if (components.month! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@months ago", value: components.month!)
        }
        else if (components.month! >= 1) {
            
            if (numericDates) {
                return DateToolsLocalizedStrings("1 month ago");
            }
            
            return DateToolsLocalizedStrings("Last month");
        }
        else if (components.weekOfYear! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@weeks ago", value: components.weekOfYear!)
        }
        else if (components.weekOfYear! >= 1) {
            
            if (numericDates) {
                return DateToolsLocalizedStrings("1 week ago");
            }
            
            return DateToolsLocalizedStrings("Last week");
        }
        else if (components.day! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@days ago", value: components.day!)
        }
        else if (isYesterday) {
            if (numericDates) {
                return DateToolsLocalizedStrings("1 day ago");
            }
            
            return DateToolsLocalizedStrings("Yesterday");
        }
        else if (components.hour! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@hours ago", value: components.hour!)
        }
        else if (components.hour! >= 1) {
            
            if (numericTimes) {
                return DateToolsLocalizedStrings("1 hour ago");
            }
            
            return DateToolsLocalizedStrings("An hour ago");
        }
        else if (components.minute! >= 2) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@minutes ago", value: components.minute!)
        }
        else if (components.minute! >= 1) {
            
            if (numericTimes) {
                return DateToolsLocalizedStrings("1 minute ago");
            }
            
            return DateToolsLocalizedStrings("A minute ago");
        }
        else if (components.second! >= 3) {
            return self.logicalLocalizedStringFromFormat(format: "%%d %@seconds ago", value: components.second!)
        }
        else {
            
            if (numericTimes) {
                return DateToolsLocalizedStrings("1 second ago");
            }
            
            return DateToolsLocalizedStrings("Just now");
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


/**
 *  Extends the Date class by adding manipulation methods for transforming dates
 */
public extension Date {
    
    // MARK: - StartOf
    
    /**
     *  Return a date set to the start of a given component.
     *
     *  - parameter component: The date component (second, minute, hour, day, month, or year)
     *
     *  - returns: A date retaining the value of the given component and all larger components,
     *  with all smaller components set to their minimum
     */
    func start(of component: Component) -> Date {
        var newDate = self;
        if component == .second {
            newDate.second(self.second)
        }
        else if component == .minute {
            newDate.second(0)
        } else if component == .hour {
            newDate.second(0)
            newDate.minute(0)
        } else if component == .day {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
        } else if component == .month {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
            newDate.day(1)
        } else if component == .year {
            newDate.second(0)
            newDate.minute(0)
            newDate.hour(0)
            newDate.day(1)
            newDate.month(1)
        }
        return newDate
    }
    
    /**
     *  Return a date set to the end of a given component.
     *
     *  - parameter component: The date component (second, minute, hour, day, month, or year)
     *
     *  - returns: A date retaining the value of the given component and all larger components,
     *  with all smaller components set to their maximum
     */
    func end(of component: Component) -> Date {
        var newDate = self;
        if component == .second {
            newDate.second(newDate.second + 1)
            newDate = newDate - 0.001
        }
        else if component == .minute {
            newDate.second(60)
            newDate = newDate - 0.001
        } else if component == .hour {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
        } else if component == .day {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
        } else if component == .month {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
            newDate.day(daysInMonth(date: newDate))
        } else if component == .year {
            newDate.second(60)
            newDate = newDate - 0.001
            newDate.minute(59)
            newDate.hour(23)
            newDate.month(12)
            newDate.day(31)
        }
        
        return newDate
    }
    
    func daysInMonth(date: Date) -> Int {
        let month = date.month
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
            // 31 day month
            return 31
        } else if month == 2 && date.isInLeapYear {
            // February with leap year
            return 29
        } else if month == 2 && !date.isInLeapYear {
            // February without leap year
            return 28
        } else {
            // 30 day month
            return 30
        }
    }
    
    
    // MARK: - Addition / Subtractions
    
    /**
     *  # Add (TimeChunk to Date)
     *  Increase a date by the value of a given `TimeChunk`.
     *
     *  - parameter chunk: The amount to increase the date by (ex. 2.days, 4.years, etc.)
     *
     *  - returns: A date with components increased by the values of the
     *  corresponding `TimeChunk` variables
     */
    func add(_ chunk: TimeChunk) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.year = chunk.years
        components.month = chunk.months
        components.day = chunk.days + (chunk.weeks*7)
        components.hour = chunk.hours
        components.minute = chunk.minutes
        components.second = chunk.seconds
        return calendar.date(byAdding: components, to: self)!
    }
    
    /**
     *  # Subtract (TimeChunk from Date)
     *  Decrease a date by the value of a given `TimeChunk`.
     *
     *  - parameter chunk: The amount to decrease the date by (ex. 2.days, 4.years, etc.)
     *
     *  - returns: A date with components decreased by the values of the
     *  corresponding `TimeChunk` variables
     */
    func subtract(_ chunk: TimeChunk) -> Date {
        let calendar = Calendar.autoupdatingCurrent
        var components = DateComponents()
        components.year = -chunk.years
        components.month = -chunk.months
        components.day = -(chunk.days + (chunk.weeks*7))
        components.hour = -chunk.hours
        components.minute = -chunk.minutes
        components.second = -chunk.seconds
        return calendar.date(byAdding: components, to: self)!
    }
    
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for adding a `TimeChunk` to a date.
     */
    static func +(leftAddend: Date, rightAddend: TimeChunk) -> Date {
        return leftAddend.add(rightAddend)
    }
    
    /**
     *  Operator overload for subtracting a `TimeChunk` from a date.
     */
    static func -(minuend: Date, subtrahend: TimeChunk) -> Date {
        return minuend.subtract(subtrahend)
    }
    
    /**
     *  Operator overload for adding a `TimeInterval` to a date.
     */
    static func +(leftAddend: Date, rightAddend: Int) -> Date {
        return leftAddend.addingTimeInterval((TimeInterval(rightAddend)))
    }
    
    /**
     *  Operator overload for subtracting a `TimeInterval` from a date.
     */
    static func -(minuend: Date, subtrahend: Int) -> Date {
        return minuend.addingTimeInterval(-(TimeInterval(subtrahend)))
    }
    
}


/**
 *  Extends the Date class by adding convenient initializers based on components
 *  and format strings.
 */

public extension Date {
    
    // MARK: - Initializers
    
    /**
     *  Init date with components.
     *
     *  - parameter year: Year component of new date
     *  - parameter month: Month component of new date
     *  - parameter day: Day component of new date
     *  - parameter hour: Hour component of new date
     *  - parameter minute: Minute component of new date
     *  - parameter second: Second component of new date
     */
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        guard let date = Calendar.current.date(from: dateComponents) else {
            self = Date()
            return
        }
        self = date
    }
    
    /**
     *  Init date with components. Hour, minutes, and seconds set to zero.
     *
     *  - parameter year: Year component of new date
     *  - parameter month: Month component of new date
     *  - parameter day: Day component of new date
     */
    init(year: Int, month: Int, day: Int) {
        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    
    /**
     *  Init date from string, given a format string, according to Apple's date formatting guide, and time zone.
     *
     *  - parameter dateString: Date in the formatting given by the format parameter
     *  - parameter format: Format style using Apple's date formatting guide
     *  - parameter timeZone: Time zone of date
     */
    init(dateString: String, format: String, timeZone: TimeZone) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none;
        dateFormatter.timeStyle = .none;
        dateFormatter.timeZone = timeZone;
        dateFormatter.dateFormat = format;
        
        guard let date = dateFormatter.date(from: dateString) else {
            self = Date()
            return
        }
        self = date
    }
    
    /**
     *  Init date from string, given a format string, according to Apple's date formatting guide.
     *  Time Zone automatically selected as the current time zone.
     *
     *  - parameter dateString: Date in the formatting given by the format parameter
     *  - parameter format: Format style using Apple's date formatting guide
     */
    init (dateString: String, format: String) {
        self.init(dateString: dateString, format: format, timeZone: TimeZone.autoupdatingCurrent)
    }
}



/**
 *  Extends the Date class by adding convenient accessors of calendar
 *  components. Meta information about the date is also accessible via
 *  several computed Bools.
 */
public extension Date {

    /**
     *  Convenient accessor of the date's `Calendar` components.
     *
     *  - parameter component: The calendar component to access from the date
     *
     *  - returns: The value of the component
     *
     */
    func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    /**
     *  Convenient accessor of the date's `Calendar` components ordinality.
     *
     *  - parameter smaller: The smaller calendar component to access from the date
     *  - parameter larger: The larger calendar component to access from the date
     *
     *  - returns: The ordinal number of a smaller calendar component within a specified larger calendar component
     *
     */
    func ordinality(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int? {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.ordinality(of: smaller, in: larger, for: self)
    }
    
    /**
     *  Use calendar components to determine how many units of a smaller component are inside 1 larger unit.
     *
     *  Ex. If used on a date in the month of February in a leap year (regardless of the day), the method would
     *  return 29 days.
     *
     *  - parameter smaller: The smaller calendar component to access from the date
     *  - parameter larger: The larger calendar component to access from the date
     *
     *  - returns: The number of smaller units required to equal in 1 larger unit, given the date called on
     *
     */
    @available(*, deprecated, message: "Calendar component hashes no longer yield relevant values and will always return nil. The function is deprecated and will be removed soon.")
    func unit(of smaller: Calendar.Component, in larger: Calendar.Component) -> Int? {
        let calendar = Calendar.autoupdatingCurrent
        var units = 1
        var unitRange: Range<Int>?
        if larger.hashValue < smaller.hashValue {
            for x in larger.hashValue..<smaller.hashValue {
                
                var stepLarger: Calendar.Component
                var stepSmaller: Calendar.Component
                
                switch(x) {
                case 0:
                    stepLarger = Calendar.Component.era
                    stepSmaller = Calendar.Component.year
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 1:
                    if smaller.hashValue > 2 {
                        break
                    } else {
                        stepLarger = Calendar.Component.year
                        stepSmaller = Calendar.Component.month
                        unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    }
                    break
                case 2:
                    if larger.hashValue < 2 {
                        if self.isInLeapYear {
                            unitRange = Range.init(uncheckedBounds: (lower: 0, upper: 366))
                        } else {
                            unitRange = Range.init(uncheckedBounds: (lower: 0, upper: 365))
                        }
                    } else {
                        stepLarger = Calendar.Component.month
                        stepSmaller = Calendar.Component.day
                        unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    }
                    break
                case 3:
                    stepLarger = Calendar.Component.day
                    stepSmaller = Calendar.Component.hour
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 4:
                    stepLarger = Calendar.Component.hour
                    stepSmaller = Calendar.Component.minute
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                case 5:
                    stepLarger = Calendar.Component.minute
                    stepSmaller = Calendar.Component.second
                    unitRange = calendar.range(of: stepSmaller, in: stepLarger, for: self)
                    break
                default:
                    return nil
                }
                
                if unitRange?.count != nil {
                    units *= (unitRange?.count)!
                }
            }
            return units
        }
        return nil
    }
    
    // MARK: - Components
    
    /**
     *  Convenience getter for the date's `era` component
     */
    var era: Int {
        return component(.era)
    }
    
    /**
     *  Convenience getter for the date's `year` component
     */
    var year: Int {
        return component(.year)
    }
    
    /**
     *  Convenience getter for the date's `month` component
     */
    var month: Int {
        return component(.month)
    }
    
    /**
     *  Convenience getter for the date's `week` component
     */
    var week: Int {
        return component(.weekday)
    }
    
    /**
     *  Convenience getter for the date's `day` component
     */
    var day: Int {
        return component(.day)
    }
    
    /**
     *  Convenience getter for the date's `hour` component
     */
    var hour: Int {
        return component(.hour)
    }
    
    /**
     *  Convenience getter for the date's `minute` component
     */
    var minute: Int {
        return component(.minute)
    }
    
    /**
     *  Convenience getter for the date's `second` component
     */
    var second: Int {
        return component(.second)
    }
    
    /**
     *  Convenience getter for the date's `weekday` component
     */
    var weekday: Int {
        return component(.weekday)
    }
    
    /**
     *  Convenience getter for the date's `weekdayOrdinal` component
     */
    var weekdayOrdinal: Int {
        return component(.weekdayOrdinal)
    }
    
    /**
     *  Convenience getter for the date's `quarter` component
     */
    var quarter: Int {
        return component(.quarter)
    }
    
    /**
     *  Convenience getter for the date's `weekOfYear` component
     */
    var weekOfMonth: Int {
        return component(.weekOfMonth)
    }
    
    /**
     *  Convenience getter for the date's `weekOfYear` component
     */
    var weekOfYear: Int {
        return component(.weekOfYear)
    }
    
    /**
     *  Convenience getter for the date's `yearForWeekOfYear` component
     */
    var yearForWeekOfYear: Int {
        return component(.yearForWeekOfYear)
    }
    
    /**
     *  Convenience getter for the date's `daysInMonth` component
     */
    var daysInMonth: Int {
        let calendar = Calendar.autoupdatingCurrent
        let days = calendar.range(of: .day, in: .month, for: self)
        return days!.count
    }
    
    // MARK: - Set Components
    
    /**
     *  Convenience setter for the date's `year` component
     */
    mutating func year(_ year: Int) {
        self = Date.init(year: year, month: self.month, day: self.day, hour: self.hour, minute: self.minute, second: self.second)
    }
    
    /**
     *  Convenience setter for the date's `month` component
     */
    mutating func month(_ month: Int) {
        self = Date.init(year: self.year, month: month, day: self.day, hour: self.hour, minute: self.minute, second: self.second)
    }
    
    /**
     *  Convenience setter for the date's `day` component
     */
    mutating func day(_ day: Int) {
        self = Date.init(year: self.year, month: self.month, day: day, hour: self.hour, minute: self.minute, second: self.second)
    }
    
    /**
     *  Convenience setter for the date's `hour` component
     */
    mutating func hour(_ hour: Int) {
        self = Date.init(year: self.year, month: self.month, day: self.day, hour: hour, minute: self.minute, second: self.second)
    }
    
    /**
     *  Convenience setter for the date's `minute` component
     */
    mutating func minute(_ minute: Int) {
        self = Date.init(year: self.year, month: self.month, day: self.day, hour: self.hour, minute: minute, second: self.second)
    }
    
    /**
     *  Convenience setter for the date's `second` component
     */
    mutating func second(_ second: Int) {
        self = Date.init(year: self.year, month: self.month, day: self.day, hour: self.hour, minute: self.minute, second: second)
    }
    
    
    // MARK: - Bools
    
    /**
     *  Determine if date is in a leap year
     */
    var isInLeapYear: Bool {
        let yearComponent = component(.year)
        
        if yearComponent % 400 == 0 {
            return true
        }
        if yearComponent % 100 == 0 {
            return false
        }
        if yearComponent % 4 == 0 {
            return true
        }
        return false
    }
    
    /**
     *  Determine if date is within the current day
     */
    var isToday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInToday(self)
    }
    
    /**
     *  Determine if date is within the day tomorrow
     */
    var isTomorrow: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInTomorrow(self)
    }
    
    /**
     *  Determine if date is within yesterday
     */
    var isYesterday: Bool {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.isDateInYesterday(self)
    }
    
    /**
     *  Determine if date is in a weekend
     */
    var isWeekend: Bool {
        if weekday == 7 || weekday == 1 {
            return true
        }
        return false
    }
}



/**
 *  Extends the Date class by adding methods for calculating the chunk
 *  of time between two dates and providing many variables and functions
 *  that compare the ordinality of two dates and the space between two dates
 *  for a given unit of time.
 */
public extension Date {
    
    // MARK: - Comparisons
    
    /**
     *  Given a date, returns a `TimeChunk` with components in their most natural form. Example:
     *
     *  ```
     *  let formatter = DateFormatter()
     *  formatter.dateFormat = "yyyy MM dd HH:mm:ss.SSS"
     *  let birthday = formatter.date(from: "2015 11 24 14:50:12.000")!
     *  let age = birthday.chunkBetween(date: formatter.date(from: "2016 10 07 15:27:12.000")!)
     *  ```
     *
     *  The age variable will have a chunk of time with year, month, day, hour, minute,
     *  and second components (note that we do not use weeks since they are not components
     *  of `Calendar`). So if you just wanted the age in years, you could then say: age.years.
     *
     *  The chunk is calculated exactly as you'd say it in real life, always converting up
     *  when a lower unit equals 1 of the unit above it. The above example returns
     *  `TimeChunk(seconds: 0, minutes: 37, hours: 0, days: 13, weeks: 0, months: 10, years: 0)`.
     *
     *  Passing a future date returns a TimeChunk with all positive components and passing
     *  a date in the past returns one with all negative components.
     *
     *  - parameter date: The date of reference from the date called on
     *
     *  - returns: A TimeChunk representing the time between the dates, in natural form
     */
    func chunkBetween(date: Date) -> TimeChunk {
        let compenentsBetween = Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: date)
        return TimeChunk(seconds: compenentsBetween.second!, minutes: compenentsBetween.minute!, hours: compenentsBetween.hour!, days: compenentsBetween.day!, weeks: 0, months: compenentsBetween.month!, years: compenentsBetween.year!)
        // TimeChunk(seconds: secondDelta, minutes: minuteDelta, hours: hourDelta, days: dayDelta, weeks: 0, months: monthDelta, years: yearDelta)
    }
    
    /**
     *  Returns a true if receiver is equal to provided comparison date, otherwise returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func equals(_ date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }
    
    /**
     *  Returns a true if receiver is later than provided comparison date, otherwise
     *  returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func isLater(than date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    /**
     *  Returns a true if receiver is later than or equal to provided comparison date,
     *  otherwise returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func isLaterThanOrEqual(to date: Date) -> Bool {
        return self.compare(date) == .orderedDescending || self.compare(date) == .orderedSame
    }
    
    /**
     *  Returns a true if receiver is earlier than provided comparison date, otherwise
     *  returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: Bool representing comparison result
     */
    func isEarlier(than date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    /**
     *  Returns a true if receiver is earlier than or equal to the provided comparison date,
     *  otherwise returns false
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns:  Bool representing comparison result
     */
    func isEarlierThanOrEqual(to date: Date) -> Bool {
        return self.compare(date) == .orderedAscending || self.compare(date) == .orderedSame
    }
    
    /**
     *  Returns whether two dates fall on the same day.
     *
     *  - parameter date: Date to compare with sender
     *
     *  - returns: True if both paramter dates fall on the same day, false otherwise
     */
    func isSameDay(date : Date ) -> Bool {
        return Date.isSameDay(date: self, as: date)
    }
    
    /**
     *  Returns whether two dates fall on the same day.
     *
     *  - parameter date: First date to compare
     *  - parameter compareDate: Second date to compare
     *
     *  - returns: True if both paramter dates fall on the same day, false otherwise
     */
    static func isSameDay(date: Date, as compareDate: Date) -> Bool {
        let calendar = Calendar.autoupdatingCurrent
        var components = calendar.dateComponents([.era, .year, .month, .day], from: date)
        let dateOne = calendar.date(from: components)
        
        components = calendar.dateComponents([.era, .year, .month, .day], from: compareDate)
        let dateTwo = calendar.date(from: components)
        
        return (dateOne?.equals(dateTwo!))!
    }
    
    
    // MARK: - Date Comparison
    
    // MARK: Time From
    
    /**
     *  Returns an Int representing the amount of time in years between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The years between receiver and provided date
     */
    func years(from date: Date) -> Int {
        return years(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in months between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The years between receiver and provided date
     */
    func months(from date: Date) -> Int {
        return months(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in weeks between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The weeks between receiver and provided date
     */
    func weeks(from date: Date) -> Int {
        return weeks(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in days between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *  Uses the default Gregorian calendar
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The days between receiver and provided date
     */
    func days(from date: Date) -> Int {
        return days(from: date, calendar:nil)
    }
    
    /**
     *  Returns an Int representing the amount of time in hours between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The hours between receiver and provided date
     */
    func hours(from date: Date) -> Int {
        return Int(self.timeIntervalSince(date)/Constants.SecondsInHour);
    }
    
    /**
     *  Returns an Int representing the amount of time in minutes between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The minutes between receiver and provided date
     */
    func minutes(from date: Date) -> Int {
        return Int(self.timeIntervalSince(date)/Constants.SecondsInMinute)
    }
    
    /**
     *  Returns an Int representing the amount of time in seconds between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *
     *  - returns: The seconds between receiver and provided date
     */
    func seconds(from date: Date) -> Int {
        return Int(timeIntervalSince(date))
    }
    
    
    // MARK: Time From With Calendar
    
    /**
     *  Returns an Int representing the amount of time in years between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The years between receiver and provided date
     */
    func years(from date: Date, calendar: Calendar?) -> Int {
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self;
        let multiplier = (earliest == self) ? -1 : 1;
        let components = calendarCopy!.dateComponents([.year], from: earliest, to: latest)
        return multiplier * components.year!;
    }
    
    /**
     *  Returns an Int representing the amount of time in months between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The months between receiver and provided date
     */
    func months(from date: Date, calendar: Calendar?) -> Int {
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self;
        let multiplier = (earliest == self) ? -1 : 1;
        let components = calendarCopy!.dateComponents(Constants.AllCalendarUnitFlags, from: earliest, to: latest)
        return multiplier*(components.month! + 12*components.year!);
    }
    
    /**
     *  Returns an Int representing the amount of time in weeks between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The weeks between receiver and provided date
     */
    func weeks(from date: Date, calendar: Calendar?) -> Int {
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self;
        let multiplier = (earliest == self) ? -1 : 1;
        let components = calendarCopy!.dateComponents([.weekOfYear], from: earliest, to: latest)
        return multiplier*components.weekOfYear!;
    }
    
    /**
     *  Returns an Int representing the amount of time in days between the receiver and
     *  the provided date.
     *
     *  If the receiver is earlier than the provided date, the returned value will be negative.
     *
     *  - parameter date: The provided date for comparison
     *  - parameter calendar: The calendar to be used in the calculation
     *
     *  - returns: The days between receiver and provided date
     */
    func days(from date: Date, calendar: Calendar?) -> Int {
        var calendarCopy = calendar
        if (calendar == nil) {
            calendarCopy = Calendar.autoupdatingCurrent
        }
        
        let earliest = earlierDate(date)
        let latest = (earliest == self) ? date : self
        let multiplier = (earliest == self) ? -1 : 1
        let components = calendarCopy!.dateComponents([.day], from: earliest, to: latest)
        return multiplier*components.day!
    }
    
    
    // MARK: Time Until
    
    /**
     *  The number of years until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var yearsUntil: Int {
        return yearsLater(than: Date())
    }
    
    /**
     *  The number of months until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var monthsUntil: Int {
        return monthsLater(than: Date())
    }
    
    /**
     *  The number of weeks until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var weeksUntil: Int {
        return weeksLater(than: Date())
    }
    
    /**
     *  The number of days until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var daysUntil: Int {
        return daysLater(than: Date())
    }
    
    /**
     *  The number of hours until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var hoursUntil: Int{
        return hoursLater(than: Date())
    }
    
    /**
     *  The number of minutes until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var minutesUntil: Int{
        return minutesLater(than: Date())
    }
    
    /**
     *  The number of seconds until the receiver's date (0 if the receiver is the same or
     *  earlier than now).
     */
    var secondsUntil: Int{
        return secondsLater(than: Date())
    }
    
    
    // MARK: Time Ago
    
    /**
     *  The number of years the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var yearsAgo: Int {
        return yearsEarlier(than: Date())
    }
    
    /**
     *  The number of months the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var monthsAgo: Int {
        return monthsEarlier(than: Date())
    }
    
    /**
     *  The number of weeks the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var weeksAgo: Int {
        return weeksEarlier(than: Date())
    }
    
    /**
     *  The number of days the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var daysAgo: Int {
        return daysEarlier(than: Date())
    }
    
    /**
     *  The number of hours the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var hoursAgo: Int {
        return hoursEarlier(than: Date())
    }
    
    /**
     *  The number of minutes the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var minutesAgo: Int {
        return minutesEarlier(than: Date())
    }
    
    /**
     *  The number of seconds the receiver's date is earlier than now (0 if the receiver is
     *  the same or earlier than now).
     */
    var secondsAgo: Int{
        return secondsEarlier(than: Date())
    }
    
    
    // MARK: Earlier Than
    
    /**
     *  Returns the number of years the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of years
     */
    func yearsEarlier(than date: Date) -> Int {
        return abs(min(years(from: date), 0))
    }
    
    /**
     *  Returns the number of months the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of months
     */
    func monthsEarlier(than date: Date) -> Int {
        return abs(min(months(from: date), 0));
    }
    
    /**
     *  Returns the number of weeks the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of weeks
     */
    func weeksEarlier(than date: Date) -> Int {
        return abs(min(weeks(from: date), 0))
    }
    
    /**
     *  Returns the number of days the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of days
     */
    func daysEarlier(than date: Date) -> Int {
        return abs(min(days(from: date), 0))
    }
    
    /**
     *  Returns the number of hours the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of hours
     */
    func hoursEarlier(than date: Date) -> Int {
        return abs(min(hours(from: date), 0))
    }
    
    /**
     *  Returns the number of minutes the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of minutes
     */
    func minutesEarlier(than date: Date) -> Int {
        return abs(min(minutes(from: date), 0))
    }
    
    /**
     *  Returns the number of seconds the receiver's date is earlier than the provided
     *  comparison date, 0 if the receiver's date is later than or equal to the provided comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of seconds
     */
    func secondsEarlier(than date: Date) -> Int {
        return abs(min(seconds(from: date), 0))
    }
    
    
    // MARK: Later Than
    
    /**
     *  Returns the number of years the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of years
     */
    func yearsLater(than date: Date) -> Int {
        return max(years(from: date), 0)
    }
    
    /**
     *  Returns the number of months the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of months
     */
    func monthsLater(than date: Date) -> Int {
        return max(months(from: date), 0)
    }
    
    /**
     *  Returns the number of weeks the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of weeks
     */
    func weeksLater(than date: Date) -> Int {
        return max(weeks(from: date), 0)
    }
    
    /**
     *  Returns the number of days the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of days
     */
    func daysLater(than date: Date) -> Int {
        return max(days(from: date), 0)
    }
    
    /**
     *  Returns the number of hours the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of hours
     */
    func hoursLater(than date: Date) -> Int {
        return max(hours(from: date), 0)
    }
    
    /**
     *  Returns the number of minutes the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of minutes
     */
    func minutesLater(than date: Date) -> Int {
        return max(minutes(from: date), 0)
    }
    
    /**
     *  Returns the number of seconds the receiver's date is later than the provided
     *  comparison date, 0 if the receiver's date is earlier than or equal to the provided
     *  comparison date.
     *
     *  - parameter date: Provided date for comparison
     *
     *  - returns: The number of seconds
     */
    func secondsLater(than date: Date) -> Int {
        return max(seconds(from: date), 0)
    }
}


/**
 *  Extends the Date class by adding convenience methods for formatting dates.
 */
public extension Date {
    
    // MARK: - Formatted Date - Style
    
    /**
     *  Get string representation of date.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /**
     *  Get string representation of date. Locale is automatically selected as the current locale of the system.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *
     *  - returns String? - Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style, timeZone: TimeZone) -> String {
        #if os(Linux)
            return format(with: dateStyle, timeZone: timeZone, locale: Locale.current)
        #else
            return format(with: dateStyle, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    /**
     *  Get string representation of date.
     *  Time zone is automatically selected as the current time zone of the system.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards.
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style, locale: Locale) -> String {
        return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
    }
    
    /**
     *  Get string representation of date.
     *  Locale and time zone are automatically selected as the current locale and time zone of the system.
     *
     *  - parameter dateStyle: The date style in which to represent the date
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    func format(with dateStyle: DateFormatter.Style) -> String {
        #if os(Linux)
            return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.current)
        #else
            return format(with: dateStyle, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    
    // MARK: - Formatted Date - String
    
    /**
     *  Get string representation of date.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String, timeZone: TimeZone, locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        
        return dateFormatter.string(from: self)
    }
    
    /**
     *  Get string representation of date.
     *  Locale is automatically selected as the current locale of the system.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *  - parameter timeZone: The time zone of the date
     *
     *  - returns: Representation of the date (self) in the specified format
     */
    func format(with dateFormat: String, timeZone: TimeZone) -> String {
        #if os(Linux)
            return format(with: dateFormat, timeZone: timeZone, locale: Locale.current)
        #else
            return format(with: dateFormat, timeZone: timeZone, locale: Locale.autoupdatingCurrent)
        #endif
    }
    
    /**
     *  Get string representation of date.
     *  Time zone is automatically selected as the current time zone of the system.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *  - parameter locale: Encapsulates information about linguistic, cultural, and technological conventions and standards
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String, locale: Locale) -> String {
        return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: locale)
    }
    
    /**
     *  Get string representation of date.
     *  Locale and time zone are automatically selected as the current locale and time zone of the system.
     *
     *  - parameter dateFormat: The date format string, according to Apple's date formatting guide in which to represent the date
     *
     *  - returns: Represenation of the date (self) in the specified format
     */
    func format(with dateFormat: String) -> String {
        #if os(Linux)
            return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.current)
        #else
            return format(with: dateFormat, timeZone: TimeZone.autoupdatingCurrent, locale: Locale.autoupdatingCurrent)
        #endif
    }
}

/**
 * TimeChunk represents an abstract collection of `DateComponent`s intended for use in date manipulation. A `TimeChunk` differs from a
 * TimeInterval in that the former depends on the `Calendar` class (and takes into account daylight savings, leap year, etc.) while the
 * latter depends on hard, second based adjustments that are independent from calendar constructs.
 *
 * In essence, TimeChunk is meant to be a thin, more flexible layer over the `Calender` and `DateComponent` classes for ease of use.
 * `TimeChunk`s may be created either by calling the provided initializer or shorthand like `2.days`. TimeChunks are manipulable and combine
 * using basic arithmetic operators like + and -.
 *
 * For more information about the utility of TimeChunks in relation to Dates, see the `Date+Manipulations` class.
 */
public struct TimeChunk {
    
    // MARK: - Variables
    
    public var seconds = 0
    public var minutes = 0
    public var hours = 0
    public var days = 0
    public var weeks = 0
    public var months = 0
    public var years = 0
    
    public init() {}
    
    public init(seconds: Int, minutes: Int, hours: Int, days: Int, weeks: Int, months: Int, years: Int) {
        self.seconds = seconds
        self.minutes = minutes
        self.hours = hours
        self.days = days
        self.weeks = weeks
        self.months = months
        self.years = years
    }
    
    
    // MARK: - Comparisons
    
    /**
     *  Check if two `TimeChunk`s are equal.
     *
     * - parameter chunk: `TimeChunk` to compare with self
     *
     * - returns: If all components in both `TimeChunk`s are equal
     */
    public func equals(chunk: TimeChunk) -> Bool {
        return (seconds == chunk.seconds && minutes == chunk.minutes && hours == chunk.hours && days == chunk.days && weeks == chunk.weeks && months == chunk.months && years == chunk.years)
    }
    
    
    // MARK: - Conversion
    
    /**
     *  Generic conversion method. Years are taken to mean
     *  365 days. This method should not be used for accurate
     *  date operations. Ex. 456.days.to(.years) will return 1.
     *
     *  ! Months are not supported for conversions. They are not a
     *  well defined unit of time without the context of a calendar. !
     */
    public func to(_ unit: TimeUnits) -> Int {
        if self.months != 0 {
            print("Months are not supported for conversion due to their uncertain number of days.")
            return 0
        }
        if (unit == .seconds) {
            var total = self.seconds
            total += self.minutes * 60
            total += self.hours * 60 * 60
            total += self.days * 24 * 60 * 60
            total += self.weeks * 7 * 24 * 60 * 60
            total += self.years * 365 * 24 * 60 * 60
            return total
        } else if (unit == .minutes) {
            var total = self.minutes
            total += self.seconds / 60
            total += self.hours * 60
            total += self.days * 24 * 60
            total += self.weeks * 7 * 24 * 60
            total += self.years * 365 * 24 * 60
            return total
        } else if (unit == .hours) {
            var total = self.hours
            let secondsToMinutes = self.seconds / 60
            total += (self.minutes + secondsToMinutes) / 60
            total += self.days * 24
            total += self.weeks * 7 * 24
            total += self.years * 365 * 24
            return total
        } else if (unit == .days) {
            var total = self.days
            let secondsToMinutes = self.seconds / 60
            let minutesToHours = (self.minutes + secondsToMinutes) / 60
            total += (self.hours + minutesToHours) / 24
            total += self.weeks * 7
            total += self.years * 365
            return total
        } else if (unit == .weeks) {
            var total = self.weeks
            let secondsToMinutes = self.seconds / 60
            let minutesToHours = (self.minutes + secondsToMinutes) / 60
            let hoursToDays = (self.hours + minutesToHours) / 24
            total += (self.days + hoursToDays) / 7
            total += self.years * 52
            return total
        } else if (unit == .years) {
            var total = self.years
            let secondsToMinutes = self.seconds / 60
            let minutesToHours = (self.minutes + secondsToMinutes) / 60
            let hoursToDays = (self.hours + minutesToHours) / 24
            let weeksToDays = weeks * 7
            total += (self.days + hoursToDays + weeksToDays) / 365
            return total
        }
        return 0
    }
    
    
    // MARK: - Date Creation
    
    /**
     *  Returns the current date decreased by the amount in self
     */
    public var earlier: Date {
        return earlier(than: Date())
    }
    
    /**
     *  Returns the current date increased by the amount in self
     */
    public var later: Date {
        return later(than: Date())
    }
    
    /**
     *  Returns the given date decreased by the amount in self.
     *
     * - parameter date: The date to decrease
     *
     * - returns: A new date with components decreased according to the variables of self
     */
    public func earlier(than date: Date) -> Date {
        return date.subtract(self)
    }
    
    /**
     *  Returns the given date increased by the amount in self.
     *
     * - parameter date: The date to increase
     *
     * - returns: A new date with components increased according to the variables of self
     */
    public func later(than date: Date) -> Date {
        return date.add(self)
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: In Place
    
    /**
     *  Increase the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to increase self by
     *
     * - returns: The `TimeChunk` with variables increased
     */
    public func lengthened(by chunk: TimeChunk) -> TimeChunk {
        var newChunk = TimeChunk()
        newChunk.seconds = seconds + chunk.seconds
        newChunk.minutes = minutes + chunk.minutes
        newChunk.hours = hours + chunk.hours
        newChunk.days = days + chunk.days
        newChunk.weeks = weeks + chunk.weeks
        newChunk.months = months + chunk.months
        newChunk.years = years + chunk.years
        
        return newChunk
    }
    
    /**
     *  Decrease the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to decrease self by
     *
     * - returns: The `TimeChunk` with variables decreased
     */
    public func shortened(by chunk: TimeChunk) -> TimeChunk {
        var newChunk = TimeChunk()
        newChunk.seconds = seconds - chunk.seconds
        newChunk.minutes = minutes - chunk.minutes
        newChunk.hours = hours - chunk.hours
        newChunk.days = days - chunk.days
        newChunk.weeks = weeks - chunk.weeks
        newChunk.months = months - chunk.months
        newChunk.years = years - chunk.years
        
        return newChunk
    }
    
    
    // MARK: Mutation
    
    /**
     *  In place, increase the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to increase self by
     */
    public mutating func lengthen(by chunk: TimeChunk) {
        seconds += chunk.seconds
        minutes += chunk.minutes
        hours += chunk.hours
        days += chunk.days
        weeks += chunk.weeks
        months += chunk.months
        years += chunk.years
    }
    
    /**
     *  In place, decrease the variables of self (`TimeChunk`) by the variables of the given `TimeChunk`.
     *
     * - parameter chunk: The `TimeChunk` to decrease self by
     */
    public mutating func shorten(by chunk: TimeChunk) {
        seconds -= chunk.seconds
        minutes -= chunk.minutes
        hours -= chunk.hours
        days -= chunk.days
        weeks -= chunk.weeks
        months -= chunk.months
        years -= chunk.years
    }
    
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for adding two `TimeChunk`s
     */
    public static func +(leftAddend: TimeChunk, rightAddend: TimeChunk) -> TimeChunk {
        return leftAddend.lengthened(by: rightAddend)
    }
    
    /**
     *  Operator overload for subtracting two `TimeChunk`s
     */
    public static func -(minuend: TimeChunk, subtrahend: TimeChunk) -> TimeChunk {
        return minuend.shortened(by: subtrahend)
    }
    
    /**
     *  Operator overload for checking if two `TimeChunk`s are equal
     */
    public static func ==(left: TimeChunk, right: TimeChunk) -> Bool {
        return left.equals(chunk: right)
    }
    
    /**
     *  Operator overload for inverting (negating all variables) a `TimeChunk`
     */
    public static prefix func -(chunk: TimeChunk) -> TimeChunk {
        var invertedChunk = chunk;
        invertedChunk.seconds = -chunk.seconds
        invertedChunk.minutes = -chunk.minutes
        invertedChunk.hours = -chunk.hours
        invertedChunk.days = -chunk.days
        invertedChunk.weeks = -chunk.weeks
        invertedChunk.months = -chunk.months
        invertedChunk.years = -chunk.years
        return invertedChunk
    }
    
}




/**
 *  In DateTools, time periods are represented by the TimePeriod protocol.
 *  Required variables and method impleementations are bound below. An inheritable
 *  implementation of the TimePeriodProtocol is available through the TimePeriodClass
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
public protocol TimePeriodProtocol {
    
    // MARK: - Variables
    
    /**
     *  The start date for a TimePeriod representing the starting boundary of the time period
     */
    var beginning: Date? {get set}
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    var end: Date? {get set}
}

public extension TimePeriodProtocol {
    
    
    // MARK: - Information
    
    /**
     *  True if the `TimePeriod`'s duration is zero
     */
    var isMoment: Bool {
        return self.beginning == self.end
    }
    
    /**
     *  The duration of the `TimePeriod` in years.
     *  Returns the max int if beginning or end are nil.
     */
    var years: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.yearsEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in weeks.
     *  Returns the max int if beginning or end are nil.
     */
    var weeks: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.weeksEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in days.
     *  Returns the max int if beginning or end are nil.
     */
    var days: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.daysEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in hours.
     *  Returns the max int if beginning or end are nil.
     */
    var hours: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.hoursEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in minutes.
     *  Returns the max int if beginning or end are nil.
     */
    var minutes: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.minutesEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in seconds.
     *  Returns the max int if beginning or end are nil.
     */
    var seconds: Int {
        if self.beginning != nil && self.end != nil {
            return self.beginning!.secondsEarlier(than: self.end!)
        }
        return Int.max
    }
    
    /**
     *  The duration of the `TimePeriod` in a time chunk.
     *  Returns a time chunk with all zeroes if beginning or end are nil.
     */
    var chunk: TimeChunk {
        if beginning != nil && end != nil {
            return beginning!.chunkBetween(date: end!)
        }
        return TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
    /**
     *  The length of time between the beginning and end dates of the
     * `TimePeriod` as a `TimeInterval`.
     */
    var duration: TimeInterval {
        if self.beginning != nil && self.end != nil {
            return abs(self.beginning!.timeIntervalSince(self.end!))
        }
        
        return TimeInterval(Double.greatestFiniteMagnitude)
    }
    
    
    // MARK: - Time Period Relationships
    
    /**
     *  The relationship of the self `TimePeriod` to the given `TimePeriod`.
     *  Relations are stored in Enums.swift. Formal defnitions available in the provided
     *  links:
     *  [GitHub](https://github.com/MatthewYork/DateTools#relationships),
     *  [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: The relationship between self and the given time period
     */
    func relation(to period: TimePeriodProtocol) -> Relation {
        //Make sure that all start and end points exist for comparison
        if (self.beginning != nil && self.end != nil && period.beginning != nil && period.end != nil) {
            //Make sure time periods are of positive durations
            if (self.beginning!.isEarlier(than: self.end!) && period.beginning!.isEarlier(than: period.end!)) {
                
                //Make comparisons
                if (period.end!.isEarlier(than: self.beginning!)) {
                    return .after
                }
                else if (period.end!.equals(self.beginning!)) {
                    return .startTouching
                }
                else if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.isEarlier(than: self.end!)) {
                    return .startInside
                }
                else if (period.beginning!.equals(self.beginning!) && period.end!.isLater(than: self.end!)) {
                    return .insideStartTouching
                }
                else if (period.beginning!.equals(self.beginning!) && period.end!.isEarlier(than: self.end!)) {
                    return .enclosingStartTouching
                }
                else if (period.beginning!.isLater(than: self.beginning!) && period.end!.isEarlier(than: self.end!)) {
                    return .enclosing
                }
                else if (period.beginning!.isLater(than: self.beginning!) && period.end!.equals(self.end!)) {
                    return .enclosingEndTouching
                }
                else if (period.beginning!.equals(self.beginning!) && period.end!.equals(self.end!)) {
                    return .exactMatch
                }
                else if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.isLater(than: self.end!)) {
                    return .inside
                }
                else if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.equals(self.end!)) {
                    return .insideEndTouching
                }
                else if (period.beginning!.isEarlier(than: self.end!) && period.end!.isLater(than: self.end!)) {
                    return .endInside
                }
                else if (period.beginning!.equals(self.end!) && period.end!.isLater(than: self.end!)) {
                    return .endTouching
                }
                else if (period.beginning!.isLater(than: self.end!)) {
                    return .before
                }
            }
        }
        
        return .none;
    }
    
    /**
     *  If `self.beginning` and `self.end` are equal to the beginning and end of the
     *  given `TimePeriod`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if the periods are the same
     */
    func equals(_ period: TimePeriodProtocol) -> Bool {
        return self.beginning == period.beginning && self.end == period.end
    }
    
    /**
     *  If the given `TimePeriod`'s beginning is before `self.beginning` and
     *  if the given 'TimePeriod`'s end is after `self.end`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if self is inside of the given `TimePeriod`
     */
    func isInside(of period: TimePeriodProtocol) -> Bool {
        return period.beginning!.isEarlierThanOrEqual(to: self.beginning!) && period.end!.isLaterThanOrEqual(to: self.end!)
    }
    
    /**
     *  If the given Date is after `self.beginning` and before `self.end`.
     *
     * - parameter period: The time period to compare to self
     * - parameter interval: Whether the edge of the date is included in the calculation
     *
     * - returns: True if the given `TimePeriod` is inside of self
     */
    func contains(_ date: Date, interval: Interval) -> Bool {
        if (interval == .open) {
            return self.beginning!.isEarlier(than: date) && self.end!.isLater(than: date)
        }
        else if (interval == .closed){
            return (self.beginning!.isEarlierThanOrEqual(to: date) && self.end!.isLaterThanOrEqual(to: date))
        }
        
        return false
    }
    
    /**
     *  If the given `TimePeriod`'s beginning is after `self.beginning` and
     *  if the given 'TimePeriod`'s after is after `self.end`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if the given `TimePeriod` is inside of self
     */
    func contains(_ period: TimePeriodProtocol) -> Bool {
        return self.beginning!.isEarlierThanOrEqual(to: period.beginning!) && self.end!.isLaterThanOrEqual(to: period.end!)
    }
    
    /**
     *  If self and the given `TimePeriod` share any sub-`TimePeriod`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if there is a period of time that is shared by both `TimePeriod`s
     */
    func overlaps(with period: TimePeriodProtocol) -> Bool {
        //Outside -> Inside
        if (period.beginning!.isEarlier(than: self.beginning!) && period.end!.isLater(than: self.beginning!)) {
            return true
        }
            //Enclosing
        else if (period.beginning!.isLaterThanOrEqual(to: self.beginning!) && period.end!.isEarlierThanOrEqual(to: self.end!)){
            return true
        }
            //Inside -> Out
        else if(period.beginning!.isEarlier(than: self.end!) && period.end!.isLater(than: self.end!)){
            return true
        }
        return false
    }
    
    /**
     *  If self and the given `TimePeriod` overlap or the period's edges touch.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if there is a period of time or moment that is shared by both `TimePeriod`s
     */
    func intersects(with period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) != .after && self.relation(to: period) != .before
    }
    
    /**
     *  If self and the given `TimePeriod` have no overlap or touching edges.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if there is a period of time between self and the given `TimePeriod` not contained by either period
     */
    func hasGap(between period: TimePeriodProtocol) -> Bool {
        return self.isBefore(period: period) || self.isAfter(period: period)
    }
    
    /**
     *  The period of time between self and the given `TimePeriod` not contained by either.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: The gap between the periods. Zero if there is no gap.
     */
    func gap(between period: TimePeriodProtocol) -> TimeInterval {
        if (self.end!.isEarlier(than: period.beginning!)) {
            return abs(self.end!.timeIntervalSince(period.beginning!));
        }
        else if (period.end!.isEarlier(than: self.beginning!)){
            return abs(period.end!.timeIntervalSince(self.beginning!));
        }
        return 0
    }
    
    /**
     *  The period of time between self and the given `TimePeriod` not contained by either
     *  as a `TimeChunk`.
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: The gap between the periods, zero if there is no gap
     */
    func gap(between period: TimePeriodProtocol) -> TimeChunk? {
        if self.end != nil && period.beginning != nil {
            return (self.end?.chunkBetween(date: period.beginning!))!
        }
        return nil
    }
    
    /**
     *  If self is after the given `TimePeriod` chronologically. (A gap must exist between the two).
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if self is after the given `TimePeriod`
     */
    func isAfter(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .after
    }
    
    /**
     *  If self is before the given `TimePeriod` chronologically. (A gap must exist between the two).
     *
     * - parameter period: The time period to compare to self
     *
     * - returns: True if self is after the given `TimePeriod`
     */
    func isBefore(period: TimePeriodProtocol) -> Bool {
        return self.relation(to: period) == .before
    }
    
    // MARK: - Shifts
    
    //MARK: In Place
    
    /**
     *  In place, shift the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to shift the period by
     */
    mutating func shift(by timeInterval: TimeInterval) {
        self.beginning?.addTimeInterval(timeInterval)
        self.end?.addTimeInterval(timeInterval)
    }
    
    /**
     *  In place, shift the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to shift the period by
     */
    mutating func shift(by chunk: TimeChunk) {
        self.beginning = self.beginning?.add(chunk)
        self.end = self.end?.add(chunk)
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: In Place
    
    
    /**
     *  In place, lengthen the `TimePeriod`, anchored at the beginning, end or center
     *
     * - parameter timeInterval: The time interval to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    mutating func lengthen(by timeInterval: TimeInterval, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.addingTimeInterval(timeInterval)
            break
        case .center:
            self.beginning = self.beginning?.addingTimeInterval(-timeInterval/2.0)
            self.end = self.end?.addingTimeInterval(timeInterval/2.0)
            break
        case .end:
            self.beginning = self.beginning?.addingTimeInterval(-timeInterval)
            break
        }
    }
    
    /**
     *  In place, lengthen the `TimePeriod`, anchored at the beginning or end
     *
     * - parameter chunk: The time chunk to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    mutating func lengthen(by chunk: TimeChunk, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.add(chunk)
            break
        case .center:
            // Do not lengthen by TimeChunk at center
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            self.beginning = self.beginning?.subtract(chunk)
            break
        }
    }
    
    /**
     *  In place, shorten the `TimePeriod`, anchored at the beginning, end or center
     *
     * - parameter timeInterval: The time interval to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    mutating func shorten(by timeInterval: TimeInterval, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.addingTimeInterval(-timeInterval)
            break
        case .center:
            self.beginning = self.beginning?.addingTimeInterval(timeInterval/2.0)
            self.end = self.end?.addingTimeInterval(-timeInterval/2.0)
            break
        case .end:
            self.beginning = self.beginning?.addingTimeInterval(timeInterval)
            break
        }
    }
    
    /**
     *  In place, shorten the `TimePeriod`, anchored at the beginning or end
     *
     * - parameter chunk: The time chunk to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     */
    mutating func shorten(by chunk: TimeChunk, at anchor: Anchor) {
        switch anchor {
        case .beginning:
            self.end = self.end?.subtract(chunk)
            break
        case .center:
            // Do not shorten by TimeChunk at center
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            self.beginning = self.beginning?.add(chunk)
            break
        }
    }
}

/**
 *  In DateTools, time periods are represented by the case TimePeriod class
 *  and come with a suite of initializaiton, manipulation, and comparison methods
 *  to make working with them a breeze.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-periods) for more information.
 */
open class TimePeriod: TimePeriodProtocol {
    
    // MARK: - Variables
    /**
     *  The start date for a TimePeriod representing the starting boundary of the time period
     */
    public var beginning: Date?
    
    /**
     *  The end date for a TimePeriod representing the ending boundary of the time period
     */
    public var end: Date?
    
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    public init(beginning: Date?, end: Date?) {
        self.beginning = beginning
        self.end = end
    }
    
    public init(beginning: Date, duration: TimeInterval) {
        self.beginning = beginning
        self.end = beginning + duration
    }
    
    public init(end: Date, duration: TimeInterval) {
        self.end = end
        self.beginning = end.addingTimeInterval(-duration)
    }
    
    public init(beginning: Date, chunk: TimeChunk) {
        self.beginning = beginning
        self.end = beginning + chunk
    }
    
    public init(end: Date, chunk: TimeChunk) {
        self.end = end
        self.beginning = end - chunk
    }
    
    public init(chunk: TimeChunk) {
        self.beginning = Date()
        self.end = self.beginning?.add(chunk)
    }
    
    
    // MARK: - Shifted
    
    /**
     *  Shift the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to shift the period by
     *
     * - returns: The new, shifted `TimePeriod`
     */
    public func shifted(by timeInterval: TimeInterval) -> TimePeriod {
        let timePeriod = TimePeriod()
        timePeriod.beginning = self.beginning?.addingTimeInterval(timeInterval)
        timePeriod.end = self.end?.addingTimeInterval(timeInterval)
        return timePeriod
    }
    
    /**
     *  Shift the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to shift the period by
     *
     * - returns: The new, shifted `TimePeriod`
     */
    public func shifted(by chunk: TimeChunk) -> TimePeriod {
        let timePeriod = TimePeriod()
        timePeriod.beginning = self.beginning?.add(chunk)
        timePeriod.end = self.end?.add(chunk)
        return timePeriod
    }
    
    // MARK: - Lengthen / Shorten
    
    // MARK: New
    
    /**
     *  Lengthen the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, lengthened `TimePeriod`
     */
    public func lengthened(by timeInterval: TimeInterval, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = self.beginning
            timePeriod.end = self.end?.addingTimeInterval(timeInterval)
            break
        case .center:
            timePeriod.beginning = self.beginning?.addingTimeInterval(-timeInterval)
            timePeriod.end = self.end?.addingTimeInterval(timeInterval)
            break
        case .end:
            timePeriod.beginning = self.beginning?.addingTimeInterval(-timeInterval)
            timePeriod.end = self.end
            break
        }
        
        return timePeriod
    }
    
    /**
     *  Lengthen the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to lengthen the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, lengthened `TimePeriod`
     */
    public func lengthened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = beginning
            timePeriod.end = end?.add(chunk)
            break
        case .center:
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            timePeriod.beginning = beginning?.add(-chunk)
            timePeriod.end = end
            break
        }
        
        return timePeriod
    }
    
    /**
     *  Shorten the `TimePeriod` by a `TimeInterval`
     *
     * - parameter timeInterval: The time interval to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, shortened `TimePeriod`
     */
    public func shortened(by timeInterval: TimeInterval, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = beginning
            timePeriod.end = end?.addingTimeInterval(-timeInterval)
            break
        case .center:
            timePeriod.beginning = beginning?.addingTimeInterval(-timeInterval/2)
            timePeriod.end = end?.addingTimeInterval(timeInterval/2)
            break
        case .end:
            timePeriod.beginning = beginning?.addingTimeInterval(timeInterval)
            timePeriod.end = end
            break
        }
        
        return timePeriod
    }
    
    /**
     *  Shorten the `TimePeriod` by a `TimeChunk`
     *
     * - parameter chunk: The time chunk to shorten the period by
     * - parameter anchor: The anchor point from which to make the change
     *
     * - returns: The new, shortened `TimePeriod`
     */
    public func shortened(by chunk: TimeChunk, at anchor: Anchor) -> TimePeriod {
        let timePeriod = TimePeriod()
        switch anchor {
        case .beginning:
            timePeriod.beginning = beginning
            timePeriod.end = end?.subtract(chunk)
            break
        case .center:
            print("Mutation via chunk from center anchor is not supported.")
            break
        case .end:
            timePeriod.beginning = beginning?.add(-chunk)
            timePeriod.end = end
            break
        }
        
        return timePeriod
    }
    
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for checking if two `TimePeriod`s are equal
     */
    public static func ==(leftAddend: TimePeriod, rightAddend: TimePeriod) -> Bool {
        return leftAddend.equals(rightAddend)
    }
    
    // Default anchor = beginning
    /**
     *  Operator overload for lengthening a `TimePeriod` by a `TimeInterval`
     */
    public static func +(leftAddend: TimePeriod, rightAddend: TimeInterval) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .beginning)
    }
    
    /**
     *  Operator overload for lengthening a `TimePeriod` by a `TimeChunk`
     */
    public static func +(leftAddend: TimePeriod, rightAddend: TimeChunk) -> TimePeriod {
        return leftAddend.lengthened(by: rightAddend, at: .beginning)
    }
    
    // Default anchor = beginning
    /**
     *  Operator overload for shortening a `TimePeriod` by a `TimeInterval`
     */
    public static func -(minuend: TimePeriod, subtrahend: TimeInterval) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .beginning)
    }
    
    /**
     *  Operator overload for shortening a `TimePeriod` by a `TimeChunk`
     */
    public static func -(minuend: TimePeriod, subtrahend: TimeChunk) -> TimePeriod {
        return minuend.shortened(by: subtrahend, at: .beginning)
    }
    
    /**
     *  Operator overload for checking if a `TimePeriod` is equal to a `TimePeriodProtocol`
     */
    public static func ==(left: TimePeriod, right: TimePeriodProtocol) -> Bool {
        return left.equals(right)
    }
}



/**
 *  Time period chains serve as a tightly coupled set of time periods. They are
 *  always organized by start and end date, and have their own characteristics like
 *  a StartDate and EndDate that are extrapolated from the time periods within. Time
 *  period chains do not allow overlaps within their set of time periods. This type of
 *  group is ideal for modeling schedules like sequential meetings or appointments.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-chains) for more information.
 */
open class TimePeriodChain: TimePeriodGroup {
    
    // MARK: - Chain Existence Manipulation
    
    /**
     *  Append a TimePeriodProtocol to the periods array and update the Chain's
     *  beginning and end.
     *
     * - parameter period: TimePeriodProtocol to add to the collection
     */
    public func append(_ period: TimePeriodProtocol) {
        let beginning = (self.periods.count > 0) ? self.periods.last!.end! : period.beginning
        
        let newPeriod = TimePeriod(beginning: beginning!, duration: period.duration)
        self.periods.append(newPeriod)
        
        //Update updateExtremes
        if periods.count == 1 {
            _beginning = period.beginning
            _end = period.end
        }
        else {
            _end = _end?.addingTimeInterval(period.duration)
        }
    }
    
    /**
     *  Append a TimePeriodProtocol array to the periods array and update the Chain's
     *  beginning and end.
     *
     * - parameter periodArray: TimePeriodProtocol list to add to the collection
     */
    public func append<G: TimePeriodGroup>(contentsOf group: G) {
        for period in group.periods {
            let beginning = (self.periods.count > 0) ? self.periods.last!.end! : period.beginning
            
            let newPeriod = TimePeriod(beginning: beginning!, duration: period.duration)
            self.periods.append(newPeriod)
            
            //Update updateExtremes
            if periods.count == 1 {
                _beginning = period.beginning
                _end = period.end
            }
            else {
                _end = _end?.addingTimeInterval(period.duration)
            }
        }
    }
    
    /**
     *  Insert period into periods array at given index.
     *
     * - parameter newElement: The period to insert
     * - parameter index: Index to insert period at
     */
    public func insert(_ period: TimePeriodProtocol, at index: Int) {
        //Check for special zero case which takes the beginning date
        if index == 0 && period.beginning != nil && period.end != nil {
            //Insert new period
            periods.insert(period, at: index)
        }
        else if period.beginning != nil && period.end != nil {
            //Insert new period
            periods.insert(period, at: index)
        }
        else {
            print("All TimePeriods in a TimePeriodChain must contain a defined start and end date")
            return
        }
        
        //Shift all periods after inserted period
        for i in 0..<periods.count {
            if i > index && i > 0 {
                let currentPeriod = TimePeriod(beginning: period.beginning, end: period.end)
                periods[i].beginning = periods[i-1].end
                periods[i].end = periods[i].beginning!.addingTimeInterval(currentPeriod.duration)
            }
        }
        
        updateExtremes()
    }
    
    /**
     *  Remove from period array at the given index.
     *
     * - parameter at: The index in the collection to remove
     */
    public func remove(at index: Int) {
        //Retrieve duration of period to be removed
        let duration = periods[index].duration
        
        //Remove period
        periods.remove(at: index)
        
        //Shift all periods after inserted period
        for i in index..<periods.count {
            periods[i].shift(by: -duration)
        }
        updateExtremes()
    }
    
    /**
     *  Remove all periods from period array.
     */
    public func removeAll() {
        self.periods.removeAll()
        updateExtremes()
    }
    
    //MARK: - Chain Content Manipulation
    
    /**
     *  In place, shifts all chain time periods by a given time interval
     *
     * - parameter duration: The time interval to shift the period by
     */
    public func shift(by duration: TimeInterval) {
        for var period in self.periods {
            period.shift(by:duration)
        }
        
        _beginning = _beginning?.addingTimeInterval(duration)
        _end = _end?.addingTimeInterval(duration)
    }
    
    public override func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
        return try periods.map(transform)
    }
    
    public override func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
        return try periods.filter(isIncluded)
    }
    
    internal override func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
    }
    
    /**
     *  Removes the last object from the `TimePeriodChain` and returns it
     *
     */
    public func pop() -> TimePeriodProtocol? {
        let period = self.periods.popLast()
        updateExtremes()
        
        return period
    }
    
    internal func updateExtremes() {
        _beginning = periods.first?.beginning
        _end = periods.last?.end
    }
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for comparing `TimePeriodChain`s to each other
     */
    public static func ==(left: TimePeriodChain, right: TimePeriodChain) -> Bool {
        return left.equals(right)
    }
}




/**
 *  Time period collections serve as loose sets of time periods. They are
 *  unorganized unless you decide to sort them, and have their own characteristics
 *  like a `beginning` and `end` that are extrapolated from the time periods within. Time
 *  period collections allow overlaps within their set of time periods.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-collections) for more information.
 */
open class TimePeriodCollection: TimePeriodGroup {
    
    // MARK: - Collection Manipulation
    
    /**
     *  Append a TimePeriodProtocol to the periods array and check if the Collection's
     *  beginning and end should change.
     *
     * - parameter period: TimePeriodProtocol to add to the collection
     */
    public func append(_ period: TimePeriodProtocol) {
        periods.append(period)
        updateExtremes(period: period)
    }
    
    /**
     *  Append a TimePeriodProtocol array to the periods array and check if the Collection's
     *  beginning and end should change.
     *
     * - parameter periodArray: TimePeriodProtocol list to add to the collection
     */
    public func append(_ periodArray: [TimePeriodProtocol]) {
        for period in periodArray {
            periods.append(period)
            updateExtremes(period: period)
        }
    }
    
    /**
     *  Append a TimePeriodGroup's periods array to the periods array of self and check if the Collection's
     *  beginning and end should change.
     *
     * - parameter newPeriods: TimePeriodGroup to merge periods arrays with
     */
    public func append<C: TimePeriodGroup>(contentsOf newPeriods: C) {
        for period in newPeriods as TimePeriodGroup {
            periods.append(period)
            updateExtremes(period: period)
        }
    }
    
    /**
     *  Insert period into periods array at given index.
     *
     * - parameter newElement: The period to insert
     * - parameter index: Index to insert period at
     */
    public func insert(_ newElement: TimePeriodProtocol, at index: Int) {
        periods.insert(newElement, at: index)
        updateExtremes(period: newElement)
    }
    
    /**
     *  Remove from period array at the given index.
     *
     * - parameter at: The index in the collection to remove
     */
    public func remove(at: Int) {
        periods.remove(at: at)
        updateExtremes()
    }
    
    /**
     *  Remove all periods from period array.
     */
    public func removeAll() {
        periods.removeAll()
        updateExtremes()
    }
    
    
    // MARK: - Sorting
    
    // In place
    /**
     *  Sort periods array in place by beginning
     */
    public func sortByBeginning() {
        self.sort { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
            if period1.beginning == nil && period2.beginning == nil {
                return false
            } else if (period1.beginning == nil) {
                return true
            } else if (period2.beginning == nil) {
                return false
            } else {
                return period2.beginning! < period1.beginning!
            }
        }
    }
    
    /**
     *  Sort periods array in place
     */
    public func sort(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) {
        self.periods.sort(by: areInIncreasingOrder)
    }
    
    // New collection
    /**
     *  Return collection with sorted periods array by beginning
     *
     * - returns: Collection with sorted periods
     */
    public func sortedByBeginning() -> TimePeriodCollection {
        let array = self.periods.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
            if period1.beginning == nil && period2.beginning == nil {
                return false
            } else if (period1.beginning == nil) {
                return true
            } else if (period2.beginning == nil) {
                return false
            } else {
                return period2.beginning! < period1.beginning!
            }
        }
        let collection = TimePeriodCollection()
        collection.append(array)
        return collection
    }
    
    /**
     *  Return collection with sorted periods array
     *
     * - returns: Collection with sorted periods
     */
    public func sorted(by areInIncreasingOrder: (TimePeriodProtocol, TimePeriodProtocol) -> Bool) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        collection.append(self.periods.sorted(by: areInIncreasingOrder))
        return collection
    }
    
    
    // MARK: - Collection Relationship
    
    // Potentially use .reduce() instead of these functions
    /**
     *  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
     *  whose start and end dates fall completely inside the interval of the given `TimePeriod`.
     *
     * - parameter period: The period to compare each other period against
     *
     * - returns: Collection of periods inside the given period
     */
    public func allInside(in period: TimePeriodProtocol) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        // Filter by period
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.isInside(of: period)
        })
        return collection
    }
    
    /**
     *  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s containing
     *  the given date.
     *
     * - parameter date: The date to compare each period to
     *
     * - returns: Collection of periods intersected by the given date
     */
    public func periodsIntersected(by date: Date) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        // Filter by period
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.contains(date, interval: .closed)
        })
        return collection
    }
    
    /**
     *  Returns from the `TimePeriodCollection` a sub-collection of `TimePeriod`s
     *  containing either the start date or the end date--or both--of the given `TimePeriod`.
     *
     *  - parameter period: The period to compare each other period to
     *
     *  - returns: Collection of periods intersected by the given period
     */
    public func periodsIntersected(by period: TimePeriodProtocol) -> TimePeriodCollection {
        let collection = TimePeriodCollection()
        //Filter by periop
        collection.periods = self.periods.filter({ (timePeriod: TimePeriodProtocol) -> Bool in
            return timePeriod.intersects(with: period)
        })
        return collection
    }
    
    // MARK: - Map
    
    public func map(_ transform: (TimePeriodProtocol) throws -> TimePeriodProtocol) rethrows -> TimePeriodCollection {
        var mappedArray = [TimePeriodProtocol]()
        mappedArray = try periods.map(transform)
        let mappedCollection = TimePeriodCollection()
        for period in mappedArray {
            mappedCollection.periods.append(period)
            mappedCollection.updateExtremes(period: period)
        }
        return mappedCollection
    }
    
    // MARK: - Operator Overloads
    
    /**
     *  Operator overload for comparing `TimePeriodCollection`s to each other
     */
    public static func ==(left: TimePeriodCollection, right: TimePeriodCollection) -> Bool {
        return left.equals(right)
    }
    
    //MARK: - Helpers
    
    internal func updateExtremes(period: TimePeriodProtocol) {
        //Check incoming period against previous beginning and end date
        if self.count == 1 {
            _beginning = period.beginning
            _end = period.end
        } else {
            _beginning = nilOrEarlier(date1: _beginning, date2: period.beginning)
            _end = nilOrLater(date1: _end, date2: period.end)
        }
        
    }
    
    internal func updateExtremes() {
        if periods.count == 0 {
            _beginning = nil
            _end = nil
        } else {
            _beginning = periods[0].beginning
            _end = periods[0].end
            for i in 1..<periods.count {
                _beginning = nilOrEarlier(date1: _beginning, date2: periods[i].beginning)
                _end = nilOrEarlier(date1: _end, date2: periods[i].end)
            }
        }
    }
    
    internal func nilOrEarlier(date1: Date?, date2: Date?) -> Date? {
        if date1 == nil || date2 == nil {
            return nil
        } else {
            return date1!.earlierDate(date2!)
        }
    }
    
    internal func nilOrLater(date1: Date?, date2: Date?) -> Date? {
        if date1 == nil || date2 == nil {
            return nil
        } else {
            return date1!.laterDate(date2!)
        }
    }
}



/**
 *  Time period groups are the final abstraction of date and time in DateTools. Here, time
 *  periods are gathered and organized into something useful. There are two main types of time
 *  period groups, `TimePeriodCollection` and `TimePeriodChain`.
 *
 *  [Visit our github page](https://github.com/MatthewYork/DateTools#time-period-groups) for more information.
 */
open class TimePeriodGroup: Sequence {
    
    // MARK: - Variables
    
    /**
     *  The array of periods that define the group.
     */
    internal var periods: [TimePeriodProtocol] = []
    
    internal var _beginning: Date?
    internal var _end: Date?
    
    /**
     *  The earliest beginning date of a `TimePeriod` in the group.
     *  Nil if any `TimePeriod` in group has a nil beginning date (indefinite).
     *  (Read Only)
     */
    public var beginning: Date? {
        return _beginning
    }
    
    /**
     *  The latest end date of a `TimePeriod` in the group.
     *  Nil if any `TimePeriod` in group has a nil end date (indefinite).
     *  (Read Only)
     */
    public var end: Date? {
        return _end
    }
    
    /**
     *  The number of periods in the periods array.
     */
    public var count: Int {
        return periods.count
    }
    
    /**
     *  The total amount of time between the earliest and latest dates stored in the
     *  periods array. Nil if any beginning or end date in any contained period is nil.
     */
    public var duration: TimeInterval? {
        if beginning != nil && end != nil {
            return end!.timeIntervalSince(beginning!)
        }
        return nil
    }
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    // MARK: - Comparisons
    
    /**
     *  If `self.periods` contains the exact elements as the given group's periods array.
     *
     *  - parameter group: The group to compare to self
     *
     *  - returns: True if the periods arrays are the same
     */
    public func equals(_ group: TimePeriodGroup) -> Bool {
        return containSameElements(array1: self.periods, group.periods)
    }
    

    // MARK: - Sequence Protocol
    
    public func makeIterator() -> IndexingIterator<Array<TimePeriodProtocol>> {
        return periods.makeIterator()
    }
    
    public func map<T>(_ transform: (TimePeriodProtocol) throws -> T) rethrows -> [T] {
        return try periods.map(transform)
    }
    
    public func filter(_ isIncluded: (TimePeriodProtocol) throws -> Bool) rethrows -> [TimePeriodProtocol] {
        return try periods.filter(isIncluded)
    }
    
    public func forEach(_ body: (TimePeriodProtocol) throws -> Void) rethrows {
        return try periods.forEach(body)
    }
    
    public func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (TimePeriodProtocol) throws -> Bool) rethrows -> [AnySequence<TimePeriodProtocol>] {
        return try periods.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator).map(AnySequence.init)
    }
    
    subscript(index: Int) -> TimePeriodProtocol {
        get {
            return periods[index]
        }
    }
    
    internal func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, TimePeriodProtocol) throws -> Result) rethrows -> Result {
        return try periods.reduce(initialResult, nextPartialResult)
    }
    
    internal func containSameElements(array1: [TimePeriodProtocol], _ array2: [TimePeriodProtocol]) -> Bool {
        guard array1.count == array2.count else {
            return false // No need to sorting if they already have different counts
        }
        
        let compArray1: [TimePeriodProtocol] = array1.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
            if period1.beginning == nil && period2.beginning == nil {
                return false
            } else if (period1.beginning == nil) {
                return true
            } else if (period2.beginning == nil) {
                return false
            } else {
                return period2.beginning! < period1.beginning!
            }
        }
        let compArray2: [TimePeriodProtocol] = array2.sorted { (period1: TimePeriodProtocol, period2: TimePeriodProtocol) -> Bool in
            if period1.beginning == nil && period2.beginning == nil {
                return false
            } else if (period1.beginning == nil) {
                return true
            } else if (period2.beginning == nil) {
                return false
            } else {
                return period2.beginning! < period1.beginning!
            }
        }
        for x in 0..<compArray1.count {
            if !compArray1[x].equals(compArray2[x]) {
                return false
            }
        }
        return true
    }
}
