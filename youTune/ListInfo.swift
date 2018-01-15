//
//  ListInfo.swift
//  youTune
//
//  Created by Léo LEGRON on 13/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

class ListInfo: NSObject {

    var imageList: [UIImage] = []
    var titles: [String] = []
    var descriptions: [String] = []
    
    public func getInformation(keyword: String) {
        
        // Call the youTube API
        
        let keywordFormat: String = KeywordFormating(keyword: keyword)
        let ytURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyATUkqiZ6WQVbJdu1vqj-oM3aP7MgedOeU&maxResults=25&type=video&videoCategoryId=10&q=" + keywordFormat
        let url = URL(string: ytURL)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard let responseData = data else {
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments),
                let dict = json as? [String:Any]
                else{
                    return
            }
            
            // Tiny parsing
            
            let dictItems = dict["items"] as? [[String: Any]]
            dictItems?.forEach({ (item) in
                let itemSnippets = item["snippet"] as? [String: Any]
                let thumbnails = itemSnippets!["thumbnails"] as? [String: Any]
                let defaultThumbnail = thumbnails!["default"] as? [String: Any]
                guard let title = itemSnippets!["title"], let description = itemSnippets!["description"], let defaultImageUrl = defaultThumbnail!["url"] else{
                    return
                }
                
                // Fill variables of listInfo with API datas
                
                self.titles.append(String(describing: title))
                self.descriptions.append(String(describing: description))
                let url = URL(string: String(describing: defaultImageUrl))
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.imageList.append(image!)
                }
            })
        }
        task.resume()
    }
    
    // Formating the keyword for request
    
    public func KeywordFormating(keyword: String) -> String {
        var keywordFormat: String = ""
        keyword.forEach({char in
            guard char != " "
                else {
                    keywordFormat += "+"
                    return
            }
            keywordFormat += "\(char)"
        })
        return keywordFormat
    }
    
}
