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
    
    
}