module MapHelper


  def get_amenities con
    amenities = con.execute("select distinct(amenity) as name from planet_osm_point where amenity != '' order by name").to_a
    result = []
    (0..amenities.size).each { |i| result.push(amenities[i]['name']) unless amenities[i].nil?}
    puts result
    result
  end

  def get_names con
    names = con.execute("select distinct(name) as name from planet_osm_point where name <> ''
                         union select distinct(name) as name from planet_osm_polygon where name <> ''
                         union select distinct(name) as name from planet_osm_line order by name").to_a
    result = []
    (0..names.size).each { |i| result.push(names[i]['name']) unless names[i].nil?}
    result
  end

  def find_by_name con, name, color
    objects = con.execute("SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry
                  FROM  planet_osm_point where name = '#{name}'
                  UNION select name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry FROM planet_osm_polygon WHERE name = '#{name}'
                  UNION SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry FROM planet_osm_line WHERE name = '#{name}'").to_a
    i = 0
    objects.each do |t|
      objects[i]['type'] = 'Feature'
      objects[i]['geometry'] = JSON.parse(t['geometry'])
      objects[i]['properties'] = {}
      objects[i]['properties']['description'] = t['name']
      if objects[i]['geometry']['type'].eql?('Point')
        objects[i]['properties']['marker-color'] = color
        objects[i]['properties']['marker-size'] = 'large'
        objects[i]['properties']['marker-symbol'] = get_icon get_type con, objects[i]['geometry']
      end
      i = i + 1
    end
    objects
  end

  def get_type con, geojson
    result = con.execute("SELECT amenity FROM planet_osm_point where way = ST_Transform(ST_SetSRID(ST_GeomFromGeoJson('#{geojson.to_json}'),4326),900913)").to_a
    unless result.nil?
      unless result[0].nil?
        puts result[0]
        return result[0]['amenity']
      end
    end
    nil
  end

  def get_amenities_within con, type, within, center, color
    parse_result type, color, con.execute("SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry
                    FROM planet_osm_point
                    WHERE ST_Dwithin(way, ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.5})
                    AND amenity = '#{type}'
                    UNION
                    SELECT name, ST_AsGeoJSON(ST_Transform(ST_Centroid(way),4326)) as geometry
                    FROM planet_osm_polygon
                    WHERE ST_Dwithin(ST_Centroid(way), ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.5})
                    AND amenity = '#{type}'
                    ").to_a
  end

  def get_streets_within con, type, within, center, color, streets_within, number_of
    
    parse_result type, color, con.execute("
          SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry FROM planet_osm_line WHERE osm_id IN
              (SELECT R.osm_id from (
                  SELECT STREETS.osm_id, count(PUBS.osm_id) from
                      (select name, osm_id, way
                      from planet_osm_line where highway = 'residential' and ST_Dwithin(way, ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.5}))
                       STREETS join
                      (SELECT osm_id, way from planet_osm_point
                      WHERE amenity = '#{type}' AND
                      ST_Dwithin(way, ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.5})
                      UNION
                      SELECT osm_id, ST_Centroid(way) as way
                      FROM planet_osm_polygon
                      WHERE ST_Dwithin(ST_Centroid(way), ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.5})
                      AND amenity = '#{type}'
                      ) PUBS
                      on ST_Dwithin(STREETS.way, PUBS.way, #{streets_within.to_f*1.5})
                      GROUP BY STREETS.osm_id) R where R.count >= #{number_of})").to_a
  end


    def parse_result type, color, data
    i = 0
    data.each do |t|
      data[i]['type'] = 'Feature'
      data[i]['geometry'] = JSON.parse(t['geometry'])
      data[i]['properties'] = {}
      data[i]['properties']['description'] = t['name']
      if data[i]['geometry']['type'].eql?('Point')
        data[i]['properties']['marker-color'] = color
        data[i]['properties']['marker-size'] = 'large'
        data[i]['properties']['marker-symbol'] = get_icon(type)
      end
      i = i + 1
    end
    # puts data
    data
  end

  def get_icon type
    puts type
    case type
    when 'pub'
      'beer'
    when 'bar'
      'bar'
    when 'hospital', 'doctors'
      'hospital'
    when 'restaurant'
      'restaurant'
    when 'food-cort'
      'fast-food'
    when 'cafe'
      'cafe'
    when 'bank', 'atm'
      'bank'
    when 'cinema'
      'cinema'
    when 'library'
      'library'
    when 'marketplace'
      'shop'
    when 'pharmacy'
      'pharmacy'
    when 'police'
      'police'
    when 'post'
      'post'
    when 'place-of-worship'
      'religious-christian'
    when 'bicycle_parking'
      'parking'
    else
      'circle'
    end
  end
end
