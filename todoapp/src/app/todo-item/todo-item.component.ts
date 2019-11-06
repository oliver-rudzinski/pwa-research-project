import {Component, Input, OnInit} from '@angular/core';
import {TodoItem} from "../todoItem";
import {TodoService} from "../todo.service";

@Component({
  selector: 'app-todo-item',
  templateUrl: './todo-item.component.html',
  styleUrls: ['./todo-item.component.scss']
})
export class TodoItemComponent implements OnInit {

  constructor(private todoService: TodoService) {
  }

  @Input()
  public item: TodoItem;

  ngOnInit() {
  }

  deleteTodo() {
    this.todoService.deleteTodoItem(this.item.id);
  }

}
