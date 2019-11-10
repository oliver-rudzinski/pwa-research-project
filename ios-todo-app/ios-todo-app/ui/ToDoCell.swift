//
//  ToDoCell.swift
//  ios-todo-app
//
//  Created by Oliver Rudzinski on 09.11.19.
//  Copyright © 2019 Oliver Rudzinski. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var checkmark: UIButton!
    @IBOutlet weak var priority: UIButton!
    
    
    var toDo = ToDo()

    var toDoText: String {
        get {
            guard let text = toDoTextField.text else { return "" }
            return text
        }
    }

    func populate(toDo: ToDo) {
        self.toDo = toDo
        
        toDoTextField.text = toDo.text
        checkmark.isSelected = toDo.done
        priority.isSelected = toDo.priority
    }
}
