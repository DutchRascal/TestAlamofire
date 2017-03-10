//
//  ViewController.swift
//  TestAlamofire
//
//  Created by Andre Boevink on 03/03/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var forecast: ForeCast3Hrs!
    var forecasts = [ForeCast3Hrs]()
    var forecastLoaded = false
    var forecastLoadAllowed = true
    var forecasttimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "3HrForecast"
        {
            let navigation = segue.destination as! UINavigationController
            let viewController = navigation.topViewController as! TableVC
            print("Prepare: \(self.forecasts.count)")
            viewController.forecasts = forecasts
        }
    }
    
}

