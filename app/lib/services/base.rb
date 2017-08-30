class Services::Base
  def initialize(api_url)
    @api_url = api_url
  end

  def connection
    Services::Connection.new(api_url)
  end

  private
  attr_reader :api_url

  def base_path
    ''
  end
end
