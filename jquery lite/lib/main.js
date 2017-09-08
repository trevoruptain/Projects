const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = (arg) => {
  const functionQueue = [];

  if (typeof arg === "function") {
    if (document.readyState === 'complete') {
      arg();
    } else {
      functionQueue.push(arg);
    }
  } else if (arg instanceof HTMLElement) {
    return new DOMNodeCollection([arg]);
  } else {
    const objs = document.querySelectorAll(arg);
    const objArray = Array.from(objs);
    return new DOMNodeCollection(objArray);
  }

  document.addEventListener("DOMContentLoaded", function(e) {
    functionQueue.forEach(func => {
      func();
    });
  });
};
