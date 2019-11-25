//
//  ViewController.swift
//  ios-todo-app
//
//  Created by Oliver Rudzinski on 28.10.19.
//  Copyright © 2019 Oliver Rudzinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var toDoTextField: UITextField!
        
    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        toDoTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Storage.loadToDos(completion: { toDos in
            for toDo in toDos {
                if toDo.priority {
                    self.toDos.append(toDo)
                }
            }
            for toDo in toDos {
                if !toDo.priority {
                    self.toDos.append(toDo)
                }
            }
        })
    }
    
    
    @IBAction func onAddTap(_ sender: Any) {
        guard let toDoText = toDoTextField.text else { return }
        Storage.createToDo(toDoText: toDoText, completion: { toDo in
            self.toDos.append(toDo)
        })
        
        let indexPath = IndexPath(row: toDos.count - 1, section: 0)
        
        toDoTableView.beginUpdates()
        toDoTableView.insertRows(at: [indexPath], with: .automatic)
        toDoTableView.endUpdates()
        
        toDoTextField.text? = ""
    }

    func onEditCellText(cell: ToDoCell) {
        let optIndexPath = toDoTableView.indexPath(for: cell)
        guard let indexPath = optIndexPath else { return }
        let row = indexPath.row
        
        let toDo = toDos[row]
        let newToDoText = cell.toDoTextField.text
        toDo.text = newToDoText
        
        Storage.editToDoText(toDo: toDo, newToDoText: newToDoText)
        toDoTableView.reloadData()
    }
    
    func onChangeStatus(cell: ToDoCell) {
        cell.checkmark.isSelected = !cell.checkmark.isSelected
        
        let optIndexPath = toDoTableView.indexPath(for: cell)
        guard let indexPath = optIndexPath else { return }
        let row = indexPath.row
        
        let toDo = toDos[row]
        toDo.done = cell.checkmark.isSelected
        
        Storage.changeStatus(toDo: toDo, done: cell.checkmark.isSelected)
    }
    
    func onChangePriority(cell: ToDoCell) {
        cell.priority.isSelected = !cell.priority.isSelected
        
        let optIndexPath = toDoTableView.indexPath(for: cell)
        guard let indexPath = optIndexPath else { return }
        let row = indexPath.row
        
        let toDo = toDos.remove(at: row)
        toDo.priority = cell.priority.isSelected
        
        var newIndex: Int
        
        if toDos.firstIndex(where: { !$0.priority }) == nil {
            if cell.priority.isSelected {
                newIndex = row
            } else {
                newIndex = toDos.count
            }
        } else {
            newIndex = toDos.firstIndex(where: { !$0.priority })!
        }
        
        toDos.insert(toDo, at: newIndex)

        let oldIndexPath = IndexPath(row: row, section: 0)
        let newIndexPath = IndexPath(row: newIndex, section: 0)
        
        toDoTableView.moveRow(at: oldIndexPath, to: newIndexPath)
        Storage.changePriority(toDo: toDo, priority: cell.priority.isSelected)
    }
    
    func onRemoveCell(cell: ToDoCell) {
        let optIndexPath = toDoTableView.indexPath(for: cell)
        guard let indexPath = optIndexPath else { return }
        let row = indexPath.row
        
        let toDo = toDos[row]
        
        toDos.remove(at: row)
        Storage.removeToDo(toDo: toDo)

        toDoTableView.beginUpdates()
        toDoTableView.deleteRows(at: [indexPath], with: .automatic)
        toDoTableView.endUpdates()
        
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate, ToDoCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        cell.delegate = self
        cell.populate(toDo: toDos[indexPath.row])
        
        return cell
    }
}
