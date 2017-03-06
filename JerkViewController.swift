//
//  JerkViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class JerkViewController: UIViewController {

    @IBOutlet weak var jerkInput: UITextField!
    
    @IBOutlet weak var jerkChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
        // Do any additional setup after loading the view.
    }

    @IBAction func addJerk(_ sender: Any) {

    if let value = jerkInput.text , value != "" {
    let jerkCount = JerkCount()
    jerkCount.count = (NumberFormatter().number(from: value)?.intValue)!
    jerkCount.save()
    jerkInput.text = ""
    }
    
    updateChartWithData()
}


func updateChartWithData() {
    var dataEntries: [BarChartDataEntry] = []
    let jerkCounts = getJerkCountsFromDatabase()
    jerkChart.chartDescription?.text = ""
    for i in 0..<jerkCounts.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(jerkCounts[i].count))
        dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(values: dataEntries, label: "Jerk Count")
    chartDataSet.colors = [UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)]
    let chartData = BarChartData(dataSet: chartDataSet)
    jerkChart.data = chartData
}


func getJerkCountsFromDatabase() -> Results<JerkCount> {
    do {
        let realm = try Realm()
        return realm.objects(JerkCount.self)
    } catch let error as NSError {
        fatalError(error.localizedDescription)
    }
}








}
