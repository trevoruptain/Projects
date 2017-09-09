import React from "react";

class Weather extends React.Component {
  constructor() {
    super();
    this.latitude = 0;
    this.longitude = 0;
    this.state = {
      city: "",
      temperature: ""
    };
    this.getWeather = this.getWeather.bind(this);
  }

  render() {
    const { city, temperature } = this.state;

    return (
      <div>
        <h1>Weather Widget</h1>
        <div className='weather'>
          <p>City: {city}</p>
          <p>Temperature: {temperature}ºF</p>
        </div>
      </div>
    );
  }

  getWeather() {
    const wReq = new XMLHttpRequest();

    const getResponse = () => {
      const response = JSON.parse(wReq.response);

      this.setState({
        city: response.name,
        temperature: Math.round(response.main.temp - 273)
      });
    };

    wReq.addEventListener("load", getResponse);
    wReq.open(
      "GET",
      `http://api.openweathermap.org/data/2.5/weather?lat=${this
        .latitude}&lon=${this.longitude}&appid=9c6b279f1c36ece02e7dcff91eb6f67c`
    );
    wReq.send();
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(position => {
      this.latitude = position.coords.latitude;
      this.longitude = position.coords.longitude;
      this.getWeather();
    });
  }
}

export default Weather;
