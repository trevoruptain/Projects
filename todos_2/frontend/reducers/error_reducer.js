import {RECEIVE_ERRORS, CLEAR_ERRORS, receiveErrors, clearErrors} from '../actions/error_actions';

const errorReducer = (state = [], action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ERRORS:
      const newState = Object.assign([], state, action.errors);
      return newState;
    case CLEAR_ERRORS:
      return [];
    default:
      return state;
  }
};

export default errorReducer;
