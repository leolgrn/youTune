//
//  searchViewController.swift
//  youTune
//
//  Created by Léo LEGRON on 25/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

class searchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var request = ListInfo()
    
    var categorie = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.defaultColor
        self.textField.backgroundColor = UIColor.thirdColor
        self.textField.textColor = UIColor.white
        self.textField.attributedPlaceholder = NSAttributedString(string:"Search for an artist, a song, an album...", attributes: [NSAttributedStringKey.foregroundColor: UIColor.fourthColor])
        self.searchButton.setTitleColor(UIColor.white, for: [])
        self.searchButton.setTitleColor(UIColor.secondColor, for: UIControlState.highlighted)
        self.tableView.backgroundColor = UIColor.fourthColor
        
        self.tableView.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.textField.delegate = self
        
        self.title = "Search 🔎"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        search()
    }
    
    @IBAction func categorieChanged(_ sender: Any) {
        print(self.segmentedControl.selectedSegmentIndex)
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.categorie = 10
        case 1:
            self.categorie = 1
        case 2:
            self.categorie = 17
        default:
            self.categorie = 10
        }
    }
    

    func search() {
        request = ListInfo()
        self.request.getInformation(keyword: self.textField.text!, categorie: self.categorie, callback: { ok in
            if(ok){
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.textField.resignFirstResponder() // close keyboard
                }
            }
        })        
    }
}

extension searchViewController: UITableViewDataSource{
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

extension searchViewController: UITableViewDelegate{
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

extension searchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        search()
        return true
    }
}
