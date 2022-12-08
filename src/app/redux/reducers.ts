import * as actions from './actions';
import { createReducer, on } from '@ngrx/store';
import { TasksStore } from './store';

export const initialState = new TasksStore();
const taskReducer = createReducer(
  initialState,
  on(actions.GetTasksSuccess, (state, payload) => {
    return { ...state, tasks: Object.assign({}, payload.tasks) };
  }),
);

export function TasksReducer(state, action): any {
  return taskReducer(state, action);
}
