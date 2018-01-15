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
    
    let request = ListInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        
        // Call + reloadData of tableView
        self.request.getInformation(keyword: "Casseurs Flowters")
        self.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // reloadData of tableView while it's not full => to improve
    func reload() {
        while self.request.imageList.count < 25 {
            self.tableView.reloadData()
        }
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
            listCell.descriptionList.text = self.request.descriptions[indexPath.row]
            listCell.imageList.image = self.request.imageList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension mainViewController: UITableViewDelegate{
    
}


