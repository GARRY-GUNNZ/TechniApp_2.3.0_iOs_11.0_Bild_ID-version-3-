//
//  MXFilmViewController.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 07/04/2017.
//  Copyright © 2017 COFELY_Technibook. All rights reserved.
//

import UIKit

class MXFilmViewController: UIViewController,UIWebViewDelegate {
           
        @IBOutlet weak var navigationTitle: UINavigationItem!
        
        @IBOutlet weak var webView: UIWebView!
        
        @IBOutlet var vueChargement: UIView!
        var navTitle:String!
        @IBOutlet weak var menuButton:UIBarButtonItem!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if revealViewController() != nil {
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
            }
            
            
            
            
            
            webView.delegate = self
            if let url = URL(string: "https://drive.google.com/drive/mobile/folders/0B4X54FRS2-bXZTduRk9aQmR6QWM?usp=drive_web") {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
            // Do any additional setup after loading the view, typically from a nib.
            // self.webView.loadRequest(URLRequest(url: Bundle.main.url(forResource: "index",
            // withExtension: "html", subdirectory: "faq")!))
        }
        
        @IBAction func backAction(_ sender: AnyObject) {
            if webView.canGoBack {
                webView.goBack()
            }
        }
        
        @IBAction func forwardAction(_ sender: AnyObject) {
            if webView.canGoForward {
                webView.goForward()
            }
        }
        
        @IBAction func refreshAction(_ sender: AnyObject) {
            webView.reload()
        }
        
        @IBAction func stopAction(_ sender: AnyObject) {
            webView.stopLoading()
        }
        
        func webViewDidStartLoad(_ webView: UIWebView) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            vueChargement.isHidden = false
        }
        
        func webViewDidFinishLoad(_ webView: UIWebView) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            vueChargement.isHidden = true
            
            navigationTitle.title = webView.stringByEvaluatingJavaScript(from: "document.title")
        }
        
        func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            vueChargement.isHidden = true
        }
        
    
    deinit {
        print( "la page googledrive est des-initialiez ")
    }
        
        
}
