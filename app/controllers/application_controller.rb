class ApplicationController < ActionController::Base
  helper_method :filter

  protected

  def page
    @page = session[:page] = params[:page]
    @page
  end

  def per_page
    @total_per_page = session[:per_page] = params[:per_page] || 20
  end

  def filter
    unless @filter
      @filter = {}
      f = params[:filter] || {}
      f.each { |key, value| @filter[key.to_sym] = value if value.present? }
    end

    session[:filter] = @filter
    @filter
  end

  def filter_from_session
    session[:filter]
  end

  def page_from_session
    session[:page]
  end

  def per_page_from_session
    session[:per_page]
  end

end
