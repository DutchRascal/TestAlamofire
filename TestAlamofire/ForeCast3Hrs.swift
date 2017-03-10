//
//  ForeCast3HrsClass.swift
//  TestMap
//
//  Created by Andre Boevink on 26/02/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import UIKit

class ForeCast3Hrs
{
    var _date: String!
    var _temperature: String!
    var _weather: String!
    var _icon: String!
    
    var date: String
    {
        if _date == nil
        {
            _date = ""
        }
        return _date
    }
    
    var temperature: String
    {
        if _temperature == nil
        {
            _temperature = ""
        }
        return _temperature
    }
    
    var weather: String
    {
        if _weather == nil
        {
            _weather = ""
        }
        return _weather
    }
    
    var icon: String
    {
        if _icon == nil
        {
            _icon = ""
        }
        return _icon
    }
    
    init(forecastDict: Dictionary<String, Any>)
    {
        if let main = forecastDict["main"] as? Dictionary<String, Any>
        {
            if let temp = main["temp"] as? Double
            {
                self._temperature = "\(Double(round(10 * (temp - 273.15))) / 10)"
            }
        }
        if let dateText = forecastDict["dt_txt"] as? String {
            self._date = dateText
        }
        
        if let weatherDescription = forecastDict["weather"] as? [Dictionary<String, Any>]
        {
            if let description = weatherDescription[0]["description"] as? String
            {
                self._weather = description
            }
            if let icon = weatherDescription[0]["icon"] as? String
            {
                self._icon = icon
            }
        }
    }
}

