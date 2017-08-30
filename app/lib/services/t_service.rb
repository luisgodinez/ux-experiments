class Services::TService < Services::Base
  def initialize(api_url)
    super
  end

  def get(path, params = {})
    response = connection.get(path, params)
    raise Services::CustomError.new(response) unless response[:success]
    response
  end

  def feed(name, params)
    response = get(feed_path(name), params)
    Feed.new(response[:body])
  end

  private

  def base_path
    'v1'
  end

  def feed_path(name)
    "#{base_path}/feed/#{name}"
  end
end
