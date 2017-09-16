import { RECEIVE_CURRENT_USER } from '../actions/session_actions';

const defaultState = {
  currrentUser: null
};

const SessionReducer = (state = defaultState, action) => {
  Object.freeze(state);

  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      let nextState = Object.assign({}, state);
      nextState.currentUser = action.currentUser;
      return nextState;
    default:
      return state;
  }
};
