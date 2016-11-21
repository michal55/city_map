include MapHelper
class MapController < ApplicationController
  before_action :connect

  def pub
    @geojson = get_pub(@db_con, params[:id])
    # @geojson = to_geojson get_pub(@db_con, params[:id])
    puts "\n\n\n"
    puts @geojson
    puts "\n\n\n"
    render json: @geojson
  end

  def pub_way
    @geojson = get_pub_way @db_con, params[:id]
    puts @geojson
  end

  def pubs
    @geojson = get_pubs @db_con
    render json: @geojson
  end

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
