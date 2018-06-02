//
//  CellInstalTableViewCell.swift
//  TechniApp
//
//  Created by KERCKWEB on 03/04/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit

class CellInstalTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCellBatiment: UIImageView!
    
    @IBOutlet weak var marqueLabel: UILabel!
    
    @IBOutlet weak var nomInsalLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
