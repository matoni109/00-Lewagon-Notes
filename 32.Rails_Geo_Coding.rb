#
#
## https://community.algolia.com/places/examples.html
#
"Eiffel Tower" → { lat: 48.8582, lng: 2.2945 }

gem 'geocoder'
# https://github.com/alexreisner/geocoder

bundle install
rails generate geocoder:config

# config/initializers/geocoder.rb:
Geocoder.configure(
  # [...]
  lookup: :nominatim,
  units: :km, # defaults to miles (:mi)
  # [...]
)

# add to bikes and users
rails g migration AddCoordinatesTo*Flats* latitude:float longitude:float
rails g migration AddCoordinatesToBikes latitude:float longitude:float
## app/models/bikes.rb
class Bike < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end

Flat.create(address: '16 Villa Gaudelet, Paris', name: 'Le Wagon HQ')
# => #<Flat:0x007fad2e720898
#  [...]
#  name: "Le Wagon HQ",
#  latitude: 48.8648482,
#  longitude: 2.3798534,
#  address: "16 Villa Gaudelet, Paris">

Flat.near('Tour Eiffel', 10)      # venues within 10 km of Tour Eiffel
Flat.near([40.71, 100.23], 20)    # venues within 20 km of a point

# app/controllers/flats_controller.rb
class FlatsController < ApplicationController
  def index
    @flats = Flat.all
    #@flats = Flat.where.not(latitude: nil,longitude:nil)

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end
end

## now for VIEWS :

<!-- app/views/flats/index.html.erb -->

<div id="map"
style="width: 100%; height: 600px;"
data-markers="<%= @markers.to_json %>"
data-mapbox-api-key="<%= ENV['MAPBOX_API_KEY'] %>">
#</div>

# ## yarn add mapbox-gl

#Check out the GIST

# https://gist.github.com/Eschults/d82b1d481eac8639dbf5f70b895f11b0


export { initMapbox };

########
More Maps
#######
# app/controllers/flats_controller.rb
class FlatsController < ApplicationController
  def index
    @flats = Flat.all

    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { flat: flat })
        image_url: helpers.asset_url('REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS')
      }
    end
  end
end

### user partials
<!-- app/views/flats/_info_window.html.erb -->

<h2><%= flat.name %></h2>
<p><%= flat.address %></p>

####
add to js GIST

// app/javascript/plugins/init_mapbox.js
// [ ... ]
const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
                    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

                    new mapboxgl.Marker()
                    .setLngLat([ marker.lng, marker.lat ])
                    .setPopup(popup) // add this
                    .addTo(map);
  });
};

######
// app/assets/stylesheets/components/_map.scss
.mapboxgl-popup {
  max-width: 200px;
}

.mapboxgl-popup-content {
  text-align: center;
  font-family: 'Open Sans', sans-serif;
}

## remember to import into _index.scss

### CUSTOM MARKERS ###
markers.forEach((marker) => {
                  const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

                  // Create a HTML element for your custom marker
                  const element = document.createElement('div');
                  element.className = 'marker';
                  element.style.backgroundImage = `url('${marker.image_url}')`;
                  element.style.backgroundSize = 'contain';
                  element.style.width = '25px';
                  element.style.height = '25px';

                  // Pass the element as an argument to the new marker
                  new mapboxgl.Marker(element)
                  .setLngLat([marker.lng, marker.lat])
                  .setPopup(popup)
                  .addTo(map);
});

##### Adding SEARCH ####
yarn add @mapbox/mapbox-gl-geocoder


/* app/assets/application.scss */

/* In the "external libraries" section */
@import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder';


### add to init_mapbox

// app/javascript/plugins/init_mapbox.js
// [...]
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
// [...]
if (mapElement) {
    // [...]
    map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                        mapboxgl: mapboxgl }));
  }


  ######https://github.com/mapbox/mapbox-gl-geocoder

  #### https://docs.mapbox.com/mapbox-gl-js/example/mapbox-gl-geocoder

  yarn add places.js

  touch app/javascript/plugins/init_autocomplete.js

  / app/javascript/plugins/init_autocomplete.js
  import places from 'places.js';

  const initAutocomplete = () => {
    const addressInput = document.getElementById('flat_address');
    if (addressInput) {
        places({ container: addressInput });
      }
      };

      export { initAutocomplete };


      ### mapbox code
      ## https://docs.mapbox.com/mapbox-gl-js/example/mapbox-gl-geocoder-outside-the-map/

      <script>
      # // TO MAKE THE MAP APPEAR YOU MUST
      # // ADD YOUR ACCESS TOKEN FROM
      # // https://account.mapbox.com
      mapboxgl.accessToken = '<your access token here>';
      var map = new mapboxgl.Map({
                                   container: 'map',
                                   style: 'mapbox://styles/mapbox/streets-v11',
                                   center: [-79.4512, 43.6568],
                                   zoom: 13
      });

      var geocoder = new MapboxGeocoder({
                                          accessToken: mapboxgl.accessToken,
                                          mapboxgl: mapboxgl
      });

      document.getElementById('geocoder').appendChild(geocoder.onAdd(map));
      </script>
