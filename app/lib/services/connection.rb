require "faraday"

class Services::Connection
  def initialize(api_url)
    @link = Faraday.new(api_url) do |f|
      f.request :json
      f.response :json, content_type: "application/json"
      f.adapter Faraday.default_adapter
    end
  end

  def get(*args)
    result link.get(*args)
  end

  def result(res)
    {
      success: res.success?,
      status: res.status,
      body: res.body
    }
  end

  private

  attr_reader :link
end
