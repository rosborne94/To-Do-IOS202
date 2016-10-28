//
//  ToDoTableViewCell.swift
//  To-Do
//
//  Created by Riley Osborne on 10/24/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateModifiedLabel: UILabel!
    
    weak var toDo: ToDo!
    var toDoTVC =  ToDoDetailViewController()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ toDo: ToDo) {
        self.toDo = toDo
        titleLabel.text = toDo.title
        dateLabel.text = toDo.dateString
        infoLabel.text = toDo.text
        dateModifiedLabel.text = toDo.modifiedDateString
    }

}
