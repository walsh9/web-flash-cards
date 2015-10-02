class Card < ActiveRecord::Base
  belongs_to :deck

  validates :front, :back, :deck_id, presence: true
end
