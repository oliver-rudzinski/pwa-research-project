static func loadToDos(completion: ([ToDo]) -> Void) {
    let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
    
    do {
        let toDosFromDisk = try context.fetch(request)
        completion(toDosFromDisk)
        
        print("[STORAGE] Loaded to-dos:")
        for toDo in toDosFromDisk {
            print("\(String(describing: toDo.id)): '\(String(describing: toDo.text))'")
        }
    } catch {
        fatalError("[STORAGE/Error]: Could not load to-do entities from disk: \(error)")
    }
}
