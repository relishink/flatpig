//
//  SecondViewController.swift
//  FlatPig
//
//  Created by David Roddy on 2/25/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import UIKit

class LifsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBarController?.tabBar.barTintColor = UIColor.white
        tabBarController?.tabBar.tintColor = UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 255/255, green: 69/255, blue: 74/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    

}

