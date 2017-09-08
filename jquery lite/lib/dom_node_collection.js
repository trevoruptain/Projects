class DOMNodeCollection {
  constructor(array) {
    this.array = array;
    this.callbacks = {};
  }

  html(string=null) {
    if (string) {
      this.array.forEach(el => {
        el.innerHTML = string;
      });
    } else {
      return this.array[0].innerHTML;
    }
  }

  empty() {
    this.array.forEach(el => {
      el.innerHTML = "";
    });
  }

  append(arg) {
    this.array.forEach(el => {
      el.innerHTML += arg;
    });
  }

  attr(key, value=null) {
    if (value) {
      this.array.forEach(el => {
        el.setAttribute(key, value);
      });
    } else {
      this.array.forEach(el => {
        console.log(el.getAttribute(key));
        return el.getAttribute(key);
      });
    }
  }

  addClass(className) {
    this.array.forEach(el => {
      el.classList.add(className);
    });
  }

  removeClass(className) {
    this.array.forEach(el => {
      el.classList.remove(className);
    });
  }

  children() {
    const kids = [];

    this.array.forEach(el => {
      kids.push(el.children);
    });
    return new DOMNodeCollection(kids);
  }

  parent() {
    const adults = [];

    this.array.forEach(el => {
      adults.push(el.parentElement);
    });
    return new DOMNodeCollection(adults);
  }

  find(selector) {
    let found = [];

    this.array.forEach(el => {
      const list = el.querySelectorAll(selector);
      found = found.concat(list);
    });

    return new DOMNodeCollection(found);
  }

  remove() {
    this.array.forEach(el => {
      el.innerHTML = "";
    });

    this.array = [];
  }

  on(e, callback) {
    this.array.forEach(el => {
      this.callbacks.e = callback;
      el.addEventListener(e, callback);
    });
  }

  off(e) {
    this.array.forEach(el => {
      el.removeEventListener(e, this.callbacks.e);
    });
  }

  extend(...objs) {
    return Object.assign(objs);
  }
}

module.exports = DOMNodeCollection;
