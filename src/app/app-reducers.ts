import { TasksReducer } from './redux/reducers';
import { ActionReducerMap } from '@ngrx/store';
import { AppStore } from './app-store';

export const appReducers: ActionReducerMap<AppStore> = {
  TasksSlice: TasksReducer,
};
