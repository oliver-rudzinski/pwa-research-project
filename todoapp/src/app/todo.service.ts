import {Injectable} from '@angular/core';
import {Observable, of} from "rxjs";
import {TodoItem} from "./todoItem";

@Injectable({
  providedIn: 'root'
})
export class TodoService {

  items: TodoItem[];

  constructor() {
    this.items = this.loadStorage() || [];
    // if (this.items === null) {
    //  this.items = [];
    // }
  }

  getTodoItems(): Observable<TodoItem[]> {
    return of(this.items);
  }

  addTodoItem(description: string) {
    this.items.push(new TodoItem(description));
    this.saveInStorage(this.items);
  }

  deleteTodoItem(id: string) {
    this.items = this.items.filter(item => {
      return item.id !== id;
    });
    this.saveInStorage(this.items);
  }

  updateTodoItem(updatedTodoItem: TodoItem) {
    console.warn("updated storage");
    this.items = this.items.map(todoItem=>{
      return todoItem.id===updatedTodoItem.id ? updatedTodoItem : todoItem;
    })
    this.saveInStorage(this.items);
  }

  saveInStorage(object) {
    localStorage.setItem("data", JSON.stringify(object));
  }

  loadStorage() {
    return JSON.parse(localStorage.getItem("data"));
  }
}
