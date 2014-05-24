class ExtraPhase < ActiveRecord::Base
  belongs_to :score_board

  after_create :set_points_for_score_boards

  before_update :erase_points_for_score_boards

  after_update :set_points_for_score_boards


  def penal_team
  	Team.find(self.penal_team_id)
  end

  def red_card_team
  	Team.find(self.red_card_team_id)
  end

  def best_player
  	Player.find(self.best_player_id)
  end


  def set_points_for_score_boards
    if self.score_board.id == ScoreBoard.main_score_board.id
      @score_boards =  ScoreBoard.not_main_board.active
      @score_boards.each do |score_board|
        extra = score_board.extra_phase
        next if extra.nil?
        if extra.best_player_id == self.best_player_id
          score_board.points += 7
        end
        if extra.red_card_team_id == self.red_card_team_id
          score_board.points += 5
        end
        if extra.penal_team_id == self.penal_team_id
          score_board.points += 3
        end
        score_board.save
      end
    end
  end

  def erase_points_for_score_boards
    if self.score_board.id == ScoreBoard.main_score_board.id
      score_boards =  ScoreBoard.not_main_board.active
      old_main_extra = ExtraPhase.find(self.id)
      score_boards.each do |score_board|
        extra = score_board.extra_phase
        next if extra.nil?
        if extra.best_player_id == old_main_extra.best_player_id
          score_board.points -= 7
        end
        if extra.red_card_team_id == old_main_extra.red_card_team_id
          score_board.points -= 5
        end
        if extra.penal_team_id == old_main_extra.penal_team_id
          score_board.points -= 3
        end
        score_board.save        
      end
    end
  end

  def is_complete
    return false if (self.red_card_team_id.nil? || self.penal_team_id.nil? || self.best_player_id.nil?)
    return true
  end

end
