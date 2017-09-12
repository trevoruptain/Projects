import React from 'react';
import ReactDOM from 'react-dom';
import uniqueId from '../../util/timestamp_id';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      id: uniqueId(),
      title: '',
      body: ''
    };

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>Title
          <input type="text" value={this.state.title} onChange={this.handleChange("title")}/>
        </label>
        <label>Body
          <input type="text" value={this.state.body} onChange={this.handleChange("body")}/>
        </label>
        <input type="submit" value="Submit"></input>
      </form>
    );
  }

  handleChange(key) {
    return (event) => {
      this.setState({ [key]: event.target.value });
    };
  }

  handleSubmit(event) {
    event.preventDefault();
    this.props.receive(this.state);
    this.setState({id: uniqueId(), title: '', body: ''});
  }
}

export default TodoForm;
