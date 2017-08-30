class AbstractCollection
  include Enumerable

  attr_accessor :members

  def initialize(args = [])
    @members = []
    return unless args && args.any?
    args.each do |options|
      klass = self.class.name.gsub(/Collection\z/, "")
      @members << klass.constantize.new(options)
    end
  end

  def size
    members.size
  end

  def empty?
    members.empty?
  end

  def each
    members.each do |member|
      yield(member)
    end
  end

  def [](key)
    members[key]
  end

  def find(arg = nil)
    members.select { |m| m.id == arg }.first
  end

  def where(args = {})
    unless args.respond_to? :keys
      raise ArgumentError, "You must provide a hash with valid keys"
    end

    id = args[:id].to_i

    resources = members.select { |m| m.id == id }
    collection = self.class.new
    collection.members = resources
    collection
  end

  def attributes
    members.map(&:attributes)
  end

  def inspect
    attributes
  end

  def to_s
    attributes
  end
end
