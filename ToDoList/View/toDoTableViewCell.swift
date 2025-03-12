//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Aya on 05/03/2025.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoCreationLabel: UILabel!
    
    @IBOutlet weak var todoTitleLabel: UILabel!
    
    @IBOutlet weak var todoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
