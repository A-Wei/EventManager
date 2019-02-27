class Search
  def self.for(*args)
    new(*args).for
  end

  def initialize(term)
    @term = term
  end

  def for
    Event.search_by_title(term) + User.search_by_email(term)
  end

  private

  attr_reader :term
end
