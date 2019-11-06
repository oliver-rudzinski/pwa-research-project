import * as uuid from 'uuid';

export class TodoItem {
  description: string;
  id: string;
  important: boolean;
  done: boolean;

  constructor(description = 'no description', important = false, done = false) {
    this.id = uuid.v4();
    this.description=description;
    this.important=important;
    this.done=done;
  }
}
