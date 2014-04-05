class Tournament < ActiveRecord::Base
  has_many :groups
  has_many :score_boards
  has_many :matches

  scope :active, -> {where is_active: 1}

  # Returns the current value of the jackpot
  def jackpot
  	score_boards_type_0 = ScoreBoard.active.where(board_type: ScoreBoard::GENERAL).count
  	score_boards_type_1 = ScoreBoard.active.where(board_type: ScoreBoard::HIGH_ROLLER).count
  	return (score_boards_type_0 * ScoreBoard::GENERAL_VALUE) + 
  			(score_boards_type_1 * ScoreBoard::HIGH_ROLLER_VALUE)
  end

  # First place current prize (50%)
  def first_place
  	first_place = jackpot
  	return first_place * 0.5
  end

  def second_place
  	second_place = jackpot
  	return second_place * 0.2
  end

  def third_place
  	third_place = jackpot
  	return third_place * 0.1
  end

  # Returns the 80% of the jackpot
  def final_jackpot
  	final_jackpot = jackpot
  	return final_jackpot * 0.8
  end

end
