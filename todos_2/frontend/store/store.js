import { createStore, applyMiddleware } from 'redux';
import RootReducer from '../reducers/root_reducer';
import { thunkMiddleware } from '../middleware/thunk.js';
import logger from 'redux-logger';

const configureStore = (preloadedState = {}) => {
  const store = createStore(RootReducer, preloadedState, applyMiddleware(thunkMiddleware, logger));
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
};

export default configureStore;
