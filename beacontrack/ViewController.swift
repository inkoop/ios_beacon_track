//
//  ViewController.swift
//  beacontrack
//
//  Created by vivek vivek on 09/01/16.
//  Copyright (c) 2016 inkoop.in. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var todayLabel: UITextView!
    @IBOutlet weak var weekLabel: UITextView!
    @IBOutlet weak var monthLabel: UITextView!
    
    // let triggerManager = ESTTriggerManager()
    var todayData:String = "";
    var weekData:String = "";
    var monthData:String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData();
        // self.triggerManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        Alamofire.request(.GET, "https://inkoop-beacon-track.herokuapp.com/api/1/tracks.json?api_key=52f5f272c9267d683b18").responseJSON { response in
            let data = JSON(response.result.value!)
            self.todayData = data["response"]["today"].string!;
            self.weekData = data["response"]["week"].string!;
            self.monthData = data["response"]["month"].string!;
            self.renderData();
        }
    }
    
    func renderData(){
        todayLabel.text = "Time spent in office today - \(todayData)"
        weekLabel.text = "Time spent in office this week - \(weekData)"
        monthLabel.text = "Time spent in office this month - \(monthData)"
    }

    @IBAction func updateData(sender: UIButton) {
        fetchData();
    }

}
