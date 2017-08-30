class Services::CustomError < StandardError
  attr_reader :message
  attr_reader :http_status
  attr_reader :json_body

  def initialize(params = nil)
    @http_status = params["status"]
    @json_body = params["body"]
    @message = @json_body.present? && @json_body["errors"].present? ? @json_body["errors"][0] : @json_body["message"]
    super(@message)
  end

  def to_s
    status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
    "#{status_string}#{@message}"
  end
end
