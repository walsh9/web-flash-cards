class Deck < ActiveRecord::Base
  has_many :cards

  validates :name, presence: true
end
