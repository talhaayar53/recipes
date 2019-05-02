//
//  DetailsViewController.swift
//  Yemektarifleri
//
//  Created by TALHA AYAR on 9.10.2018.
//  Copyright © 2018 TALHA AYAR. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    var urlString = ""
    override func viewDidLoad() {
        self.navigationItem.title = "Details"
        super.viewDidLoad()
webView.navigationDelegate = self
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        super.viewDidLoad()
        let url = URL(string: urlString)
        print(url)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    

  

}
