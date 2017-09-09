import React from 'react';
import ReactDOM from 'react-dom';

import ClockWidget from './clock';
import WeatherWidget from './weather';

class Root extends React.Component {
  render() {
    return(
      <div>
        <ClockWidget />
        <WeatherWidget />
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Root/>, document.getElementById('main'));
});
