//
//  VideoViewController.swift
//  youTune
//
//  Created by Léo LEGRON on 23/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var videoDescription: UILabel!
    var descriptionVideo: String = ""
    var videoId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoId: videoId)
        self.videoDescription.text = descriptionVideo
        self.webView.navigationDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getVideo(videoId: String) {
        let html = "<a id=\"video\" href=\"https://www.youtube.com/embed/\(videoId)\"></a>"
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube.com"))
        webView.isOpaque = false
        webView.backgroundColor = UIColor.black
    }
}

extension VideoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let js = "document.getElementById('video').click();"
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
