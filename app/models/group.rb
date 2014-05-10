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

  def matches_for_score_board_group(score_board)
    teams = self.teams
    matches = []
    type = Match::GROUP_USERS
    if score_board.user.nil?
      type = Match::GROUP_MAIN
    end

    teams.each do |t|
      matches << Match.find_by_team_group_score_board_match_type(t,score_board,type) unless  Match.find_by_team_group_score_board_match_type(t,score_board,type).empty?
    end
    return matches.flatten.uniq!.sort_by{|m| m[:match_number]}   
  end

  def group_team_stats_for_score_board(score_board)
    teams = self.teams
    team_stats = []
    teams.each do |t|
      team_stats << t.team_stats.for_scoreboard(score_board)
    end
    team_stats.sort_by! { |ts| -ts.points}
  end

  #DEPRECATED
  def group_leaders_for_score_board(score_board)
  
  end

  def group_order_for_score_board(score_board)
    team_stats = group_team_stats_for_score_board(score_board)
    leader_1 = team_stats.first
    leader_2 = team_stats.second
    # They are in order.. now, we have to order the others
    current_leaders = set_leader(leader_1,leader_2)
    ts1 = TeamStat.where(team_id: current_leaders[1].id).for_scoreboard(score_board)
    other_leaders = set_leader(ts1, team_stats[2])
    return [current_leaders[0], other_leaders[0],other_leaders[1], team_stats.last.team]
  end

  # By position
  def group_team_stats_for_score_board_by_pos(score_board)
    teams = self.teams
    team_stats = []
    teams.each do |t|
      team_stats << t.team_stats.for_scoreboard(score_board)
    end
    team_stats.sort_by! { |ts| ts.position}

  end

  # By position
  def group_leaders_for_score_board_by_pos(score_board)
    team_stats = group_team_stats_for_score_board_by_pos(score_board)
    leader_1 = team_stats.first
    leader_2 = team_stats.second
    return [leader_1.team, leader_2.team]
  end

  def group_bottom_for_score_board(score_board)
    team_stats = group_team_stats_for_score_board(score_board)
    set_leader(team_stats[2], team_stats[3])
  end

  # Condition that must be met to create a custom
  # leadership

  # points are equal, diff is equal and goals favor
  # is equal 


  # Compares TeamStats
  def set_leader(leader_1, leader_2)
    if leader_1.points > leader_2.points
      return [leader_1.team, leader_2.team]
    elsif leader_1.points == leader_2.points
      if leader_1.diff > leader_2.diff # GOAL DIFF
        return [leader_1.team, leader_2.team]
      elsif leader_1.diff == leader_2.diff
        if leader_1.goals_favor > leader_2.goals_favor # GOAL FAVOR
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
