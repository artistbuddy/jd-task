//
//  StationCollectionViewCell.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

class StationCollectionViewCell: UICollectionViewCell {
    static let cellReusableID = "StationCell"
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var unitLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    @IBOutlet private weak var bikesCountLabel: UILabel!
    @IBOutlet private weak var racksCountLabel: UILabel!
    
    var id: String = "" {
        didSet {
            idLabel.text = id
        }
    }
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var distance: String = "" {
        didSet {
            distanceLabel.text = distance
        }
    }
    
    var unit: String = "" {
        didSet {
            unitLabel.text = unit
        }
    }
    
    var address: String = "" {
        didSet {
            adressLabel.text = address
        }
    }
    
    var bikes: String = "" {
        didSet {
            bikesCountLabel.text = bikes
        }
    }
    
    var freeRacks: String = "" {
        didSet {
            racksCountLabel.text = freeRacks
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
