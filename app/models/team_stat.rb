class TeamStat < ActiveRecord::Base
  belongs_to :team
  belongs_to :score_board

  DISCARDED = 0
  IN_GROUP = 1
  ROUND_16 = 2
  QUARTERS = 3
  SEMI_FINALS = 4
  THIRD_PLACE_OFF = 5
  FINALS = 6

  def update_team_stats(score)
  	if score.winner_team_id == self.team.id 
  		self.won_games += 1
  	elsif score.winner_team_id == 0
  		self.tied_games += 1
  	else
  		self.lost_games += 1
  	end
  	self.played_games += 1
  end

  def set_current_stats
    matches = Match.find_by_team_group_score_board(self.team,self.score_board)
    matches = matches.select {|m| !m.score.nil?}
    set_won_games(matches)
    set_lost_games(matches)
    set_tied_games(matches)
    set_goals_favor(matches)
    set_goals_aggainst(matches)
    count = 0
    matches.each do |match|
      count += 1 unless match.score.nil?
    end
    self.played_games = count
    self.save
  end

  def set_won_games(matches)
    won_games_matches = matches.select {|m| m.score.winner_team_id == self.team.id}
    self.won_games = won_games_matches.size
  end

  def set_lost_games(matches)
    lost_games_matches = matches.select {|m| m.score.winner_team_id != self.team.id}
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

end
 