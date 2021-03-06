//
//  ListTableViewCell.swift
//  youTune
//
//  Created by Léo LEGRON on 12/01/2018.
//  Copyright © 2018 Léo LEGRON. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageList: UIImageView!
    @IBOutlet weak var titleList: UILabel!
    @IBOutlet weak var channelTitleList: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleList.textColor = UIColor.white
        self.channelTitleList.textColor = UIColor.secondColor
    }
}
