import React from 'react';
import ReactDOM from 'react-dom';
import TodoListItem from './todo_list';
import TodoForm from './todo_form';

const TodoList = ({todos, receiveTodo}) => {
  const todoListItems = todos.map((item) => (
    <TodoListItem key={item.id} item={item} />
  ));

  return (
    <div>
      <h2>Add a new Todo Item!</h2>
      <TodoForm receive={ receiveTodo }/>
      <ul>
        {todos.map(todo => (<li key={todo.id}>{todo.title}</li>))}
      </ul>
    </div>
  );
};

export default TodoList;
