import React from 'react';

class Clock extends React.Component {

  constructor(props) {
    super(props);
    this.state = { time: new Date() };
    this.tick = this.tick.bind(this);
  }

  tick() {
    this.setState({time: new Date()});
  }

  render() {
    let hours = this.correctDigits(this.state.time.getHours());
    let minutes = this.correctDigits(this.state.time.getMinutes());
    let seconds = this.correctDigits(this.state.time.getSeconds());

    return (
      <div>
        <h1>Clock Widget</h1>
        <div className='clock'>
          <p>Time: {hours}:{minutes}:{seconds}</p>
          <p>Date: {this.state.time.toDateString()}</p>
        </div>
      </div>
    );
  }

  correctDigits(time) {
    if (time < 10) {
      return `0${time}`;
    } else {
      return time;
    }
  }

  componentDidMount() {
    this.intervalId = setInterval(this.tick, 1000);
  }

  componentWillUnmount() {
    this.intervalId.clearInterval();
  }
}

export default Clock;
