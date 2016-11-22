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

# bank, bar, cafe, casino, fast_food, gym, hospital, library, maretkplace, nightclue
  def get_amenities con, type
    parse_collection con.execute("select osm_id, name from planet_osm_point where amenity = \'#{type}\'").to_a
  end

  def get_amenities_within con, type, within, center
    # puts con
    puts type
    puts within
    parse_result con.execute("SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry,  dist from (
                                      SELECT osm_id, name, way, ST_Distance(way, (SELECT way from planet_osm_point where osm_id =#{center})) as dist
                                      FROM planet_osm_point
                                      where amenity = '#{type}' and osm_id <> #{center}) as SUB where dist < #{within}").to_a
  end

  def parse_result data
    # puts data
    # result = {}
    i = 0
    data.each do |t|
      data[i]['type'] = 'Feature'
      data[i]['geometry'] = JSON.parse(t['geometry'])
      data[i]['properties'] = {}
      data[i]['properties']['description'] = t['name']
      data[i]['properties']['marker-color'] = '#3ca0d3'
      data[i]['properties']['marker-size'] = 'large'
      data[i]['properties']['marker-symbol'] = 'rocket'
      i = i + 1
    end
    puts data
    data
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
