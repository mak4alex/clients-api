class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404



  def render_404
    render json: { message: 'Resource not found.' }, status: 404
  end

  protected

    def get_meta (collection, params)
      meta = {}
      meta[:pagination] = pagination(collection, params) if params[:page].present?
      meta[:sort] = params[:sort] if params[:sort].present?
      meta
    end

    def pagination(paginated_array, params)
      { page: params[:page].to_i,
        per_page: params[:per_page].to_i,
        total_pages: paginated_array.total_pages,
        total_objects: paginated_array.total_count }
    end

end
