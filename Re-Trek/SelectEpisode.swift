//
//  SelectEpisode.swift
//  Re-Trek
//
//  Created by Austin Wood on 2016-05-22.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import Foundation


var episodes = [String: AnyObject]()


func selectEpisode() {
    
    episodes.removeAll()
    createDictionaryfromJSON()
    
    let index: Int = Int(arc4random_uniform(UInt32(episodes.count)))
    let randomEpisode = Array(episodes.values)[index]
    let randomID = randomEpisode["id"]
    
    print("next line is random episode detail from Settings VC")
    print(randomEpisode)
    print("next line is random episode ID from Settings VC")
    print(randomID)
    
    
    NSNotificationCenter.defaultCenter().postNotificationName("passEpisode", object: nil, userInfo: ["episodeID" : randomID!!])
    
    
}






func createDictionaryfromJSON() {
    var selectedSeries: [String] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    if let savedSeries = defaults.arrayForKey("SelectedSeries") {
        selectedSeries = savedSeries as! [String]
    } else {
        selectedSeries = ["The Original Series", "The Animated Series", "The Next Generation", "Deep Space Nine", "Voyager", "Enterprise"]
    }
    
    let url = NSBundle.mainBundle().URLForResource("episodes", withExtension: "json")
    let data = NSData(contentsOfURL: url!)
    
    do {
        
        let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        let jsonArray = jsonResult.valueForKey("episode") as! NSArray // "episode" is from root of JSON data
        
        for json in jsonArray {
            let series = json["series"] as? String
            if selectedSeries.contains(series!) {
                let id = json["id"] as? String
                episodes[id!] = json
            }
        }
        
    } catch {
        fatalError("Error uploading data")
    }
    
}