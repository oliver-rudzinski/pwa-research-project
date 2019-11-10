//
//  ViewController.swift
//  ios-todo-app
//
//  Created by Oliver Rudzinski on 28.10.19.
//  Copyright © 2019 Oliver Rudzinski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var toDos = [ToDo]()
    var currentCellIndexPath = IndexPath()
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var toDoTextField: UITextField!
    
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
    
    @IBAction func onRemoveTap(_ sender: UIButton) {
        let toDo = toDos[sender.tag]
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        toDos.remove(at: sender.tag)
        Storage.removeToDo(toDo: toDo)
        
        toDoTableView.beginUpdates()
        toDoTableView.deleteRows(at: [indexPath], with: .automatic)
        toDoTableView.endUpdates()
    }
    
    @IBAction func onEditText(_ sender: UITextField) {
        let toDo = toDos[sender.tag]
        toDo.text = sender.text
        
        Storage.editToDoText(toDo: toDo, newToDoText: sender.text)
        toDoTableView.reloadData()
    }
    
    @IBAction func onDone(_ sender: UIButton) {
        print(sender.tag)
        sender.isSelected = !sender.isSelected
        
        let toDo = toDos[sender.tag]
        toDo.done = sender.isSelected
        
        Storage.changeStatus(toDo: toDo, done: sender.isSelected)
    }
    
    
    @IBAction func onPrioritize(_ sender: UIButton) {
        print("--- \(sender.tag) ---")
        sender.isSelected = !sender.isSelected
        
        for toDo in toDos {
            print(toDo.text!)
        }
        print("-----------")
        
        let toDo = toDos.remove(at: sender.tag)
        
        for toDo in toDos {
            print(toDo.text!)
        }
        print("-----------")
        
        toDo.priority = sender.isSelected
        guard let newIndex = toDos.firstIndex(where: { !$0.priority }) else { return }
        
        toDos.insert(toDo, at: newIndex)
        
        for toDo in toDos {
            print(toDo.text!)
        }
        print("-----------")
        
        let oldIndexPath = IndexPath(row: sender.tag, section: 0)
        let newIndexPath = IndexPath(row: newIndex, section: 0)
        
        toDoTableView.moveRow(at: oldIndexPath, to: newIndexPath)
        
        Storage.changePriority(toDo: toDo, priority: sender.isSelected)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        cell.populate(toDo: toDos[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCellIndexPath = indexPath
        print(indexPath)
    }
    
}
