class AbstractResource
  def self.attribute(name)
    fields << name
    attr_accessor name
  end

  def self.attributes(*names)
    names.each do |name|
      attribute name
    end
  end

  def self.fields
    @fields = @fields.sort if @fields
    @fields ||= []
  end

  def initialize(args = {})
    args.each_pair do |attr, value|
      next if skip?(attr)

      if %w(id).include? attr
        send "#{attr}=", value.to_i
      else
        send "#{attr}=", value
      end
    end
  end

  def attributes
    Hash[self.class.fields.map { |f| [f, send(f)] }]
  end

  def inspect
    attributes
  end

  def to_s
    attributes
  end

  def each_pair
    attributes.each do |key, val|
      yield(key, val)
    end
  end

  def [](key)
    attributes[key]
  end

  protected

  def skip?(attr)
    !allowed_attribute?(attr)
  end

  def allowed_attribute?(attr)
    self.class.fields.include?(attr.to_sym)
  end

  class << self
    protected

    def collection
      "#{name}Collection".constantize
    end
  end
end
