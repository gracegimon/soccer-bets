class Group < ActiveRecord::Base
  belongs_to :tournament
  has_many :group_teams
  has_many :teams, :through => :group_teams
  has_many :group_matches
  has_many :matches, :through => :group_matches

  def group_matches
  	teams = self.teams
  	matches = []
  	teams.each do |t|
  		matches << Match.find_by_team_group(t) unless  Match.find_by_team_group(t).nil?
  	end
  end

end
