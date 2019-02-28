class Event < ApplicationRecord
  include PgSearch

  belongs_to :user

  validates :end_at, presence: true, in_future: true
  validates :start_at, presence: true, in_future: true
  validates :title, :location, :description, presence: true

  validate :end_at_ahead_of_start_at

  scope :in_future, -> { where('start_at > ?', Time.now).order(start_at: :asc) }
  pg_search_scope :search, against: [:title, :location, :description],
                           using: {
                             tsearch: {
                               any_word: true,
                               dictionary: 'english',
                               normalization: 8,
                             },
                             trigram: {
                               threshold: 0.2,
                             },
                           }

  def creator?(given_user)
    user == given_user
  end

  private

  def end_at_ahead_of_start_at
    return if start_at.nil? || end_at.nil?

    if start_at > end_at
      errors.add(:end_at, message: "End at can't be earlier then start at")
    end
  end
end
