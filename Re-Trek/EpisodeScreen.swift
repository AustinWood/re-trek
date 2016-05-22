//
//  EpisodeScreen.swift
//  Re-Trek
//
//  Created by Austin Wood on 2016-05-22.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class EpisodeScreen: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    @IBOutlet weak var stardateLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var lastWatchedLabel: UILabel!
    @IBOutlet weak var seriesImage: RoundedImage!
    
    var episodeID = [String: AnyObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayDetails:", name: "passEpisode", object: nil)
    }
    
    
    
    func displayDetails(notif: NSNotification) {
        
        print("next line is passed ID from Episode VC")
        print(notif.userInfo!["episodeID"]!)
        
        let url = NSBundle.mainBundle().URLForResource("episodes", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let jsonArray = jsonResult.valueForKey("episode") as! NSArray // "episode" is from root of JSON data
            
            for json in jsonArray {
                let id = json["id"] as? String
                if id == "\(notif.userInfo!["episodeID"]!)" {
                    
                    let title = json["title"]! as! String
                    titleLabel.text = title
                    
                    let season = json["season"]! as! String
                    let episode = json["episode"]! as! String
                    seasonEpisodeLabel.text = "Season \(season), Episode \(episode)"
                    
                    let stardate = json["stardate"]! as! String
                    stardateLabel.text = "Stardate: \(stardate)"
                    
                    let airDate = json["airDate"]! as! String
                    airDateLabel.text = "Original air date: \(airDate)"
                    
                    let index = id!.startIndex.advancedBy(3)
                    let series = id!.substringToIndex(index)
                    seriesImage.image = UIImage(named: series)
                    print(series)
                    
                    return
                }
            }
            
        } catch {
            fatalError("Error uploading data")
        }
    }
    
    
}