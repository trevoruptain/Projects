import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './frontend/store/store';
import { receiveTodo, receiveTodos } from './frontend/actions/todo_actions.js';
import Root from './frontend/components/root';
import allTodos from './frontend/reducers/selectors';

const store = configureStore();
window.allTodos = allTodos;
window.store = store;
// window.receiveTodo = receiveTodo;
// window.receiveTodos = receiveTodos;

document.addEventListener("DOMContentLoaded", function() {
  ReactDOM.render(<Root store = { store } />, document.getElementById('root'));
});
