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
    return matches
  end

  def matches_for_score_board(score_board)
    teams = self.teams
    matches = []
    teams.each do |t|
      matches << Match.find_by_team_group_score_board(t,score_board) unless  Match.find_by_team_group_score_board(t,score_board).empty?
    end
    return matches.flatten.uniq!   
  end

  def group_leaders_for_score_board(score_board)
    teams = self.teams
    team_stats = []
    teams.each do |t|
      team_stats << t.team_stats.for_scoreboard(score_board)
    end
    team_stats.sort_by! { |ts| -ts.points}

    leader_1 = team_stats.first
    leader_2 = team_stats.second
    set_leader(leader_1,leader_2)
  end

  # Compares TeamStats
  def set_leader(leader_1, leader_2)
    if leader_1.points > leader_2.points
      return [leader_1.team, leader_2.team]
    elsif leader_1.points == leader_2.points
      if leader_1.diff > leader_2.diff
        return [leader_1.team, leader_2.team]
      elsif leader_1.diff == leader_2.diff
        if leader_1.goals_favor > leader_2.goals_favor
          return [leader_1.team, leader_2.team]
        else
          return [leader_2.team, leader_1.team]
        end
      else
        return [leader_2.team, leader_1.team]
      end
    else
      return [leader_2.team, leader_1.team]
    end
  end

end
