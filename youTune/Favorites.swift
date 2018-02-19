//
//  Favorites.swift
//  youTune
//
//  Created by pierre piron on 19/02/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

public class Favorites {
    
    var basePath: URL
    
    init() {
        self.basePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    public func loadFavorites() -> [[String:Any]]{
        
        
        let filePath = self.basePath.appendingPathComponent("favorites.json")
        
        guard let data = try? Data(contentsOf: filePath),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let arr = json as? [[String:Any]]
            else {
                return []
        }
        return arr
    }
    
    public func saveFavorites(videoArr: [[String:Any]]) {
        
        let filePath = self.basePath.appendingPathComponent("favorites.json")
        
        guard let data = try? JSONSerialization.data(withJSONObject: videoArr, options: .init(rawValue: 0)) else {
            return
        }
        
        do {
            try data.write(to: filePath)
        } catch {
        }
    }
    
    public func saveImage(image: UIImage, idVideo: String) {
        
        let filePath = self.basePath.appendingPathComponent(idVideo + ".png")
        if let data = UIImagePNGRepresentation(image) {
            try? data.write(to: filePath)
        }
    }
    
    public func loadImage(idVideo: String) -> UIImage {
        
        let filePath = self.basePath.appendingPathComponent(idVideo + ".png")
        if (FileManager.default.fileExists(atPath: filePath.path)) {
            //return FileManager.default.value(forKeyPath: filePath.path) as! UIImage
            return UIImage(contentsOfFile: filePath.path)!
        }
        return UIImage(named: "heart")!
    }
    
    public func deleteImage(idVideo: String) {
        
        let filePath = self.basePath.appendingPathComponent(idVideo + ".png")
        do {
            try FileManager.default.removeItem(at: filePath)
        } catch {
        
        }
    }
}
