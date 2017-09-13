import { combineReducers } from 'redux';

import errorReducer from './error_reducer';
import todosReducer from './todos_reducer';
import stepsReducer from './steps_reducer';

const RootReducer = combineReducers({
  todos: todosReducer,
  steps: stepsReducer,
  errors: errorReducer
});

export default RootReducer;
