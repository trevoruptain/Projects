import { RECEIVE_ERRORS } from '../actions/session_actions';

const defaultState = {
  session: []
};

const errorsReducer = (state = defaultState, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_ERRORS:
      let nextState = Object.assign({}, state);
      nextState.session.push(action.error);
      return nextState;

    default:
      return state;
  }
};
