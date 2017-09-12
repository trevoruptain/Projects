const allTodos = (state) => {
  const todoIds = Object.keys(state.todos);
  const todoArray = todoIds.map(el => {
    return state.todos[el];
  });

  return todoArray;
};

export default allTodos;
