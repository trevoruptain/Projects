const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const askIfGreaterThan = (el1, el2, callback) => {
  console.log(`The first number is ${el1}`);
  console.log(`The second number is ${el2}`);

  reader.question("Yes if the first number is greater: ", function(response) {
    const greater = response === "yes" ? true : false;
    callback(greater);
  });
};

const innerBubbleSortLoop = (arr, i, madeAnySwaps, outerBubbleSortLoop) => {
  if (i === arr.length - 1) {
    return outerBubbleSortLoop(madeAnySwaps);
  }

  askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
    if (isGreaterThan) {
      const temp = arr[i];
      arr[i] = arr[i + 1];
      arr[i + 1] = temp;
      madeAnySwaps = true;
    }
    innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
  });
};

const absurdBubbleSort = (arr, sortCompletionCallback) => {
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      return sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
};

absurdBubbleSort([3, 2, 1], function(arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
