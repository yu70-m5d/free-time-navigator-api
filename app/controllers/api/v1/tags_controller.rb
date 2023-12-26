class Api::V1::TagsController < ApplicationController
  def index
    @tags = Tag.all.includes(:spots)
    render json: @tags
  end
end
