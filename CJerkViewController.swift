//
//  CJerkViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class CJerkViewController: UIViewController {

    @IBOutlet weak var cajInput: UITextField!
    
    @IBOutlet weak var cajChart: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func cajAddTapped(_ sender: Any) {
        
        if let value = cajInput.text , value != "" {
            let cJerkCount = CJerkCount()
            cJerkCount.count = (NumberFormatter().number(from: value)?.intValue)!
            cJerkCount.save()
            cajInput.text = ""
        }
        
        updateChartWithData()
    }
    
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let cJerkCounts = getCajCountsFromDatabase()
        for i in 0..<cJerkCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(cJerkCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Clean+Jerk Weight")
        let chartData = BarChartData(dataSet: chartDataSet)
        cajChart.data = chartData
    }
    
    
    func getCajCountsFromDatabase() -> Results<CJerkCount> {
        do {
            let realm = try Realm()
            return realm.objects(CJerkCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
}
