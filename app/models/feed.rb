class Feed < AbstractResource
  attributes :has_next_page, :cached, :next_page, :data, :posts

  def initialize(args = {})
    super(args)
    @posts = PostCollection.new args[:data] || data
  end

  def has_next_page?
    has_next_page
  end

  def next_page_params
    return nil unless has_next_page?
    Rack::Utils.parse_nested_query(URI.parse(next_page).query).except('api_token')
  end
end
