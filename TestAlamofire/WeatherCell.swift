//
//  WeatherCell.swift
//  TestAlamofire
//
//  Created by Andre Boevink on 03/03/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCellInformation(forecast: ForeCast3Hrs)
    {
        var documentsDirectory: String?
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        dateLabel.text = forecast.date
        temperatureLabel.text = forecast.temperature
        weatherLabel.text = forecast.weather
        
        if !Utils.checkFileExists(file: "\(forecast.icon).png")
        {
            print("Not exists")
            Utils.downloadImage(icon: "\(forecast.icon).png")
        }
        var counter = 0
        while !Utils.checkFileExists(file: "\(forecast.icon).png") && counter < 25
        {
            counter += 1
            print("Downloading ...\(counter)")
        }
        
        if paths.count > 0
        {
            documentsDirectory = paths[0]
           let savePath = documentsDirectory! + "/\(forecast.icon).png"
            weatherIcon.image = UIImage(named: savePath)
            
        }
        
    }
    
}
