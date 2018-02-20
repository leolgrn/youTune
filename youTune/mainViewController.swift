//
//  mainViewController.swift
//  youTune
//
//  Created by Léo LEGRON on 12/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit


//class main

class mainViewController: UIViewController{
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var request = ListInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.defaultColor
        self.tableView.backgroundColor = UIColor.fourthColor
        self.tableView.separatorColor = UIColor.secondColor
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        self.errorMessage.textColor = UIColor.white
        self.errorMessage.isHidden = true
        self.tryAgainButton.setTitleColor(UIColor.white, for: [])
        self.tryAgainButton.setTitleColor(UIColor.secondColor, for: UIControlState.highlighted)
        self.tryAgainButton.isHidden = true
        
        // Navigation Bar
        
        self.title = "Trends 🔥"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Favs ❤️", style: .plain, target: self, action: #selector(favoritesController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search 🔎", style: .plain, target: self, action: #selector(searchController))
        
        // Call + reloadData of tableView
        self.request.getInformation(keyword: "", categorie: 10, callback: { ok in
            if(ok){
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else{
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                    self.errorMessage.isHidden = false
                    self.tryAgainButton.isHidden = false
                    self.navigationItem.leftBarButtonItem?.isEnabled = false
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        })
        
        while self.request.viewCanBeDisplayed == false {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchController() {
        self.navigationController?.pushViewController(searchViewController(), animated: true)
    }
    
    @IBAction func favoritesController() {
        self.navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @IBAction func tryAgain() {
        request = ListInfo()
        // Call + reloadData of tableView
        self.request.getInformation(keyword: "", categorie: 10, callback: { ok in
            if(ok){
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.errorMessage.isHidden = true
                    self.tryAgainButton.isHidden = true
                    self.navigationItem.leftBarButtonItem?.isEnabled = true
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
            }
            else{
                DispatchQueue.main.async {
                    self.tableView.isHidden = true
                    self.errorMessage.isHidden = false
                    self.tryAgainButton.isHidden = false
                    self.navigationItem.leftBarButtonItem?.isEnabled = false
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        })
    }
}

//extensions

extension mainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.request.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        if let listCell = cell as? ListTableViewCell {
            listCell.titleList.text = self.request.titles[indexPath.row]
            listCell.channelTitleList.text = self.request.channelTitles[indexPath.row]
            listCell.imageList.image = self.request.imageList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension mainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoId = self.request.id[indexPath.row]
        let descriptionVideo = self.request.descriptions[indexPath.row]
        let videoImage = self.request.imageList[indexPath.row]
        let videoName = self.request.titles[indexPath.row]
        let videoChannel = self.request.channelTitles[indexPath.row]
        let videoViewController = VideoViewController()
        videoViewController.videoId = videoId
        videoViewController.descriptionVideo = descriptionVideo
        videoViewController.videoImage = videoImage
        videoViewController.videoName = videoName
                videoViewController.videoChannel = videoChannel
        self.navigationController?.pushViewController(videoViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.defaultColor
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.thirdColor
        cell.selectedBackgroundView = bgColorView
    }
}

extension UIColor {
    static let defaultColor = UIColor.grayScale(val: 50)
    static let secondColor = UIColor.grayScale(val: 200)
    static let thirdColor = UIColor.grayScale(val: 75)
    static let fourthColor = UIColor.grayScale(val: 25)
    
    static func rgb(val: Double) -> CGFloat {
        return CGFloat(val/255.0)
    }
    
    static func grayScale(val: Double) -> UIColor {
        return UIColor(red: UIColor.rgb(val: val), green: UIColor.rgb(val: val), blue: UIColor.rgb(val: val), alpha: 1)
    }
}
