static func createToDo(toDoText: String, completion: (ToDo) -> Void) {
    guard let toDoEntity = NSEntityDescription.entity(forEntityName: "ToDo", in: context) else { return }
    
    let newToDo = ToDo.init(entity: toDoEntity, insertInto: context)
    
    newToDo.id = UUID()
    newToDo.text = toDoText
    newToDo.done = false
    newToDo.priority = false
    
    saveContext()
    print("[STORAGE] Created To-Do '\(toDoText)' with ID \(String(describing: newToDo.id))")
    completion(newToDo)
}
