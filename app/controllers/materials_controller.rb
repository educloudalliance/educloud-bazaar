class MaterialsController < ApplicationController
  before_action :authenticate_viewer!, except: :index

  def index
    @materials = Material.by_viewer(current_session.try(:[], :city_id), current_session.try(:[], :school_id))
      .order(id: :asc).paginate(page: params[:page], per_page: 9)
  end

  def show
    @material = Material.by_viewer(current_session[:city_id], current_session[:school_id]).find(params[:id])
  end
end
