import React from 'react';
import ReactDOM from 'react-dom';
import TodoListContainer from './todo_list/todo_list_container';

class App extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
    <div>
      <h1>The Best Todos App... just the best</h1>
      <TodoListContainer />
    </div>
  );}
}

export default App;
