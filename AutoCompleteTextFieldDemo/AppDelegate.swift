//
//  AppDelegate.swift
//  AutoCompleteTextFieldDemo
//
//  Created by fancymax on 15/12/12.
//  Copyright © 2015年 fancy. All rights reserved.
//

import Cocoa

//todo NSFormatter and NSTextFieldDelegte
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,AutoCompleteTableViewDelegate,NSTextFieldDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var textField: AutoCompleteTextField!
    @IBOutlet weak var textField2: AutoCompleteTextField!
    
    let stationData = StationData()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        self.textField.tableViewDelegate = self
        self.textField2.tableViewDelegate = self
        
        self.textField.delegate = self
        self.textField2.delegate = self
    }
    
    func textField(textField: NSTextField, completions words: [String], forPartialWordRange charRange: NSRange, indexOfSelectedItem index: Int) -> [String] {
        var matches = [String]()
        //先按简拼  再按全拼  并保留上一次的match
        for station in stationData.allStation
        {
            if let _ = station.FirstLetter.rangeOfString(textField.stringValue, options: NSStringCompareOptions.AnchoredSearch)
            {
                matches.append(station.Name)
            }
        }
        if(matches.count == 0)
        {
            for station in stationData.allStation
            {
                if let _ = station.Spell.rangeOfString(textField.stringValue, options: NSStringCompareOptions.AnchoredSearch)
                {
                    matches.append(station.Name)
                }
            }
        }
        //再按汉字
        if(matches.count == 0)
        {
            for station in stationData.allStation
            {
                if let _ = station.Name.rangeOfString(textField.stringValue, options: NSStringCompareOptions.AnchoredSearch)
                {
                    matches.append(station.Name)
                }
            }
        }
        
        return matches
    }
    
    func control(control: NSControl, isValidObject obj: AnyObject) -> Bool {
        let stationName = obj as! String
        let isError = stationData.allStation.contains{ element in
            return element.Name == stationName }
        return isError
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }


}

