//
//  PowerCleanViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift



class PowerCleanViewController: UIViewController {

    @IBOutlet weak var powerCleanInput: UITextField!
    
    @IBOutlet weak var powerCleanChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func addPowerClean(_ sender: Any) {

        
        if let value = powerCleanInput.text , value != "" {
            let powerCleanCount = PowerCleanCount()
            powerCleanCount.count = (NumberFormatter().number(from: value)?.intValue)!
            powerCleanCount.save()
            powerCleanInput.text = ""
        }
        updateChartWithData()
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let powerCleanCounts = getPowerCleanCountsFromDatabase()
        for i in 0..<powerCleanCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(powerCleanCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Power Clean Weight")
        let chartData = BarChartData(dataSet: chartDataSet)
        powerCleanChart.data = chartData
    }
    
    
    func getPowerCleanCountsFromDatabase() -> Results<PowerCleanCount> {
        do {
            let realm = try Realm()
            return realm.objects(PowerCleanCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    
    

}
