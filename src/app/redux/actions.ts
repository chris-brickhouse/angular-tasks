import { createAction, props } from '@ngrx/store';

export const GetTasks = createAction('[GetTasks]');
export const GetTasksSuccess = createAction('[GetTasksSuccess]', props<{ tasks: any }>());
