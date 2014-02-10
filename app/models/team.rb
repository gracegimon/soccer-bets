class Team < ActiveRecord::Base
  has_many :matches
  has_many :team_stats

  belongs_to :group
  validates :name, uniqueness: true



end
