Selecting 1 element:

element.classList.add("red");
element.classList.remove("red");
element.classList.toggle("red");


const list = document.getElementById("players");
console.log(list.nodeName);
// => "UL"

// <div id="user" data-uid="2471555" data-github-nickname="Papillard">
//   Boris Paillard
// </div>

const boris = document.getElementById('user');
console.log(boris.dataset.uid);
// => "2471555"
console.log(boris.dataset.githubNickname); // Note the auto-camelization of the key!
// => "Papillard"



const element = document.querySelector(CSS_SELECTOR);

const elements = document.querySelectorAll(CSS_SELECTOR);

Listening to an event

const button = document.querySelector('#click-me');
button.addEventListener('click', (event) => {
    console.log(event);
});


const button = document.querySelector('#click-me');
button.addEventListener('click', (event) => {
    // Callback
    event.currentTarget.innerText = 'Hold still...';
    event.currentTarget.setAttribute("disabled", "");
});

// GET request
fetch(url).then((response) => {
    // Do something once HTTP response https://gist.github.com/Eschults/30ffba585c5d19b6c646d6156d726a58 is receivedadf1f2d7
    // 48727053
    // 8691812a
});

fetch("http://www.omdbapi.com/?s=harry potter&apikey=adf1f2d7")
    .then(response => response.json())
    .then((data) => {
        console.log(data);
    });
// <link rel="stylesheet"
//       href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
// <!-- body -->
// <div class="container text-center">
//   <ul id="results" class="list-inline"></ul></div>
//

const results = document.querySelector("#results");

fetch("http://www.omdbapi.com/?s=harry potter&apikey=adf1f2d7")
    .then(response => response.json())
    .then((data) => {
        data.Search.forEach((result) => {

            const movie = `<li class="list-inline-item">
        <img src="${result.Poster}" alt="">
        <p>${result.Title}</p>
      </li>`;
            results.insertAdjacentHTML("beforeend", movie);
        });
    });



// ????
// <!DOCTYPE html>
// <html>
//   <head>
//     <meta charset="UTF-8">
//     <title>OMDb API</title>
//     <link rel="stylesheet"
//       href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
//   </head>
//   <body>
//     <div class="container text-center">
//       <form class="form-inline" id="search-form">
//         <input type="text" class="form-control" placeholder="Find movie" id="search-input">
//         <input type="submit" class="btn btn-primary">
//       </form>
//       <ul id="results" class="list-inline"></ul>
//     </div>

//     <script src="main.js"></script>
//   </body>
// </html>
const list = document.querySelector('#results');

const insertMovies = (data) => {
  data.Search.forEach((result) => {
    const movie = `<li>
      <img src="${result.Poster}" alt="" />
      <p>${result.Title}</p>
    </li>`;
    list.insertAdjacentHTML('beforeend', movie);
  });
};

const fetchMovies = (query) => {
  fetch(`http://www.omdbapi.com/?s=${query}&apikey=adf1f2d7`)
    .then(response => response.json())
    .then(insertMovies);
};

fetchMovies('harry potter'); // on 1st page load

const form = document.querySelector('#search-form');
form.addEventListener('submit', (event) => {
  event.preventDefault();
  list.innerHTML = '';
  const input = document.querySelector('#search-input');
  fetchMovies(input.value);
});


// POST

const searchAlgoliaPlaces = (event) => {
  fetch("https://places-dsn.algolia.net/1/places/query", {
    method: "POST",
    body: JSON.stringify({ query: event.currentTarget.value })
  })
    .then(response => response.json())
    .then((data) => {
      console.log(data.hits); // Look at local_names.default
    });
};

const input = document.querySelector("#search");
input.addEventListener("keyup", searchAlgoliaPlaces);



document.querySelectorAll("img").forEach((img) => {
  img.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("img-circle");
  });
});


const bindConfirm = (element) => {
  element.addEventListener("click", (event) => {
    if (!confirm("Are you sure you want to delete?")) {
      event.preventDefault();
    }
  });
};

document.querySelectorAll(".confirmable").forEach(bindConfirm);

What you guessed:

?
