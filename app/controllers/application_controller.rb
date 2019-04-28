class ApplicationController < ActionController::Base

  protected

  def page
    params[:page]
  end

  def per_page
    @total_per_page = params[:per_page] || 10
  end

end
