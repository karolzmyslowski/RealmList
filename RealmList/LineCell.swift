//
//  LineCell.swift
//  Realm
//
//  Created by Karol Zmyslowski on 19.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import UIKit

class LineCell: UITableViewCell {

    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    func configure(with line: Any) {
        lineLabel.text = ""
        emailLabel.text = ""
        scoreLabel.text = ""
    }
}
