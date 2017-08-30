class ThemesController < ApplicationController
  before_action :set_theme, only: :show

  def index
    @themes = Theme.all
  end

  def show
  end

  def posts
    @next_page_params = params[:next_page_params].present? ? params[:next_page_params] : {}

    @service = Services::TService.new(ENV['T_API_URL'])
    @feed = @service.feed(ENV['T_API_FEED_NAME'], @next_page_params.merge(api_token: ENV['T_API_TOKEN']) )

    payload = {
      posts: @feed.posts,
      next_page_params: @feed.next_page_params,
      has_next_page: @feed.has_next_page?
    }

    respond_to do |format|
      format.json { render json: payload }
    end
  end

  private

  def set_theme
    @theme = Theme.find_by(id: params[:id])
  end
end
