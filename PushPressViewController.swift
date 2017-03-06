//
//  PushPressViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class PushPressViewController: UIViewController {

    @IBOutlet weak var pushPressInput: UITextField!
    
    @IBOutlet weak var pushPressChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func addPushPress(_ sender: Any) {

        
        if let value = pushPressInput.text , value != "" {
            let pushPressCount = PushPressCount()
            pushPressCount.count = (NumberFormatter().number(from: value)?.intValue)!
            pushPressCount.save()
            pushPressInput.text = ""
            
        }
        updateChartWithData()
    }
    
    
    func updateChartWithData() {
        
        var dataEntries: [BarChartDataEntry] = []
        let pushPressCounts = getPushPressFromDatabase()
        for i in 0..<pushPressCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(pushPressCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Push Press Weight")
        pushPressChart.chartDescription?.text = ""
        chartDataSet.colors = [UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        pushPressChart.data = chartData
        
        
    }
    
    
    func getPushPressFromDatabase() -> Results<PushPressCount> {
        do {
            let realm = try Realm()
            return realm.objects(PushPressCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
}
