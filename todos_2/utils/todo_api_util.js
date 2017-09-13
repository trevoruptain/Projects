export const todoApiUtil = () => {
  return $.ajax({
    method: 'GET',
    type: 'json',
    url: 'api/todos'
  });
};

export const postTodo = (todo) => {
  return $.ajax({
    method: 'POST',
    type: 'json',
    data: {todo: todo},
    url: 'api/todos'
  });
};

export const updateTodo = (todo) => {
  return $.ajax({
    method: "PUT",
    type: "json",
    data: {todo: todo},
    url: `api/todos/${todo.id}`
  });
};

export const deleteTodo = (todo) => {
  return $.ajax({
    method: "DELETE",
    type: "json",
    data: {todo: todo},
    url: `api/todos/${todo.id}`
  });
};
