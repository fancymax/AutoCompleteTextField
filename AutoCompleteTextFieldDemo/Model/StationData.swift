//
//  StationDataService.swift
//  Train12306
//
//  Created by fancymax on 15/8/4.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Foundation

struct Station {
    //首字母拼音 比如 bj
    var FirstLetter:String
    //车站名
    var Name:String
    //电报码
    var Code:String
    //全拼
    var Spell:String
}

class Regex {
    let internalExpression: NSRegularExpression?
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        do {
            self.internalExpression = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        } catch let error1 as NSError {
            error = error1
            self.internalExpression = nil
        }
    }
    
    func getMatches(input: String) -> [[String]]? {
        var res = [[String]]()
        let myRange = NSMakeRange(0, input.characters.count)
        if let matches = self.internalExpression?.matchesInString(input, options: [], range:myRange)
        {
            for match in matches
            {
                var groupMatch = [String]()
                for i in 1..<match.numberOfRanges
                {
                    let rangeText = (input as NSString).substringWithRange(match.rangeAtIndex(i))
                    groupMatch.append(rangeText)
                }
                res.append(groupMatch)
            }
        }
        if res.count > 0{
            return res
        }
        else{
            return nil
        }
    }
}

// "https://kyfw.12306.cn/otn/resources/js/framework/station_name.js"
class StationData{
    
    var allStation:[Station]
    
    var allStationMap:[String:Station]
    
    init()
    {
        self.allStation = [Station]()
        self.allStationMap = [String:Station]()
        
        let path = NSBundle.mainBundle().pathForResource("station_name", ofType: "js")
        let stationInfo = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding) as String
        
        if let matches = Regex("@[a-z]+\\|([^\\|]+)\\|([a-z]+)\\|([a-z]+)\\|([a-z]+)\\|").getMatches(stationInfo)
        {
            for match in matches
            {
                let oneStation = Station(FirstLetter:match[3],Name:match[0],Code:match[1],Spell:match[2])
                self.allStation.append(oneStation)
                self.allStationMap[oneStation.Name] = oneStation
            }
        }
        else
        {
            print("match station fail")
        }
    }
}