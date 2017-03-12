//
//  TableViewController.swift
//  TestAlamofire
//
//  Created by Andre Boevink on 03/03/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import UIKit
import Alamofire

class TableVC: UITableViewController {
    
    var forecasts = [ForeCast3Hrs]()
    var myTimer: Timer?
    var weatherDictionaryFile: Dictionary<String,Any> = [:]
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        if Constants.allowForecastToBeLoaded
        {
            downloadForecast
                {
                    Constants.allowForecastToBeLoaded = false
                    self.myTimer = Timer.scheduledTimer(timeInterval: 10800, target: self, selector: #selector (self.enableDownload), userInfo: nil, repeats: true)
            }
        }
        else
        {
            let weatherDictionary = FileSaveHelper(fileName: "3HrForecast", fileExtension: .json, subDirectory: "3HrForecast", directory: .documentDirectory)
            do
            {
                
                weatherDictionaryFile = try weatherDictionary.getJSONData()
                handleData(weatherDictionary: weatherDictionaryFile)
                tableView.reloadData()
            }
            catch
            {
                print(error)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func saveTheData(weatherDictionary: Dictionary<String,Any>)
    {
        let forecastsFile = FileSaveHelper(fileName: "3HrForecast", fileExtension: .json, subDirectory: "3HrForecast", directory: .documentDirectory)
        do
        {
            try forecastsFile.saveFileWith(dataForJson: weatherDictionary as AnyObject)
            self.handleData(weatherDictionary: weatherDictionary)
        }
        catch
        {
            print(error)
        }
    }
    
    func handleData(weatherDictionary: Dictionary<String,Any>)
    {
        if let weatherList = weatherDictionary["list"] as? [Dictionary<String, Any>]
        {
            for object in weatherList
            {
                let forecast = ForeCast3Hrs(forecastDictionary: object)
                self.forecasts.append(forecast)
            }
        }
        
    }
    
    func enableDownload()
    {
        print("enableDownload \(Constants.allowForecastToBeLoaded)")
        Constants.allowForecastToBeLoaded = true
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return forecasts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecasts[indexPath.row]
            cell.configureCellInformation(forecast: forecast)
            return cell
        }
        return WeatherCell()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: false)
        return nil
    }
    
    // MARK:- Alamofire
    
    func downloadForecast(completion: @escaping () -> () ) {
        Alamofire.request(
            "http://api.openweathermap.org/data/2.5/forecast?q=Hengelo&mode=json&appid=ae4bfc24515b92974e0bd30b3ae046ec&units=metrics&cnt=12"
            )
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching data: \(response.result.error)")
                    completion( () )
                    return
                }
                print("Alamofire")
                
                if let weatherDictionary = response.result.value as? Dictionary<String, Any>
                {
                    self.saveTheData(weatherDictionary: weatherDictionary)
                }
                completion( () )
        }
    }
    
}
