class Group < ActiveRecord::Base
  belongs_to :tournament
  has_many :group_teams
  has_many :teams, :through => :group_teams

end
