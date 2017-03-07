//
//  DietViewController.swift
//  FlatPig
//
//  Created by David Roddy on 3/6/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//


import WebKit
class DietViewController: UIViewController {
    

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.relishink.com"
        self.webView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)

    }
    
    

        
    
    
}
