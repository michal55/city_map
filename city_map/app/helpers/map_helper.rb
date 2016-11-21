module MapHelper

  def get_pub(con, id)
    parse con.execute("select osm_id, name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry from planet_osm_point where amenity = 'pub' and osm_id =#{id}").to_a
  end

  def get_pub_way con, id
    parse_point con.execute("select ST_AsGeoJSON(ST_Transform(way,4326)) as geometry from planet_osm_point where amenity = 'pub' and osm_id =#{id}").to_a
  end

  def get_pubs con
    parse_collection con.execute("select osm_id, name from planet_osm_point where amenity = 'pub'").to_a
  end

  def parse_point data
    result = {}
    result['type'] = 'Feature'
    result['properties'] = {}
    result['properties']['icon'] = {}
    result['properties']['icon']['className'] = 'my-icon'
    result['geometry'] = {}
    data.each do |t|
      result['geometry'] = t['geometry']
    end
    result
  end

  def parse_collection data
    result = {}
    data.each do |t|
      result[t['name']] = t['osm_id']
    end
    result
  end

  def parse result
    result.each do |t|
      result[0]['type'] = 'Feature'
      result[0]['geometry'] = JSON.parse(result[0]['geometry'])
      result[0]['properties'] = {}
      result[0]['properties']['marker-color'] = '#3ca0d3'
      result[0]['properties']['marker-size'] = 'large'
      result[0]['properties']['marker-symbol'] = 'rocket'
    end
    puts result
    result
  end
end
