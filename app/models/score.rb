class Score < ActiveRecord::Base
  belongs_to :score_board
  belongs_to :match, touch: true

  after_update :update_match_stats, :calculate_all_score_boards 
  after_create :update_match_stats, :calculate_all_score_boards 

  before_create :set_winner
  before_update :set_winner

#  validates :match, uniqueness: { scope: :match}
  validates :team_1_goals, :numericality => {:greater_than_or_equal_to => 0}
  validates :team_2_goals, :numericality => {:greater_than_or_equal_to => 0}
#  validates :winner_team_id, presence: true

  def match
  	Match.find(self.match_id)
  end

  def score_board
  	ScoreBoard.find(self.scoreboard_id)
  end

  def set_winner
    unless team_1_goals.nil? || team_2_goals.nil?
    	if team_1_goals > team_2_goals
    		self.winner_team_id = self.match.team_1_id
    	elsif team_2_goals > team_1_goals
    		self.winner_team_id = self.match.team_2_id
    	else
    		self.winner_team_id = 0 # This means tie
    	end
    end
  end

  def update_match_stats
    if self.match.match_type == Match::GROUP_USERS || self.match.match_type == Match::GROUP_MAIN
      self.match.update_teams_stats
      leaders = self.match.team_1.group.group.group_leaders_for_score_board(self.score_board)
      bottom = self.match.team_1.group.group.group_bottom_for_score_board(self.score_board)
      set_group_positions(leaders,bottom)
    end

  end

  def set_group_positions(leaders,bottom)
    team_s_1 = leaders.first.team_stats.for_scoreboard(self.score_board)
    team_s_1.set_position(1)
    team_s_2 = leaders.second.team_stats.for_scoreboard(self.score_board)
    team_s_2.set_position(2)
    team_s_1.save
    team_s_2.save
    team_s_3 = bottom.first.team_stats.for_scoreboard(self.score_board)
    team_s_4 = bottom.first.team_stats.for_scoreboard(self.score_board)
    team_s_3.set_position(3)
    team_s_3.save
    team_s_4.set_position(4)
    team_s_4.save
  end

  def update_score_boards
    binding.pry
    if self.score_board.id == ScoreBoard.main_score_board.id
      match_type = self.match.match_type
      match_number = self.match.match_number
      @score_boards = ScoreBoard.not_main_board.active
      binding.pry
      @score_boards.each do |score_board|
        if match_type == Match::GROUP_MAIN
          score_board.set_points_for_group_phase(self, match_number)
        end
      end
    end
  end

  def calculate_all_score_boards
    if self.score_board.id == ScoreBoard.main_score_board.id
      match_type = self.match.match_type
      if match_type == Match::GROUP_MAIN
        @score_boards = ScoreBoard.not_main_board.active
        main_score_board = ScoreBoard.main_score_board
        @score_boards.each do |score_board|
          score_board.points = 0
          score_board.save
          matches = select_group_matches(score_board)
          binding.pry
          update_each_group_match(matches, score_board)
        end      
      elsif match_type == Match::R16_MAIN
        if has_score_for_match_type(Match::R16_MAIN)

        end
        # check if teams are the same and save those points
        # but only if it's the first score that's being saved
        # to not recalculate all the time (4 per team)
      elsif match_type == Match::QUARTER_MAIN
        # check if teams are the same and save those points
        # but only if it's the first score that's being saved
        # to not recalculate all the time (5 per team)
      elsif match_type == Match::SEMI_MAIN
        # check if the teams are the same for the first time
        # add 6 per team
      elsif match_type == Match::THIRD_MAIN
        # check winner add 7
      elsif match_type == Match::FINAL_MAIN
        # check if winner (9) and sub champion (8)
      end
    end
  end

 def update_each_group_match(matches, score_board)
    matches.each do |match|
      match_number = match.match_number
      official_match = Match.where(score_board_id: main_score_board.id, match_number: match_number).first
      official_score = official_match.score
      next if official_score.nil?
      score_board.set_points_for_group_phase(official_score, match_number)
    end
 end

  def select_group_matches(score_board)
    group = Match.where(match_type: Match::GROUP_USERS, score_board_id: score_board.id)
    return group
  end

  def select_r16_matches(matches)
    r16 = matches.select {|match| match.match_type == Match::R16 && !match.score.nil?}
    return r16
  end

  def select_quarters_matches(matches)
    q = matches.select {|match| match.match_type == Match::QUARTER && !match.score.nil?}
    return q
  end

  def select_semi_matches(matches)
    semi = matches.select {|match| match.match_type == Match::SEMI && !match.score.nil?}
    return semi
  end

  def select_third_matches(matches)
    third = matches.select {|match| match.match_type == Match::THIRD && !match.score.nil?}
    return third
  end

end

