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
  def get_places_by_amenity con, type
    parse_collection con.execute("select osm_id, name from planet_osm_point where amenity = \'#{type}\'").to_a
  end

  def get_amenities con
    amenities = con.execute("select distinct(amenity) as name from planet_osm_point where amenity != '' order by name").to_a
    result = []
    (0..amenities.size).each { |i| result.push(amenities[i]['name']) unless amenities[i].nil?}
    puts result
    result
  end

  def get_amenities_within con, type, within, center
    puts "helper\n"
    puts type
    puts within
    puts center
    parse_result con.execute("SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry
                    FROM planet_osm_point
                    WHERE ST_Dwithin(way, ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.54})
                    AND amenity = '#{type}'").to_a
    # and osm_id <> 1798714617
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
    # puts data
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
    # puts result
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
    # puts result
    result
  end
end
