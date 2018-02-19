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
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var starTextButton: UIButton!
    var favorites = Favorites()
    var descriptionVideo: String = ""
    var videoId: String = ""
    var videoImage: UIImage!
    var videoName: String = ""
    var videoChannel: String = ""
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.defaultColor
        self.videoDescription.textColor = UIColor.secondColor
        self.starTextButton.setTitleColor(UIColor.secondColor, for: [])

        getVideo(videoId: videoId)
        self.videoDescription.text = descriptionVideo
        self.webView.navigationDelegate = self
        self.isAFavorite()
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
    
    func isAFavorite() {
        let videoArr: [[String:Any]] = self.favorites.loadFavorites()
        if (videoArr.contains{ $0["id"]! as! String == self.videoId}) {
            self.starButton.setImage(UIImage(named: "heart"), for: .normal)
            self.isFavorite = true
        }
    }
    
    @IBAction func favButtonPressed(_ sender: Any) {

        if (isFavorite) {
            self.isFavorite = false
            self.starButton.setImage(UIImage(named: "heart2"), for: .normal)
            self.deleteFavorite()
        }
        else {
            self.isFavorite = true
            self.starButton.setImage(UIImage(named: "heart"), for: .normal)
            self.addFavorite()
        }
        
    }
    

    func addFavorite() {

        var videoArr: [[String: Any]] = self.favorites.loadFavorites()
        
        let json = [
            "id": self.videoId.description,
            "title": self.videoName,
            "channel": self.videoChannel,
            "description": self.descriptionVideo
            ] as [String : Any]
        
        videoArr.append(json)
        self.favorites.saveFavorites(videoArr: videoArr)
        self.favorites.saveImage(image: self.videoImage, idVideo: self.videoId)
    }

    
    func deleteFavorite() {
        let videoArr: [[String:Any]] = self.favorites.loadFavorites()
        var newArr: [[String:Any]] = []
        videoArr.forEach { (item) in
            if(item["id"]! as? String != self.videoId)
            {
                newArr.append(item)
            }
        }
        
        self.favorites.saveFavorites(videoArr: newArr)
        self.favorites.deleteImage(idVideo: self.videoId)
    }
    

    

    
}

extension VideoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let js1 = "document.getElementById('video').click();"
        webView.evaluateJavaScript(js1, completionHandler: nil)
        let js2 = "document.getElementsByTagName('video')[0].setAttribute('playsinline', '');"
        webView.evaluateJavaScript(js2, completionHandler: nil)
    }
}
