class TeamStat < ActiveRecord::Base
  belongs_to :team, touch: true
  belongs_to :score_board

  scope :for_scoreboard, -> (score_board) {where(score_board_id: score_board.id).first}

  DISCARDED = 0
  IN_GROUP = 1
  ROUND_16 = 2
  QUARTERS = 3
  SEMI_FINALS = 4
  THIRD_PLACE_OFF = 5
  FINALS = 6

  def set_current_stats
    match_type = Match::GROUP_USERS
    if self.score_board.is_main?
      match_type = Match::GROUP_MAIN
    end
    matches = Match.find_by_team_group_score_board_match_type(self.team,self.score_board, match_type)
    matches = matches.select {|m| !m.score.nil?}
    set_won_games(matches)
    set_lost_games(matches)
    set_tied_games(matches)
    set_goals_favor(matches)
    set_goals_aggainst(matches)
    set_played_games(matches)
    set_points
    self.save
  end

  def set_won_games(matches)
    won_games_matches = matches.select {|m| m.score.winner_team_id == self.team.id}
    self.won_games = won_games_matches.size
  end

  def set_lost_games(matches)
    lost_games_matches = matches.select {|m| m.score.winner_team_id != self.team.id && m.score.winner_team_id != 0}
    self.lost_games = lost_games_matches.size
  end

  def set_tied_games(matches)
    tied_games_matches = matches.select {|m| m.score.winner_team_id == 0}
    self.tied_games = tied_games_matches.size
  end

  def set_goals_favor(matches)
    goals = 0
    matches.each do |m|
      if self.team == m.team_1
        goals += m.score.team_1_goals
      elsif self.team == m.team_2
        goals += m.score.team_2_goals
      else
        return
      end
    end
    self.goals_favor = goals
  end

  def set_goals_aggainst(matches)
    goals = 0
    matches.each do |m|
      if self.team == m.team_1
        goals += m.score.team_2_goals
      elsif self.team == m.team_2
        goals += m.score.team_1_goals
      else
        return
      end
    end
    self.goals_aggainst = goals    
  end

  def set_goals_diff
    return self.goals_favor - self.goals_aggainst
  end

  def set_played_games(matches)
    count = 0
    matches.each do |match|
      count += 1 unless match.score.nil?
    end
    self.played_games = count
  end

  def set_points
    points = 0
    points += 3*self.won_games
    points += self.tied_games
    self.points = points 
  end

  def set_position(pos)
    self.position = pos
  end

  def final_position
    unless self.position.nil?
      if self.position == 1
        return  "First place"
      elsif self.position == 2
        return "Second place"
      else
        return " - "
      end
    end
  end

  def diff
    self.goals_favor - self.goals_aggainst
  end

  # points are equal, diff is equal and goals favor
  # is equal 
  def same_position_as(team_stat_1)
    return ( (self.points == team_stat_1.points) &&
              (self.diff == team_stat_1.diff) && (self.goals_favor == team_stat_1.goals_favor) )  

  end

end
 