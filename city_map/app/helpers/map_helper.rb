module MapHelper


  def get_amenities con
    amenities = con.execute("select distinct(amenity) as name from planet_osm_point where amenity != '' order by name").to_a
    result = []
    (0..amenities.size).each { |i| result.push(amenities[i]['name']) unless amenities[i].nil?}
    puts result
    result
  end

  def get_amenities_within con, type, within, center, color
    parse_result type, color, con.execute("SELECT name, ST_AsGeoJSON(ST_Transform(way,4326)) as geometry
                    FROM planet_osm_point
                    WHERE ST_Dwithin(way, ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.54})
                    AND amenity = '#{type}'
                    UNION
                    SELECT name, ST_AsGeoJSON(ST_Transform(ST_Centroid(way),4326)) as geometry
                    FROM planet_osm_polygon
                    WHERE ST_Dwithin(ST_Centroid(way), ST_Transform(ST_SetSRID(ST_MakePoint('#{center[1]}', '#{center[0]}'),4326),900913),#{within.to_f*1.54})
                    AND amenity = '#{type}'
                    ").to_a
  end

  def parse_result type, color, data
    # puts data
    # result = {}
    i = 0
    data.each do |t|
      data[i]['type'] = 'Feature'
      data[i]['geometry'] = JSON.parse(t['geometry'])
      data[i]['properties'] = {}
      data[i]['properties']['description'] = t['name']
      data[i]['properties']['marker-color'] = color
      data[i]['properties']['marker-size'] = 'large'
      data[i]['properties']['marker-symbol'] = get_icon(type)
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

  def get_icon type
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
    else
      'circle'
    end
  end
end
