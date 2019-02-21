class DigestToken
  def self.generate(*args)
    new(*args).generate
  end

  def initialize(string:)
    @string = string
  end

  def generate
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  attr_reader :string
end
