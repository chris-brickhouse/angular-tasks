import { Observable } from 'rxjs';
import { AppStore } from './../app-store';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import * as actions from './../redux/actions';

@Component({
  selector: 'app-task-list',
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.scss']
})
export class TaskListComponent implements OnInit {

  tasks$: Observable<any[]>;
  tasks: any[] = [];

  constructor(private router: Router, private store: Store<AppStore>) {
    this.tasks$ = store.select((state) => state.TasksSlice.tasks);

  }

  ngOnInit(): void {
    this.store.dispatch(actions.GetTasks());
    this.tasks$.subscribe((data) => {
      this.tasks = data;
    });
  }
}
