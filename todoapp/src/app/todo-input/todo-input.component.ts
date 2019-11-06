import {Component, OnInit} from '@angular/core';
import {TodoService} from "../todo.service";

@Component({
  selector: 'app-todo-input',
  templateUrl: './todo-input.component.html',
  styleUrls: ['./todo-input.component.scss']
})
export class TodoInputComponent implements OnInit {

  inputString: string;

  constructor(private todoService: TodoService) {
    this.inputString = ""
  }

  ngOnInit() {
  }

  onChange(event: any) {
    this.inputString = event.target.value;
    console.log("inputString", this.inputString);
  }

  addTodoItem() {
    if (this.inputString.length === 0) {
      return;
    }
    console.log("inputString", this.inputString);
    this.todoService.addTodoItem(this.inputString);

    //clear input field
    this.inputString = "";
  }

}
