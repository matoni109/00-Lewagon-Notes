yarn add gmaps


// imports
import { fetchMovies, updateResultsList } from './movies';
import { initSortable } from './plugins/init_sortable';
import { initMarkdown } from './plugins/init_markdown';
import { initSelect2 } from './plugins/init_select2';


// initialize plugins
initSortable();
initMarkdown();
initSelect2();

// AJAX calls
fetchMovies();

// listeners
const form = document.querySelector('#search-form');
form.addEventListener('submit', updateResultsList);

debugger;

yarn add jquery
// ./src/index.js
import $ from 'jquery';

// Add some code with jQuery:
$(document).ready(function() {
  console.log('jQuery just checked that the DOM is ready!');
});



// ./src/foo.js
const capitalize = (word) => {
  return word[0].toUpperCase() + word.substr(1).toLowerCase();
}

export default capitalize;

// src/index.js
import { fetchMovies } from './movies'; // <-- add this line

fetchMovies('harry potter');

const form = document.querySelector('#search-form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  list.innerHTML = '';
  const input = document.querySelector('#search-input');
  fetchMovies(input.value);
});

// src/movies.js
// [...]

const updateResultsList = (event) => {
  event.preventDefault();
  list.innerHTML = '';
  const input = document.querySelector('#search-input');
  fetchMovies(input.value);
}

export { fetchMovies, updateResultsList }; // <-- separate functions with


JavaScript Plugins
Multiple imports

// src/index.js
import { fetchMovies, updateResultsList } from './movies';

fetchMovies('harry potter');

const form = document.querySelector('#search-form');
form.addEventListener('submit', updateResultsList);

// Keep the entry file short and explicit
// General rules

//     Implement functions in separate files. export them
//     import function in the entry file and use it.

// Package Repository



// Don't reinvent the wheel!
// Install yarn

// You should already have Node installed. Check with node -v.

// Install yarn with one of the following:

// Adding a new package

// Use yarn add

// yarn add <package> [--dev]

// This will make the package available in your project
// Ex. 1: Sortable JS

// A plugin to drag-and-drop items in a list

// Let's update the insertMovies function to render:

// Download package

// yarn add sortablejs

// Open the package.json
// Usage

// mkdir -p src/plugins
// touch src/plugins/init_sortable.js

// src/plugins/init_sortable.js
import Sortable from 'sortablejs';

const initSortable = () => {
  const list = document.querySelector('#results');
  // Sortable.create(list);
Sortable.create(list, {
  ghostClass: "ghost",
  animation: 150,
  // onEnd: (event) => {
  //   alert(`${event.oldIndex} moved to ${event.newIndex}`);
  // }
});

};

export { initSortable };

#results li {
  cursor: grab;
}

#results li:active {
  cursor: grabbing;
}

#results li.ghost {
  filter: grayscale(1);
  opacity: 0.5;
}


// markdown

<textarea class="form-control" id="editor" rows="4"></textarea>
<div id="preview"></div>

#preview, #editor {
  margin: 20px auto;
  max-width: 600px;
}

#preview {
  min-height: 100px;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 6px 12px;
  text-align: left;
}

#preview img {
  max-width: 100%;

// src/plugins/init_markdown.js
import MarkdownIt from 'markdown-it';

const initMarkdown = () => {
  const textarea = document.getElementById('editor');
  const preview = document.getElementById('preview');
  const markdown = new MarkdownIt();
  textarea.addEventListener('keyup', (event) => {
    const html = markdown.render(textarea.value);
    preview.innerHTML = html;
  });
};

export { initMarkdown };
// src/index.js
import { initMarkdown } from './plugins/init_markdown';

initMarkdown();

# Le Wagon

## Change your life, [learn to code](https://lewagon.com)

Oh look! A **picture**:

![The Lion King](https://raw.githubusercontent.com/lewagon/fullstack-images/master/ruby/lion_king.png)


// Select 2

<select class="select2" name="country">
  <option value="AL">Alabama</option>
  <option value="WY">Wyoming</option>
</select>

// ./src/plugins/init_select2.js
import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2(); // (~ document.querySelectorAll)
};

export { initSelect2 };

<link rel="stylesheet" href="node_modules/select2/dist/css/select2.css">


// imports
import $ from 'jquery';
import 'select2';

// function definitions
const initSelect2 = () => {
  $('.select2').select2();
};

// exports (~ public interface)
export { initSelect2 };



package.json;

{
  "name": "geocoder",
  "license": "UNLICENSED",
  "dependencies": {
    "gmaps": "^0.4.24"
  },
  "devDependencies": {
    "eslint": "^4.3.0",
    "eslint-config-airbnb-base": "^11.3.1",
    "eslint-plugin-import": "^2.7.0",
    "webpack-dev-server": "^2.9.4"
  }
}
