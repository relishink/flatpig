//
//  FrontSquatViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift


class FrontSquatViewController: UIViewController {

    
    @IBOutlet weak var frontSquatInput: UITextField!
    
    @IBOutlet weak var frontSquatChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func frontSquatAdd(_ sender: Any) {

        
        if let value = frontSquatInput.text , value != "" {
            let frontSquatCount = FrontSquatCount()
            frontSquatCount.count = (NumberFormatter().number(from: value)?.intValue)!
            frontSquatCount.save()
            frontSquatInput.text = ""
        }
        updateChartWithData()
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        frontSquatChart.chartDescription?.text = ""
        let frontSquatCounts = getFrontSquatCountsFromDatabase()
        for i in 0..<frontSquatCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(frontSquatCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Front Squat Weight")
        chartDataSet.colors = [UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        frontSquatChart.data = chartData
    }
    
    
    func getFrontSquatCountsFromDatabase() -> Results<FrontSquatCount> {
        do {
            let realm = try Realm()
            return realm.objects(FrontSquatCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    
    
    
    
    
}
