import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Observable } from 'rxjs';
import { catchError, exhaustMap, map } from 'rxjs/operators';
import { Action } from '@ngrx/store';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import * as api from '../app-api';
import * as actions from './actions';

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/json' }),
};

const formOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/x-www-form-urlencoded' }),
};

@Injectable()
export class TasksEffects {
  constructor(private actions$: Actions, private http: HttpClient) { }

  GetTasks$: Observable<Action> = createEffect(() =>
    this.actions$.pipe(
      ofType(actions.GetTasks),
      exhaustMap((action) =>
        this.http
          .get(
            api.getAPI('tasks')
          )
          .pipe(
            map((data: any) => {
              return actions.GetTasksSuccess({ tasks: data });
            }),
            catchError((error: Error) => {
              return [];
            })
          )
      )
    )
  );

}
