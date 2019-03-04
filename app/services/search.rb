class Search
  def self.for(*args)
    new(*args).for
  end

  def initialize(term)
    @term = term
  end

  def for
    Event.search(term) + User.search(term)
  end

  private

  attr_reader :term
end
