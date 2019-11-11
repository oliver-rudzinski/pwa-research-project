export class TodoService {
  items: TodoItem[];

  constructor() {
    this.items = this.loadStorage() || [];
  } 

  saveInStorage(object) {
    localStorage.setItem("data", JSON.stringify(object));
  }

  loadStorage() {
    return JSON.parse(localStorage.getItem("data"));
  }

  addTodoItem(description: string) {
    this.items.push(new TodoItem(description));
    this.saveInStorage(this.items);
  }
}
