const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
    return;
  }
  numsLeft--;

  reader.question("What's yo numbah?? ", function(answer) {
    const number = parseInt(answer);
    sum += number;
    console.log(`Sum: ${sum}`);
    addNumbers(sum, numsLeft, completionCallback);
  });
}

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
