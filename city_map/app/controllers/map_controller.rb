include MapHelper
class MapController < ApplicationController
  before_action :connect

  def within
    coordinates = []
    params[:coordinates].split('+').each {|t|
      coordinates.push t.sub('_','.').to_f
    }
    puts "controler: #{coordinates}"
    @geojson = get_amenities_within @db_con, params[:type], params[:within], coordinates, params[:color]
    render json: @geojson
  end

  # def amenities
  #   @geojson = get_amenities @db_con
  #   render json: @geojson
  # end

  def connect
    @db_con = ActiveRecord::Base.connection
  end

  def to_geojson data
    result = {}
    data.each do |d|
      result['geometry'] = JSON.parse(d['geometry'])
    end
    puts '\n\n\n\n'
    puts result
    result
  end
end
