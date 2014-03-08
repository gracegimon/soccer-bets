class Tournament < ActiveRecord::Base
  has_many :groups
  has_many :score_boards
  has_many :matches

  scope :active, -> {where is_active: 1}

end
