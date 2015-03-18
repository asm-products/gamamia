class Platform
  attr_reader :id, :name

  def initialize(name)
    @name = name
    @id = name
  end

  def self.all
    [
      Platform.new('PC'),
      Platform.new('Mac'),
      Platform.new('Linux'),
      Platform.new('iOS'),
      Platform.new('Android'),
      Platform.new('Windows Phone'),
      Platform.new('Web')
    ]
  end
end
