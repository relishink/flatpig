//
//  DeadliftViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift


class DeadliftViewController: UIViewController {


    @IBOutlet weak var deadInput: UITextField!
    @IBOutlet weak var deadChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func deadLiftAdd(_ sender: Any) {
        
        if let value = deadInput.text , value != "" {
            let deadLiftCount = DeadLiftCount()
            deadLiftCount.count = (NumberFormatter().number(from: value)?.intValue)!
            deadLiftCount.save()
            deadInput.text = ""
        }
        updateChartWithData()
    }

    
    
    

    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let deadLiftCounts = getDeadLiftCountsFromDatabase()
        for i in 0..<deadLiftCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(deadLiftCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Deadlift Weight")
        let chartData = BarChartData(dataSet: chartDataSet)
        deadChart.data = chartData
    }
    
    
    func getDeadLiftCountsFromDatabase() -> Results<DeadLiftCount> {
        do {
            let realm = try Realm()
            return realm.objects(DeadLiftCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    
    }
    
    
}
