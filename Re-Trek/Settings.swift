//
//  Settings.swift
//  Re-Trek
//
//  Created by Austin Wood on 2016-05-22.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class Settings: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectAllButton: UIButton!
    
    
    let series = ["The Original Series", "The Animated Series", "The Next Generation", "Deep Space Nine", "Voyager", "Enterprise"]
    var selectedSeries: [String] = []
    var episodes = [String: AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }
    
    
    
    /////////////////
    ///// DATA //////
    /////////////////
    
    func saveData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(selectedSeries, forKey: "SelectedSeries")
        
    }
    
    func refreshData() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let savedSeries = defaults.arrayForKey("SelectedSeries") {
            selectedSeries = savedSeries as! [String]
        } else {
            selectedSeries = ["The Original Series", "The Animated Series", "The Next Generation", "Deep Space Nine", "Voyager", "Enterprise"]
            saveData()
        }
        
        seriesLabel.text = "Series: \(selectedSeries.count)/6"
        
        if selectedSeries.count == 6 {
            selectAllButton.setTitle("Deselect All", forState: .Normal)
        } else {
            selectAllButton.setTitle("Select All", forState: .Normal)
        }
        
        tableView.reloadData()
    }
    
    
    
    /////////////////////
    ///// TABLEVIEW /////
    /////////////////////
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        let seriesName = "\(series[indexPath.row])"
        
        cell.label.text = seriesName
        
        if selectedSeries.contains("\(seriesName)") {
            cell.backgroundColor = COLOR_GREEN.colorWithAlphaComponent(0.6)
        } else {
            cell.backgroundColor = COLOR_RED.colorWithAlphaComponent(0.6)
        }
        
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let seriesName = "\(series[indexPath.row])"
        
        if selectedSeries.contains("\(seriesName)") {
            let indexOfSeries = selectedSeries.indexOf(seriesName)
            selectedSeries.removeAtIndex(indexOfSeries!)
        } else {
            selectedSeries.append(seriesName)
        }
        
        tableView.reloadData()
        saveData()
        refreshData()
    }
    
    
    /////////////////
    ///// OTHER /////
    /////////////////
    
    @IBAction func selectAllPressed(sender: AnyObject) {
        if selectedSeries.count == 6 {
            selectedSeries.removeAll()
        } else {
            selectedSeries = ["The Original Series", "The Animated Series", "The Next Generation", "Deep Space Nine", "Voyager", "Enterprise"]
        }
        saveData()
        refreshData()
    }
    
    
    @IBAction func retrekPressed(sender: AnyObject) {
        
        if episodes.count == 0 {
            createDictionaryfromJSON()
        }
        
        let index: Int = Int(arc4random_uniform(UInt32(episodes.count)))
        let randomEpisode = Array(episodes.values)[index]
        print(randomEpisode)
        
    }
    
    func createDictionaryfromJSON() {
        
        let url = NSBundle.mainBundle().URLForResource("episodes", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let jsonArray = jsonResult.valueForKey("episode") as! NSArray // "episode" is from root of JSON data
            
            for json in jsonArray {
                let id = json["id"] as? String
                episodes[id!] = json
            }
            
        } catch {
            fatalError("Error uploading data")
        }
        
    }
    
    
}