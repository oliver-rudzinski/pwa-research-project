//
//  ToDoCell.swift
//  ios-todo-app
//
//  Created by Oliver Rudzinski on 09.11.19.
//  Copyright © 2019 Oliver Rudzinski. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func onRemoveCell(cell: ToDoCell)
    func onEditCellText(cell: ToDoCell)
    func onChangePriority(cell: ToDoCell)
    func onChangeStatus(cell: ToDoCell)
}

class ToDoCell: UITableViewCell {

    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var checkmark: UIButton!
    @IBOutlet weak var priority: UIButton!
    
    weak var delegate: ToDoCellDelegate?
    
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
    
    
    
    @IBAction func editCellText(_ sender: UITextField) {
        delegate?.onEditCellText(cell: self)
    }

    @IBAction func changeStatus(_ sender: UIButton) {
        delegate?.onChangeStatus(cell: self)
    }
    
    @IBAction func changePriority(_ sender: UIButton) {
        delegate?.onChangePriority(cell: self)
    }
    
    @IBAction func removeCell(_ sender: UIButton) {
        delegate?.onRemoveCell(cell: self)
    }
}
