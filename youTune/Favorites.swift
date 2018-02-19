//
//  Favorites.swift
//  youTune
//
//  Created by pierre piron on 19/02/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import Foundation

public class Favorites {
    
    public func loadFavorites() -> [[String:Any]]{
        
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
    
    public func saveFavorites(videoArr: [[String:Any]]) {
        let basePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = basePath.appendingPathComponent("favorites.json")
        
        guard let data = try? JSONSerialization.data(withJSONObject: videoArr, options: .init(rawValue: 0)) else {
            return
        }
        
        do {
            try data.write(to: filePath)
        } catch {
        }
    }
    
}
