//
//  BenchViewController.swift
//  FlatPig
//
//  Created by David Roddy on 2/25/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class BenchViewController: UIViewController {

    @IBOutlet weak var benchInput: UITextField!

    @IBOutlet weak var benchChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
        // Do any additional setup after loading the view.


 
    }
    
  

    @IBAction func benchAddTapped(_ sender: Any)  {
        
        if let value = benchInput.text , value != "" {
            let benchCount = BenchCount()
            benchCount.count = (NumberFormatter().number(from: value)?.intValue)!
            benchCount.save()
            benchInput.text = ""
        }
        updateChartWithData()
    }

    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let benchCounts = getBenchCountsFromDatabase()
        benchChart.chartDescription?.text = ""
        for i in 0..<benchCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(benchCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Bench Count")
        chartDataSet.colors = [UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        benchChart.data = chartData
    }
    
    
    func getBenchCountsFromDatabase() -> Results<BenchCount> {
        do {
            let realm = try Realm()
            return realm.objects(BenchCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
}
