//
//  SquatViewController.swift
//  FlatPig
//
//  Created by David Roddy on 2/25/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift


class SquatViewController: UIViewController {

    @IBOutlet weak var squatInput: UITextField!
    
    @IBOutlet weak var squatChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()

        // Do any additional setup after loading the view.
    }

    @IBAction func squatAddTapped(_ sender: Any) {
        
        if let value = squatInput.text , value != "" {
            let visitorCount = VisitorCount()
            visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
            visitorCount.save()
            squatInput.text = ""
        }        
        updateChartWithData()
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let visitorCounts = getVisitorCountsFromDatabase()
        for i in 0..<visitorCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(visitorCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
        let chartData = BarChartData(dataSet: chartDataSet)
        squatChart.data = chartData
    }
    
    
    func getVisitorCountsFromDatabase() -> Results<VisitorCount> {
        do {
            let realm = try Realm()
            return realm.objects(VisitorCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    

}
