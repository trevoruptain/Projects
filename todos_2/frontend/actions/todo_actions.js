import {todoApiUtil, postTodo, updateTodo, deleteTodo} from '../../utils/todo_api_util';
import {receiveErrors, clearErrors} from './error_actions';

export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";
export const TODO_ERROR = "TODO_ERROR";

export const receiveTodos = todos => ({
  type: RECEIVE_TODOS,
  todos
});

export const receiveTodo = todo => ({
  type: RECEIVE_TODO,
  todo
});

export const removeTodo = todo => ({
  type: REMOVE_TODO,
  todo
});

export const todoError = error => ({
  type: TODO_ERROR,
  error
});

export const fetchTodos = () => dispatch => (
  todoApiUtil().then(todos => dispatch(receiveTodos(todos)))
);

export const createTodo = (newTodo) => dispatch => (
  postTodo(newTodo)
  .then(
    todo => dispatch(receiveTodo(todo)),
    err => dispatch(receiveErrors(err.responseJSON))
  ).then(dispatch(clearErrors()))
);

export const patchTodo = (newTodo) => dispatch => (
  updateTodo(newTodo)
  .then(
    todo => dispatch(receiveTodo(todo)),
    err => dispatch(receiveErrors(err.responseJSON))
  ).then(dispatch(clearErrors()))
);

export const destroyTodo = (oldTodo) => dispatch => (
  deleteTodo(oldTodo)
  .then(
    todo => dispatch(receiveTodo(todo)),
    err => dispatch(receiveErrors(err.responseJSON))
  ).then(dispatch(clearErrors()))
);
