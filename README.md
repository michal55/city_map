# CityMap
## Semestral project for my Advanced Database Technologies course @ FIIT STU 2016
## Assignment
Build a map-based application, which lets the user see geo-based data on a map and filter/search through it in a meaningfull way. Specify the details and build it in your language of choice. The application should have 3 components:

1. Custom-styled background map, ideally built with [mapbox](http://mapbox.com). Hard-core mode: you can also serve the map tiles yourself using [mapnik](http://mapnik.org/) or similar tool.
2. Local server with [PostGIS](http://postgis.net/) and an API layer that exposes data in a [geojson format](http://geojson.org/).
3. The user-facing application (web, android, ios, your choice..) which calls the API and lets the user see and navigate in the map and shows the geodata. You can (and should) use existing components, such as the Mapbox SDK, or [Leaflet](http://leafletjs.com/).

## Use cases
### 1. Find all locations of selected type (hospital, restaurant) in a selected radius. Center of the radius is a draggable marker.

All restaurant within 1000 meters from my marker. We can highlight the radius with the Radius On/Off button. The color of the markers is set to orange (EEAA00) and the Maki icon is determined by the amenity. Clicking on a marker shows the amenity's name.

![](https://github.com/michal55/city_map/blob/master/doc/PDT_1.png)

### 2. Find all residential streets which are within a certian distance from at least X selected amenities (from previous UC).

All residential streets within 100 meters from at least 2 restaurants (that are within 1000 meters from my marker)

![](https://github.com/michal55/city_map/blob/master/doc/pdt_2.png)

### 3. Find an amenity by name.

All points and polygons with the name attribute = 'Aupark' (blue) and 'Eurovea' (green).

![](https://github.com/michal55/city_map/blob/master/doc/pdt_3.png)

## Data
- [Open Street Maps](https://www.openstreemap.org)

## Technologies
 - Ruby on Rails
 - Mapbox
 - PostgreSQL
 - PostGIS

## API
```ruby
  get 'map/within/:type/:within/:coordinates/:color' => 'map#within'

  get 'map/within/polygon/:id' => 'map#polygon'

  get 'map/streets_within/:type/:within/:coordinates/:color/:streets_within/:number_of' => 'map#streets_within'

  get 'map/find/:name/:color' => 'map#find'
```

