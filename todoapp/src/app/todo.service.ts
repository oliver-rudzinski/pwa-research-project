import {Injectable} from '@angular/core';
import {Observable, of} from "rxjs";
import {TodoItem} from "./todoItem";
import * as uuid from 'uuid';

@Injectable({
  providedIn: 'root'
})
export class TodoService {

  items: TodoItem[];

  constructor() {
    this.items = [
      {id: "123", description: "asljhasdpkfj"},
      {id: "123a", description: "aslsdpkfj"},
      {id: "123b", description: "asljhasdpj"},
      {id: "123c", description: "asldpkfj"},
    ];
  }

  getTodoItems(): Observable<TodoItem[]> {
    return of(this.items);
  }

  addTodoItem(description: string) {
    let todoItem = new TodoItem();
    todoItem.description = description;
    todoItem.id = uuid.v4();
    this.items.push(todoItem);
  }

  deleteTodoItem(id: string) {
    this.items = this.items.filter(item => {
      return item.id !== id;
    })
  }

}
