//
//  ListInfo.swift
//  youTune
//
//  Created by Léo LEGRON on 13/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

class ListInfo: UITableViewController {

    var imageList: [UIImage] = []
    var titles: [String] = []
    var descriptions: [String] = []
    var channelTitles: [String] = []
    var id: [String] = []
    var viewCanBeDisplayed = false
    
    public func getInformation(keyword: String, categorie: Int, callback: @escaping (Bool) -> ()) {
        
        // Formating the keyword for request
        
        let keywordFormatted = String(keyword.map({$0 == " " ? "+" : $0}))
        
        // Call the youTube API
        
        let ytURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyATUkqiZ6WQVbJdu1vqj-oM3aP7MgedOeU&maxResults=25&type=video&videoCategoryId=" + categorie.description + "&q=" + keywordFormatted
        let url = URL(string: ytURL)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let responseData = data else {
                callback(false)
                self.viewCanBeDisplayed = true
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
            let dict = json as? [String:Any] else{
                callback(false)
                self.viewCanBeDisplayed = true
                return
            }
            
            // Tiny parsing
            
            let dictItems = dict["items"] as? [[String: Any]]
            
            dictItems?.forEach({ (item) in
                
                let itemSnippets = item["snippet"] as? [String: Any]
                let itemId = item["id"] as? [String: Any]
                
                let thumbnails = itemSnippets!["thumbnails"] as? [String: Any]
                let defaultThumbnail = thumbnails!["high"] as? [String: Any]
                
                guard let title = itemSnippets!["title"], let description = itemSnippets!["description"],
                let channelTitle = itemSnippets!["channelTitle"], let defaultImageUrl = defaultThumbnail!["url"],
                let videoId = itemId!["videoId"] else{
                    return
                }
                
                // Fill arrays of listInfo with API datas
                
                self.titles.append(String(describing: title))
                self.descriptions.append(String(describing: description))
                self.channelTitles.append(String(describing: channelTitle))
                self.id.append(String(describing: videoId))
                let url = URL(string: String(describing: defaultImageUrl))
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    if let image = UIImage(data: imageData){
                        self.imageList.append(image)
                    }
                }
            })
            callback(true)
            self.viewCanBeDisplayed = true
        }
        task.resume()
    }
    
}
