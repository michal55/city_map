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

  def polygon
    @geojson = get_polygon_by_id @db_con, params[:id]
    render json: @geojson
  end

  def streets_within
    coordinates = []
    params[:coordinates].split('+').each {|t|
      coordinates.push t.sub('_','.').to_f
    }
    @geojson = get_streets_within @db_con, params[:type], params[:within], coordinates, params[:color], params[:streets_within], params[:number_of]
    render json: @geojson
  end

  def find
    @geojson = find_by_name @db_con, params[:name], params[:color]
    puts @geojson
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
