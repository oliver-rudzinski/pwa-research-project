import {Component} from '@angular/core';
import {TodoService} from "./todo.service";
import {Observable} from "rxjs";
import {TodoItem} from "./todoItem";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'todoapp';
  items: Observable<TodoItem[]>;

  constructor(public todoService: TodoService) {
    this.items = this.todoService.getTodoItems();
  }
}
