//
//  TaskTableViewCell.swift
//  Homework57ToDoList
//
//  Created by 黃柏嘉 on 2022/1/19.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var executionDateLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    func changeButtonImage(task:Task){
        if task.complete{
            checkMarkButton.configuration?.background.image = UIImage(named: "complete")
        }else{
            checkMarkButton.configuration?.background.image = UIImage(named: "incomplete")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
