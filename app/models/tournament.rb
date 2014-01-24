class Tournament < ActiveRecord::Base
  has_many :groups
  has_many :score_boards
  has_many :matches

end
