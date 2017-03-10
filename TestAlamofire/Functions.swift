//
//  Functions.swift
//  TestAlamofire
//
//  Created by Andre Boevink on 04/03/2017.
//  Copyright © 2017 Andre Boevink. All rights reserved.
//

import UIKit

class Utils: UIViewController
{
    
    class func checkFileExists(file: String) -> Bool
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(file)?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            return true
        } else
        {
            return false
        }
    }
    
    class func downloadImage(icon: String)
    {
        
        let myUrl = URL(string: "http://openweathermap.org/img/w/\(icon)")
        let task = URLSession.shared.dataTask(with: myUrl!)
        {
            (data, response, error) in
            let responseString = "\(response)"
            if responseString.range(of: "status code: 404") == nil
            {
                var documentsDirectory: String?
                var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                if paths.count > 0
                {
                    documentsDirectory = paths[0]
                    let savePath = documentsDirectory! + "/\(icon)"
                    FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
                    DispatchQueue.main.async
                        {
                    }
                }
            }
        }
        task.resume()
    }
}
