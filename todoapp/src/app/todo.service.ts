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

  sortItems() {
    // @ts-ignore
    this.items = this.items.sort((a, b) => b.important - a.important);
    console.warn("sorted", this.items);
  }

  getTodoItems(): Observable<TodoItem[]> {
    this.sortItems();
    return of(this.items);
  }

  showNotification() {
  /*  const title = 'Simple Title';
    const options = {
      body: 'Simple piece of body text.\nSecond line of body text :)'
    };
    const worker = navigator.serviceWorker.getRegistration().then(serviceWorker=>{
      serviceWorker.showNotification(title,options)
    });*/

    Notification.requestPermission(function(result) {
      //console.error(result);
      if (result === 'granted') {
        console.log(navigator.serviceWorker.ready)
        navigator.serviceWorker.ready.then(function(registration) {
          registration.showNotification('Vibration Sample', {
            body: 'Buzz! Buzz!',
          });
        });
      }
    });
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
    this.items = this.items.map(todoItem => {
      return todoItem.id === updatedTodoItem.id ? updatedTodoItem : todoItem;
    });
    this.sortItems();
    this.saveInStorage(this.items);
    this.showNotification();
  }

  saveInStorage(object) {
    localStorage.setItem("data", JSON.stringify(object));
  }

  loadStorage() {
    return JSON.parse(localStorage.getItem("data"));
  }
}
