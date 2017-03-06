//
//  CleanAndJerksViewController.swift
//  FlatPig
//
//  Created by David Roddy on 2/25/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class CleanAndJerksViewController: UIViewController {

    
    @IBOutlet weak var cajInput: UITextField!
    

    @IBOutlet weak var cajChart: BarChartView!
    
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChartWithData()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "New title"
        
    }
    
    @IBAction func cajAddTapped(_ sender: Any) {
        
        if let value = cajInput.text , value != "" {
            let cleanAndJerkCount = CleanAndJerkCount()
            cleanAndJerkCount.count = (NumberFormatter().number(from: value)?.intValue)!
            cleanAndJerkCount.save()
            cajInput.text = ""
            
        }
        updateChartWithData()
    }
    
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let cleanAndJerkCounts = getCleanAndJerkFromDatabase()
        for i in 0..<cleanAndJerkCounts.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(cleanAndJerkCounts[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Weight")
        chartDataSet.colors = [UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)]

  
        let chartData = BarChartData(dataSet: chartDataSet)
        cajChart.data = chartData
        
        
    }
    
    
    func getCleanAndJerkFromDatabase() -> Results<CleanAndJerkCount> {
        do {
            let realm = try Realm()
            return realm.objects(CleanAndJerkCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
    
    
}
