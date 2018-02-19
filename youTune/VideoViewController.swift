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
    var descriptionVideo: String = ""
    var videoId: String = ""
    var videoImageURL: String = ""
    var videoName: String = ""
    var videoChannel: String = ""
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(videoId: videoId)
        self.videoDescription.text = descriptionVideo
        self.webView.navigationDelegate = self
        print("test")
        print(self.videoName)
        print(self.videoChannel)
        print(self.videoId)
        print(self.videoDescription)
        print(self.videoImageURL)
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
    
    @IBAction func favButtonPressed(_ sender: Any) {

        if (isFavorite) {
            self.isFavorite = false
            self.starButton.setImage(UIImage(named: "emptyStar"), for: .normal)
            self.deleteFavorite()
        }
        else {
            self.isFavorite = true
            self.starButton.setImage(UIImage(named: "starFilled"), for: .normal)
            self.addFavorite()
        }
        
    }
    
    func addFavorite() {

        
        var videoArr: [[String: Any]] = loadFavorites()
        
        let json = [
            "id": self.videoId.description,
            "title": self.videoName,
            "channel": self.videoChannel,
            "description": self.descriptionVideo,
            "image": self.videoImageURL
            ] as [String : Any]
        
        videoArr.append(json)
        
        saveFavorites(videoArr: videoArr)
        
    }

    
    func deleteFavorite() {
        var videoArr: [[String:Any]] = loadFavorites()
        var newArr: [[String:Any]] = []
        videoArr.forEach { (item) in
            if(item["id"]! as? String != self.videoId)
            {
                newArr.append(item)
            }
        }
        
        saveFavorites(videoArr: newArr)
    }
    
    func loadFavorites() -> [[String:Any]]{
        
        let basePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("favorites.json")
        
        guard let data = try? Data(contentsOf: filePath),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let arr = json as? [[String:Any]]
            else {
                return []
        }
        return arr
    }
    
    func saveFavorites(videoArr: [[String:Any]]) {
        let basePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("favorites.json")
        
        guard let data = try? JSONSerialization.data(withJSONObject: videoArr, options: .init(rawValue: 0)) else {
            print("Failed to Serialize")
            return
        }
        
        do {
            try data.write(to: filePath)
            print("write successed")
        } catch {
            print("erreur write")
        }
    }
    
}

extension VideoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let js = "document.getElementById('video').click();"
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
}
