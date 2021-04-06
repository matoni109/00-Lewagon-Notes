// https://medium.com/@sherryhsu/es5-pseudoclassical-class-and-es6-es7-class-ac5bbbc13b93
// Yarn Init
// https://codepen.io/matoni109/pen/yLgJwLM
// npx create-react-app my-app --scripts-version 1.1.5
// cd ~/code/<your_github_nickname> mkdir yarn_project && cd $_ yarn init
// use UNLICENSED when asked if private code

// yarn add <package> [--dev]
// yarn add eslint --dev
// eslint --init
 "rules": {
    "no-console": "off",
    "comma-dangle": "off",
    "quotes": "off",
    "react/prop-types": 0,
    "arrow-body-style": 0,
    // suppress errors for missing 'import React' in files
    "react/react-in-jsx-scope": "off",
    // allow jsx syntax in js files (for next.js project)
    "react/jsx-filename-extension": [1, { "extensions": [".js", ".jsx"] }], //should add ".ts" if typescript project
    "space-before-function-paren": 0
  }
//
// touch .gitignore
node_modules;
// .eslintrc.json
{
  "extends": "airbnb",
    "rules": { "no-console": "off",
"comma-dangle": "off",
  "quotes": "off",
  "react/prop-types": 0,
  "arrow-body-style": 0,
  "space-before-function-paren": 0 },
"env": { "browser": true }
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
class Human {
  constructor() {
    this.gender = "male";
  }

  printGender() {
    console.log(this.gender);
  }
}
class User extends Human {
  constructor(name, email) {
    super();
    this.name = name;
    this.email = email;
  }
  greet() {
    return `Hello ${this.name}!`;
  }
}
// ES7
class Human {
  gender = "male";

  printGender = () => {
    console.log(this.gender);
  };
}
class User extends Human {
  constructor(name, email) {
    super();
    this.name = name;
    this.email = email;
  }
  greet = () => {
    `Hello ${this.name}!`;
  };
}

// New instance of User
const boris = new User("Boris", "boris@lewagon.org");
console.log(boris.greet()); // Hello
boris.printGender(); // "male"

// Spread and Rest Opperator
// ...
const numbers = [1, 2, 3];
const newNumbers = [...numbers, 4];

console.log(newNumbers);

const person = {
  name: "max",
};

const newPerson = {
  ...person,
  age: 28,
};
console.log(newPerson);

// [object Object] {
//   age: 28,
//   name: "max"
// }

// example
const filter = (...args) => {
  return args.filter((el) => el === 1);
};

console.log(filter(1, 2, 3));
// [1]

// Destructuring
//
const numbers = [1, 2, 3];
[num1, num2] = numbers;

console.log(num1, num2); // 1 2
//
[num1, , num3] = numbers;
console.log(num1, num3); // 1 3

//  primitive type

const number = 1;
const num2 = number;

console.log(num2); // 1

// reference types

const person = {
  name: "Max",
};

const secondPerson = person;

person.name = "Max";

console.log(secondPerson); // Max

// then if you change :

const person = {
  name: "Max",
};

const secondPerson = person;
person.name = "Manu";

console.log(secondPerson); // Manu

// to fix
const person = {
  name: "Max",
};

const secondPerson = {
  ...person,
};
person.name = "Manu";

console.log(secondPerson); // Max

/// array functions

const numbers = [1, 2, 3];

const doubleNumArray = numbers.map((num) => {
  return num * 2;
});

console.log(numbers);
console.log(doubleNumArray);
