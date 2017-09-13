import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import {todoApiUtil} from '../utils/todo_api_util';
import {fetchTodos} from './actions/todo_actions.js';

import Root from './components/root';

window.fetchTodos = fetchTodos;

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);
  window.store = store;
  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
