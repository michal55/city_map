# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161106172657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "maps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planet_osm_line", id: false, force: :cascade do |t|
    t.integer  "osm_id",             limit: 8
    t.text     "access"
    t.text     "addr:housename"
    t.text     "addr:housenumber"
    t.text     "addr:interpolation"
    t.text     "admin_level"
    t.text     "aerialway"
    t.text     "aeroway"
    t.text     "amenity"
    t.text     "area"
    t.text     "barrier"
    t.text     "bicycle"
    t.text     "brand"
    t.text     "bridge"
    t.text     "boundary"
    t.text     "building"
    t.text     "construction"
    t.text     "covered"
    t.text     "culvert"
    t.text     "cutting"
    t.text     "denomination"
    t.text     "disused"
    t.text     "embankment"
    t.text     "foot"
    t.text     "generator:source"
    t.text     "harbour"
    t.text     "highway"
    t.text     "historic"
    t.text     "horse"
    t.text     "intermittent"
    t.text     "junction"
    t.text     "landuse"
    t.text     "layer"
    t.text     "leisure"
    t.text     "lock"
    t.text     "man_made"
    t.text     "military"
    t.text     "motorcar"
    t.text     "name"
    t.text     "natural"
    t.text     "office"
    t.text     "oneway"
    t.text     "operator"
    t.text     "place"
    t.text     "population"
    t.text     "power"
    t.text     "power_source"
    t.text     "public_transport"
    t.text     "railway"
    t.text     "ref"
    t.text     "religion"
    t.text     "route"
    t.text     "service"
    t.text     "shop"
    t.text     "sport"
    t.text     "surface"
    t.text     "toll"
    t.text     "tourism"
    t.text     "tower:type"
    t.text     "tracktype"
    t.text     "tunnel"
    t.text     "water"
    t.text     "waterway"
    t.text     "wetland"
    t.text     "width"
    t.text     "wood"
    t.integer  "z_order"
    t.float    "way_area"
    t.geometry "way",                limit: {:srid=>900913, :type=>"line_string"}
  end

  add_index "planet_osm_line", ["osm_id"], name: "planet_osm_line_pkey", using: :btree
  add_index "planet_osm_line", ["way"], name: "planet_osm_line_index", using: :gist

  create_table "planet_osm_nodes", id: :bigserial, force: :cascade do |t|
    t.integer "lat",  null: false
    t.integer "lon",  null: false
    t.text    "tags",              array: true
  end

  create_table "planet_osm_point", id: false, force: :cascade do |t|
    t.integer  "osm_id",             limit: 8
    t.text     "access"
    t.text     "addr:housename"
    t.text     "addr:housenumber"
    t.text     "addr:interpolation"
    t.text     "admin_level"
    t.text     "aerialway"
    t.text     "aeroway"
    t.text     "amenity"
    t.text     "area"
    t.text     "barrier"
    t.text     "bicycle"
    t.text     "brand"
    t.text     "bridge"
    t.text     "boundary"
    t.text     "building"
    t.text     "capital"
    t.text     "construction"
    t.text     "covered"
    t.text     "culvert"
    t.text     "cutting"
    t.text     "denomination"
    t.text     "disused"
    t.text     "ele"
    t.text     "embankment"
    t.text     "foot"
    t.text     "generator:source"
    t.text     "harbour"
    t.text     "highway"
    t.text     "historic"
    t.text     "horse"
    t.text     "intermittent"
    t.text     "junction"
    t.text     "landuse"
    t.text     "layer"
    t.text     "leisure"
    t.text     "lock"
    t.text     "man_made"
    t.text     "military"
    t.text     "motorcar"
    t.text     "name"
    t.text     "natural"
    t.text     "office"
    t.text     "oneway"
    t.text     "operator"
    t.text     "place"
    t.text     "poi"
    t.text     "population"
    t.text     "power"
    t.text     "power_source"
    t.text     "public_transport"
    t.text     "railway"
    t.text     "ref"
    t.text     "religion"
    t.text     "route"
    t.text     "service"
    t.text     "shop"
    t.text     "sport"
    t.text     "surface"
    t.text     "toll"
    t.text     "tourism"
    t.text     "tower:type"
    t.text     "tunnel"
    t.text     "water"
    t.text     "waterway"
    t.text     "wetland"
    t.text     "width"
    t.text     "wood"
    t.integer  "z_order"
    t.geometry "way",                limit: {:srid=>900913, :type=>"point"}
  end

  add_index "planet_osm_point", ["osm_id"], name: "planet_osm_point_pkey", using: :btree
  add_index "planet_osm_point", ["way"], name: "planet_osm_point_index", using: :gist

  create_table "planet_osm_polygon", id: false, force: :cascade do |t|
    t.integer  "osm_id",             limit: 8
    t.text     "access"
    t.text     "addr:housename"
    t.text     "addr:housenumber"
    t.text     "addr:interpolation"
    t.text     "admin_level"
    t.text     "aerialway"
    t.text     "aeroway"
    t.text     "amenity"
    t.text     "area"
    t.text     "barrier"
    t.text     "bicycle"
    t.text     "brand"
    t.text     "bridge"
    t.text     "boundary"
    t.text     "building"
    t.text     "construction"
    t.text     "covered"
    t.text     "culvert"
    t.text     "cutting"
    t.text     "denomination"
    t.text     "disused"
    t.text     "embankment"
    t.text     "foot"
    t.text     "generator:source"
    t.text     "harbour"
    t.text     "highway"
    t.text     "historic"
    t.text     "horse"
    t.text     "intermittent"
    t.text     "junction"
    t.text     "landuse"
    t.text     "layer"
    t.text     "leisure"
    t.text     "lock"
    t.text     "man_made"
    t.text     "military"
    t.text     "motorcar"
    t.text     "name"
    t.text     "natural"
    t.text     "office"
    t.text     "oneway"
    t.text     "operator"
    t.text     "place"
    t.text     "population"
    t.text     "power"
    t.text     "power_source"
    t.text     "public_transport"
    t.text     "railway"
    t.text     "ref"
    t.text     "religion"
    t.text     "route"
    t.text     "service"
    t.text     "shop"
    t.text     "sport"
    t.text     "surface"
    t.text     "toll"
    t.text     "tourism"
    t.text     "tower:type"
    t.text     "tracktype"
    t.text     "tunnel"
    t.text     "water"
    t.text     "waterway"
    t.text     "wetland"
    t.text     "width"
    t.text     "wood"
    t.integer  "z_order"
    t.float    "way_area"
    t.geometry "way",                limit: {:srid=>900913, :type=>"geometry"}
  end

  add_index "planet_osm_polygon", ["osm_id"], name: "planet_osm_polygon_pkey", using: :btree
  add_index "planet_osm_polygon", ["way"], name: "planet_osm_polygon_index", using: :gist

  create_table "planet_osm_rels", id: :bigserial, force: :cascade do |t|
    t.integer "way_off", limit: 2
    t.integer "rel_off", limit: 2
    t.integer "parts",   limit: 8, array: true
    t.text    "members",           array: true
    t.text    "tags",              array: true
  end

  add_index "planet_osm_rels", ["parts"], name: "planet_osm_rels_parts", using: :gin

  create_table "planet_osm_roads", id: false, force: :cascade do |t|
    t.integer  "osm_id",             limit: 8
    t.text     "access"
    t.text     "addr:housename"
    t.text     "addr:housenumber"
    t.text     "addr:interpolation"
    t.text     "admin_level"
    t.text     "aerialway"
    t.text     "aeroway"
    t.text     "amenity"
    t.text     "area"
    t.text     "barrier"
    t.text     "bicycle"
    t.text     "brand"
    t.text     "bridge"
    t.text     "boundary"
    t.text     "building"
    t.text     "construction"
    t.text     "covered"
    t.text     "culvert"
    t.text     "cutting"
    t.text     "denomination"
    t.text     "disused"
    t.text     "embankment"
    t.text     "foot"
    t.text     "generator:source"
    t.text     "harbour"
    t.text     "highway"
    t.text     "historic"
    t.text     "horse"
    t.text     "intermittent"
    t.text     "junction"
    t.text     "landuse"
    t.text     "layer"
    t.text     "leisure"
    t.text     "lock"
    t.text     "man_made"
    t.text     "military"
    t.text     "motorcar"
    t.text     "name"
    t.text     "natural"
    t.text     "office"
    t.text     "oneway"
    t.text     "operator"
    t.text     "place"
    t.text     "population"
    t.text     "power"
    t.text     "power_source"
    t.text     "public_transport"
    t.text     "railway"
    t.text     "ref"
    t.text     "religion"
    t.text     "route"
    t.text     "service"
    t.text     "shop"
    t.text     "sport"
    t.text     "surface"
    t.text     "toll"
    t.text     "tourism"
    t.text     "tower:type"
    t.text     "tracktype"
    t.text     "tunnel"
    t.text     "water"
    t.text     "waterway"
    t.text     "wetland"
    t.text     "width"
    t.text     "wood"
    t.integer  "z_order"
    t.float    "way_area"
    t.geometry "way",                limit: {:srid=>900913, :type=>"line_string"}
  end

  add_index "planet_osm_roads", ["osm_id"], name: "planet_osm_roads_pkey", using: :btree
  add_index "planet_osm_roads", ["way"], name: "planet_osm_roads_index", using: :gist

  create_table "planet_osm_ways", id: :bigserial, force: :cascade do |t|
    t.integer "nodes", limit: 8, null: false, array: true
    t.text    "tags",                         array: true
  end

  add_index "planet_osm_ways", ["nodes"], name: "planet_osm_ways_nodes", using: :gin

  create_table "shapes", force: :cascade do |t|
    t.geometry  "shape1",       limit: {:srid=>0, :type=>"geometry"}
    t.geometry  "shape2",       limit: {:srid=>0, :type=>"geometry"}
    t.geometry  "path",         limit: {:srid=>3785, :type=>"line_string"}
    t.geography "lonlat",       limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.geography "lonlatheight", limit: {:srid=>4326, :type=>"point", :has_z=>true, :geographic=>true}
  end

end
