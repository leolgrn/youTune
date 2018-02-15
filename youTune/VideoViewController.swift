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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getVideo(videoId: String){
        let url = URL(string: "http://youtube.com/embed/\(videoId)")
        webView.load(URLRequest(url: url!))
    }

}
