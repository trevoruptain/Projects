class Clock {
  constructor() {
    const date = new Date();
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();

    this.printTime(this.hours, this.minutes, this.seconds);

    setInterval(this._tick.bind(this), 1000);
  }

  printTime(hours, minutes, seconds) {
    let args = [hours, minutes, seconds];
    const times = args.map(el => {
      let n = el.toString();
      if (n.length === 1) {
        n = "0" + n;
      }
      return n;
    });
    console.log(`${times[0]}:${times[1]}:${times[2]}`);
  }

  _tick() {
    this.seconds++;
    if (this.seconds === 60) {
      this.minutes++;
      this.seconds = 0;
    }
    if (this.minutes === 60) {
      this.hours++;
      this.minutes = 0;
    }
    this.hours = this.hours % 24;
    this.printTime(this.hours, this.minutes, this.seconds);
  }
}

const clock = new Clock();
