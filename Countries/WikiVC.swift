//
//  WikiVC.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import UIKit
import WebKit

class WikiVC: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var wikiCode: String = ""
    
    override func loadView() {

        
        
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        let myURL = URL(string: "https://www.wikidata.org/wiki/\(wikiCode)")

        let myReq = URLRequest(url: myURL!)

        webView.load(myReq)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.absoluteString{
            if host.contains(wikiCode){
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
    
    
    
    deinit{
        print("DEBUG: deinit happend wiki")
    }

}
