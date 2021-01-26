##
#  defer: true
# webpack-dev-server
# https://github.com/lewagon/rails-stylesheets/blob/master/README.md
# https://uikit.lewagon.com/documentation
# Ubuntu
# https://kitt.lewagon.com/knowledge/tutorials/select2
# https://mattboldt.com/demos/typed-js/
# https://kitt.lewagon.com/knowledge/tutorials/sweetalert

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

##
# // Defining a variable
$gray: #F4F4F4;
  $spacer: 8px; ## every 8px

body {
  background: $gray; // Using this variable
}

.btn {
  padding: $spacer ($spacer * 3);
}

### SCSS nesting

.banner {
  background: red;

  h1 {
    font-size: 50px;
  }
}

## SCSS Chaining
a {
  color: grey;

  &:hover {
    color: black;
  }
}

# SCSS Partials
#// _home.scss
body {
  font-family: Helvetica;
}

#// application.scss
@import "home";

# Asset Pipeline
echo "public/assets" >> .gitignore # Run once
rails assets:precompile
rails assets:clobber

###
# images
it tab => image tag
lt tab => link tag

<%#= image_tag "logo.png", alt: "Le Wagon", width: 200, class: "logo" %>,

### app/assets/stylesheets/_logo.scss */

.logo {
  background-image: asset-url('logo.png');
  background-size: cover;
  height: 100px;
  width: 250px;
}

#/* app/assets/stylesheets/_index.scss */
@import "logo";


### JS time
# <!-- app/views/layouts/application.html.erb -->

<!-- [...] -->
<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>
# <!-- loads app/javascript/packs/application.js -->
</head>
###
##
# import views components
# make a html component
# make a scss component
<%= render "components/navbar" %>
/* app/assets/stylesheets/components/_navbar.scss */
.navbar-lewagon {
  // [...]
  background-color: transparent;
  transition: 0.5s background-color ease;
}

.navbar-lewagon-white {
  background-color: white;
}

/* app/assets/stylesheets/components/_banner.scss */
.home-banner {
  background-image: url('TODO: A picture URL from unsplash.com!');
  background-size: cover;
  height: 100vh;
  color: #eee;
  text-align: center;
  padding-top: 40vh;
}

/* app/assets/stylesheets/components/_index.scss */
@import "banner";

## make JS components
// app/javascript/components/navbar.js

Which event listener do you need to setup in application.js to call libraries’ initialisation code?
  const initUpdateNavbarOnScroll = () => {
    #   const navbar = document.querySelector('.navbar-lewagon');
    #   if (navbar) {
    #       window.addEventListener('scroll', () => {
    #         if (window.scrollY >= window.innerHeight) {
    #           navbar.classList.add('navbar-lewagon-white');
    #         } else {
    #           navbar.classList.remove('navbar-lewagon-white');
    #         }
    #         });
    #         }
    #         }

    #         export { initUpdateNavbarOnScroll };


    #         ## import js
    #         // app/javascript/packs/application.js
    #         import { initUpdateNavbarOnScroll } from '../components/navbar';

    #         document.addEventListener('turbolinks:load', () => {
    #                                     // Call your JS functions here
    #                                     initUpdateNavbarOnScroll();
    #         });
