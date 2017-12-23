//
//  APICallController.swift
//  APICall
//
//  Created by Léo LEGRON on 21/12/2017.
//  Copyright © 2017 Léo LEGRON. All rights reserved.
//

import UIKit

class APICallController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyATUkqiZ6WQVbJdu1vqj-oM3aP7MgedOeU&q=nou")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil {
                print("ERROR")
            }
            else{
                if let content = data{
                    do{
                        let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(myJSON)
                    }
                    catch{
                        
                    }
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
