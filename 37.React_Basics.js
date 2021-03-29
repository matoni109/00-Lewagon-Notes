//
// Yarn Init

// cd ~/code/<your_github_nickname> mkdir yarn_project && cd $_ yarn init
// use UNLICENSED when asked if private code

// yarn add <package> [--dev]
// yarn add eslint --dev
eslint --init

//
// touch .gitignore
node_modules
// .eslintrc.json
{
  "extends": "airbnb",
    "rules": { "no-console": "off", "comma-dangle": "off", "quotes": "off", "react/prop-types": 0, "arrow-body-style": 0, "space-before-function-paren": 0 }, "env": { "browser": true }
}

const people = [
  { name: "Alice", age: 24 },
  { name: "Bob", age: 32 },
  { name: "Charles", age: 45 },
];
const markup = `   <ul class="people">     ${people
  .map((person) => {
    `<li>${person.name} is ${person.age} years old</li>`;
  })
  .join("")}   </ul> `;

// ES5
//function(name) { // Some js}

// ES6

() => {
  // Some js
};

// example ES5

const numbers = [1, 2, 3];
const squares = numbers.map(function (number) {
  return number * number;
});

// ES6
const numbers = [1, 2, 3];
const squares = numbers.map((number) => {
  return number * number;
});
// or
const numbers = [1, 2, 3];
// Implicit return
const squares = numbers.map((n) => n * n);

// ES6 with .this
const refreshButton = document.querySelector("#refresh");
dropdown.addEventListener("click", function () {
  this.innerHTML = "Hold still...";
  setTimeout(() => {
    // binds `this` to the function
    this.innerHTML = "Refresh";
  }, 1000);
});

//
const greet = () => {
  console.log("Hello");
};
//
greet(); // Hello

// array methods
const cities = ["Paris", "London", "Berlin"];
cities.find((city) => city.startsWith("P")); // Paris
cities.findIndex((city) => city.startsWith("P")); // 0
cities.some((city) => city.startsWith("P")); // true
cities.every((city) => city.startsWith("P")); // false

// Classes

class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }
  greet() {
    return `Hello ${this.name}!`;
  }
}

// New instance of User
const boris = new User("Boris", "boris@lewagon.org");
console.log(boris.greet()); // Hello


