include MapHelper
class MapController < ApplicationController
  before_action :connect

  def within
    coordinates = []
    params[:coordinates].split('+').each {|t|
      coordinates.push t.sub('_','.').to_f
    }
    @geojson = get_amenities_within @db_con, params[:type], params[:within], coordinates, params[:color]
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

  def connect
    @db_con = ActiveRecord::Base.connection
  end
end
