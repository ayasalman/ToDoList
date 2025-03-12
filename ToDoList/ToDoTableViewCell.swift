//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Aya on 12/03/2025.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var todoImageView: UIImageView!
    
    @IBOutlet weak var todoTitleLabel: UILabel!
    
    @IBOutlet weak var todoCreationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
