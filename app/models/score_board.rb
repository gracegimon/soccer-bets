class ScoreBoard < ActiveRecord::Base
  has_many :scores
  has_many :matches
  has_one :extra_phase
  belongs_to :user
  belongs_to :tournament
  before_create :valid_name
  after_create :generate_matches, :create_team_stats

  scope :not_main_board, -> {where "user_id IS NOT NULL"}
  scope :active, -> {where is_active: true}
  scope :published, -> {where is_published: true}

  validates_presence_of :name, :tournament_id

  # TYPE 0 --> SCOREBOARD WORTH 50$
  # TYPE 1 --> SCOREBOARD WORTH 200$
  # IS_ACTIVE set to TRUE only when user has paid.

  GENERAL = 0
  HIGH_ROLLER = 1

  # This method should see all of the scoreboards that
  # the user has and check if this name is unique 
  # for him
  def valid_name
    unless user.nil?
      if user.score_boards.find_by_name(name).nil?
        true
      else
        errors[:name] <<  " is already being used"
        false
      end
    end
  end

  # This method generate group matches for each scoreboard
  # taken from the standard matches
  def generate_matches
    #Self points
    self.points = 0
    unless self.user.nil? || self.user.is_admin?
      main_matches = Match.where(match_type: Match::GROUP_MAIN)
      main_matches.each do |match|
        new_match = Match.new(team_1_id: match.team_1_id, team_2_id: match.team_2_id, city: match.city, stadium_id: match.stadium_id, match_type: Match::GROUP_USERS , date: match.date, match_number: match.match_number)
        new_match.score_board_id = self.id
        new_match.save
      end
    end
  end

  def create_team_stats
    groups = self.tournament.groups
    groups.each do |group|
      group.teams.each do |t|
        team_stat = TeamStat.new(team_id: t.id, points: 0, status: 1, played_games: 0, won_games:0, tied_games: 0,
                    goals_favor: 0, goals_aggainst: 0, score_board_id: self.id, lost_games: 0, position: 0)
        team_stat.save
      end
    end
  end

  # this returns leaders by its points

  def all_groups_leaders
    groups = self.tournament.groups

    leaders = []
    groups.each do |group|
      leaders << group.group_leaders_for_score_board(self)
    end
    return leaders
  end

  # Returns leaders by it position
  def all_groups_leaders_by_position
    groups = self.tournament.groups

    leaders = []
    groups.each do |group|
      leaders << group.group_leaders_for_score_board_by_pos(self)
    end
    return leaders
  end


  # Returns matches for Round of 16
  # phase, for normal users and admin
  def calculate_round_of_16
    matches = []

    leaders = all_groups_leaders

    team_1A = leaders.first.first
    team_2A = leaders.first.second
    team_1B = leaders[1][0]
    team_2B = leaders[1][1]
    team_1C = leaders[2][0]
    team_2C = leaders[2][1]
    team_1D = leaders[3][0]
    team_2D = leaders[3][1]
    team_1E = leaders[4][0]
    team_2E = leaders[4][1]

    team_1F = leaders[5][0]
    team_2F = leaders[5][1]

    team_1G = leaders[6][0]
    team_2G = leaders[6][1]

    team_1H = leaders[7][0]
    team_2H = leaders[7][1]
    match_type = Match::R16
    if self.user.nil?
      match_type = Match::R16_MAIN
    end

    # Match 49

    m1 = Match.create(team_1_id: team_1A.id, team_2_id: team_2B.id, city: "Belo Horizonte", stadium_id: nil, match_type: match_type , date: "2014-06-28 11:30:00", match_number: 49, score_board_id: self.id)
    matches << m1

    # Match 50
    m2 = Match.create(team_1_id: team_1C.id, team_2_id: team_2D.id, city: "Rio de Janeiro", stadium_id: nil, match_type: match_type , date: "2014-06-28 15:30:00", match_number: 50, score_board_id: self.id)
    matches << m2

    # Match 51
    m3 = Match.create(team_1_id: team_1B.id, team_2_id: team_2A.id, city: "Fortaleza", stadium_id: nil, match_type: match_type, date: "2014-06-29 11:30:00", match_number: 51, score_board_id: self.id)
  
    matches << m3
    # Match 52
    m4 = Match.create(team_1_id: team_1D.id, team_2_id: team_2C.id, city: "Recife", stadium_id: nil, match_type: match_type, date: "2014-06-29 15:30:00", match_number: 52, score_board_id: self.id)

    matches << m4
    # Match 53
    m5 = Match.create(team_1_id: team_1E.id, team_2_id: team_2F.id, city: "Brasilia", stadium_id: nil, match_type: match_type , date: "2014-06-30 11:30:00", match_number: 53, score_board_id: self.id)

    matches << m5
    # Match 54
    m6 = Match.create(team_1_id: team_1G.id, team_2_id: team_2H.id, city: "Porto Alegre", stadium_id: nil, match_type: match_type , date: "2014-06-30 15:30:00", match_number: 54, score_board_id: self.id)

    matches << m6
    # Match 55
    m7 = Match.create(team_1_id: team_1F.id, team_2_id: team_2E.id, city: "Sao Paulo", stadium_id: nil, match_type: match_type , date: "2014-07-01 11:30:00", match_number: 55, score_board_id: self.id)

    matches << m7
    # Match 56
    m8 = Match.create(team_1_id: team_1H.id, team_2_id: team_2G.id, city: "Salvador", stadium_id: nil, match_type: match_type , date: "2014-07-01 15:30:00", match_number: 56, score_board_id: self.id)

    matches << m8

    return matches
  end

  def update_round_of_16(matches)
    updated_matches = []
    leaders = all_groups_leaders_by_position
    team_1A = leaders.first.first
    team_2A = leaders.first.second
    team_1B = leaders[1][0]
    team_2B = leaders[1][1]
    team_1C = leaders[2][0]
    team_2C = leaders[2][1]
    team_1D = leaders[3][0]
    team_2D = leaders[3][1]
    team_1E = leaders[4][0]
    team_2E = leaders[4][1]

    team_1F = leaders[5][0]
    team_2F = leaders[5][1]

    team_1G = leaders[6][0]
    team_2G = leaders[6][1]

    team_1H = leaders[7][0]
    team_2H = leaders[7][1]

    if matches.size > 8
      return []
    end
    m1 = matches[0]
    m1.update_attributes(team_1_id: team_1A.id, team_2_id: team_2B.id)
    updated_matches << m1

    m2 = matches[1]
    m2.update_attributes(team_1_id: team_1C.id, team_2_id: team_2D.id)
    updated_matches << m2

    m3 = matches[2]
    m3.update_attributes(team_1_id: team_1B.id, team_2_id: team_2A.id)
    updated_matches << m3

    m4 = matches[3]
    m4.update_attributes(team_1_id: team_1D.id, team_2_id: team_2C.id)
    updated_matches << m4

    m5 = matches[4]
    m5.update_attributes(team_1_id: team_1E.id, team_2_id: team_2F.id)
    updated_matches << m5

    m6 = matches[5]
    m6.update_attributes(team_1_id: team_1G.id, team_2_id: team_2H.id)
    updated_matches << m6

    m7 = matches[6]
    m7.update_attributes(team_1_id: team_1F.id, team_2_id: team_2E.id)
    updated_matches << m7

    m8 = matches[7]
    m8.update_attributes(team_1_id: team_1H.id, team_2_id: team_2G.id)
    updated_matches << m8

    return updated_matches

  end

  # def update_round_of_16(matches)
  #   updated_matches = []
  #   leaders = all_groups_leaders
  #   team_1A = leaders.first.first
  #   team_2A = leaders.first.second
  #   team_1B = leaders[1][0]
  #   team_2B = leaders[1][1]
  #   team_1C = leaders[2][0]
  #   team_2C = leaders[2][1]
  #   team_1D = leaders[3][0]
  #   team_2D = leaders[3][1]
  #   team_1E = leaders[4][0]
  #   team_2E = leaders[4][1]

  #   team_1F = leaders[5][0]
  #   team_2F = leaders[5][1]

  #   team_1G = leaders[6][0]
  #   team_2G = leaders[6][1]

  #   team_1H = leaders[7][0]
  #   team_2H = leaders[7][1]

  #   if matches.size > 8
  #     return []
  #   end

  #   m1 = matches[0]
  #   m1.update_attributes(team_1_id: team_1A.id, team_2_id: team_2B.id)
  #   updated_matches << m1

  #   m2 = matches[1]
  #   m2.update_attributes(team_1_id: team_1C.id, team_2_id: team_2D.id)
  #   updated_matches << m2

  #   m3 = matches[2]
  #   m3.update_attributes(team_1_id: team_1B.id, team_2_id: team_2A.id)
  #   updated_matches << m3

  #   m4 = matches[3]
  #   m4.update_attributes(team_1_id: team_1D.id, team_2_id: team_2C.id)
  #   updated_matches << m4

  #   m5 = matches[4]
  #   m5.update_attributes(team_1_id: team_1E.id, team_2_id: team_2F.id)
  #   updated_matches << m5

  #   m6 = matches[5]
  #   m6.update_attributes(team_1_id: team_1G.id, team_2_id: team_2H.id)
  #   updated_matches << m6

  #   m7 = matches[6]
  #   m7.update_attributes(team_1_id: team_1F.id, team_2_id: team_2E.id)
  #   updated_matches << m7

  #   m8 = matches[7]
  #   m8.update_attributes(team_1_id: team_1H.id, team_2_id: team_2G.id)
  #   updated_matches << m8
  #   binding.pry
  #   return updated_matches

  # end


  def calculate_quarters
    matches = []
     match_type = Match::QUARTER
    if self.user.nil?
      match_type = Match::QUARTER_MAIN
    end
    # Match 57
    w49 = Match.find_by_match_number_score_board(49, self).winner
    w50 = Match.find_by_match_number_score_board(50, self).winner
    m1 = Match.create(team_1_id: w49.id, team_2_id: w50.id, city: "Fortaleza", stadium_id: nil, match_type: match_type , date: "2014-07-04 15:30:00", match_number: 57, score_board_id: self.id)
    matches << m1

    # Match 58
    w53 = Match.find_by_match_number_score_board(53, self).winner
    w54 = Match.find_by_match_number_score_board(54, self).winner
    m2 = Match.create(team_1_id: w53.id, team_2_id: w54.id, city: "Rio de Janeiro", stadium_id: nil, match_type: match_type , date: "2014-07-04 11:30:00", match_number: 58, score_board_id: self.id)
    matches << m2

    # Match 59
    w51 = Match.find_by_match_number_score_board(51, self).winner
    w52 = Match.find_by_match_number_score_board(52, self).winner
    m3 = Match.create(team_1_id: w51.id, team_2_id: w52.id, city: "Salvador", stadium_id: nil, match_type: match_type , date: "2014-07-05 15:30:00", match_number: 59, score_board_id: self.id)
    matches << m3    

    # Match 60
    w55 = Match.find_by_match_number_score_board(55, self).winner
    w56 = Match.find_by_match_number_score_board(56, self).winner
    m4 = Match.create(team_1_id: w55.id, team_2_id: w56.id, city: "Brasilia", stadium_id: nil, match_type: match_type , date: "2014-07-05 11:30:00", match_number: 60, score_board_id: self.id)
    matches << m4

    return matches
  end


  def update_quarters(matches)
    updated_matches = []

    # Match 57
    w49 = Match.find_by_match_number_score_board(49, self).winner
    w50 = Match.find_by_match_number_score_board(50, self).winner
    m57 = matches[0]
    m57.update_attributes(team_1_id: w49.id, team_2_id: w50.id)
    updated_matches << m57

    # Match 58
    w53 = Match.find_by_match_number_score_board(53, self).winner
    w54 = Match.find_by_match_number_score_board(54, self).winner
    m58 = matches[1]
    m58.update_attributes(team_1_id: w53.id, team_2_id: w54.id)
    updated_matches << m58

    # Match 59
    w51 = Match.find_by_match_number_score_board(51, self).winner
    w52 = Match.find_by_match_number_score_board(52, self).winner
    m59 = matches[2]
    m59.update_attributes(team_1_id: w51.id, team_2_id: w52.id)
    updated_matches << m59    

    # Match 60
    w55 = Match.find_by_match_number_score_board(55, self).winner
    w56 = Match.find_by_match_number_score_board(56, self).winner
    m60 = matches[3]
    m60.update_attributes(team_1_id: w55.id, team_2_id: w56.id)
    updated_matches << m60

    return updated_matches
  end



  def calculate_semi_finals
    matches = []
     match_type = Match::SEMI
    if self.user.nil?
      match_type = Match::SEMI_MAIN
    end
    # Match 61

    w57 = Match.find_by_match_number_score_board(57, self).winner
    w58 = Match.find_by_match_number_score_board(58, self).winner
    m1 = Match.create(team_1_id: w57.id, team_2_id: w58.id, city: "Belo Horizonte", stadium_id: nil, match_type: match_type , date: "2014-07-08 15:30:00", match_number: 61, score_board_id: self.id)
    matches << m1

    # Match 62
    w59 = Match.find_by_match_number_score_board(59, self).winner
    w60 = Match.find_by_match_number_score_board(60, self).winner
    m2 = Match.create(team_1_id: w59.id, team_2_id: w60.id, city: "Sao Paulo", stadium_id: nil, match_type: match_type , date: "2014-07-09 15:30:00", match_number: 62, score_board_id: self.id)
    matches << m2

    return matches
  end

 def update_semi_finals(matches)
    updated_matches = []

    # Match 61
    w57 = Match.find_by_match_number_score_board(57, self).winner
    w58 = Match.find_by_match_number_score_board(58, self).winner
    m61 = matches[0]
    m61.update_attributes(team_1_id: w57.id, team_2_id: w58.id)
    updated_matches << m61

    # Match 62
    w59 = Match.find_by_match_number_score_board(59, self).winner
    w60 = Match.find_by_match_number_score_board(60, self).winner
    m62 = matches[1]
    m62.update_attributes(team_1_id: w59.id, team_2_id: w60.id)
    updated_matches << m62

    return updated_matches
  end

  def calculate_third_place
    match_type = Match::THIRD
    if self.user.nil?
      match_type = Match::THIRD_MAIN
    end
    l61 = Match.find_by_match_number_score_board(61, self).loser
    l62 = Match.find_by_match_number_score_board(62, self).loser

    m1 = Match.create(team_1_id: l61.id, team_2_id: l62.id, city: "Brasilia", stadium_id: nil, match_type: match_type , date: "2014-07-12 15:30:00", match_number: 63, score_board_id: self.id)
    return m1
  end

  def update_third_place
    l61 = Match.find_by_match_number_score_board(61, self).loser
    l62 = Match.find_by_match_number_score_board(62, self).loser

    m1 = Match.find_by_match_number_score_board(63,self)
    m1.update_attributes(team_1_id: l61.id, team_2_id: l62.id)

    return m1
  end


  def calculate_final
    match_type = Match::FINAL
    if self.user.nil?
      match_type = Match::FINAL_MAIN
    end
    w61 = Match.find_by_match_number_score_board(61, self).winner
    w62 = Match.find_by_match_number_score_board(62, self).winner

    m1 = Match.create(team_1_id: w61.id, team_2_id: w62.id, city: "Rio de Janeiro", stadium_id: nil, match_type: match_type , date: "2014-07-13 14:30:00", match_number: 64, score_board_id: self.id)
    return m1    
  end

  def update_final
    w61 = Match.find_by_match_number_score_board(61, self).winner
    w62 = Match.find_by_match_number_score_board(62, self).winner

    m1 = Match.find_by_match_number_score_board(64,self)
    m1.update_attributes(team_1_id: w61.id, team_2_id: w62.id)

    return m1
  end

  def matches_have_score(matches)
    return false if matches.empty?
    matches.each do |match|
      return false if match.score.nil?
    end
    return true
  end

  def self.main_score_board
    ScoreBoard.where(tournament_id: Tournament.active.last.id, user_id: nil).first
  end

  def is_main?
    return ScoreBoard.main_score_board.id == self.id 
  end


  def set_points_for_group_phase(official_score, match_number)
    match = Match.find_by_match_number_score_board(match_number, self)
    unless match.score.nil?
      if match.exact_results?(official_score)
        self.points += 5
    
      elsif match.diff_goals_results?(official_score)
        self.points += 4
      
      elsif match.exact_winner?(official_score)
        self.points += 3
      end
      self.save
    end
  end


  # Returns the number of teams that are the same for
  # each score board for a phase
  # Receives main match_type
  def number_of_same_teams(match_type)
    matches = Match.where(match_type: match_type + 1, score_board_id: self.id)
    main = ScoreBoard.main_score_board
    matches_official = Match.where(match_type: match_type, score_board_id: main.id)
    teams_of = []
    teams = []
    count = 0

    if matches_official.empty?
      matches_official = main.calculate_proper_matches(match_type)
    end
    matches_official.each do |match_official|
      teams_of << match_official.teams
    end    
    matches.each do | match |
      teams << match.teams
    end
    teams_of.flatten!
    teams.flatten!
    teams_of.each do | team_of|
      if teams.include?(team_of)
        count += 1
      end
    end
    return count
  end

  def has_score_for_match_type(match_type)
    return !Match.where(match_type: match_type).joins(:score).empty?
  end

  # Receives main match type
  # This is only called for Main Score board
  def update_points_for_score_boards(type, tournament)
    scores = Score.where(scoreboard_id: self.id).includes(:match).where("matches.match_type" => type - 2)
    scores.each do |score|
      score.can_change = false
      score.save
    end 
    score_boards = ScoreBoard.not_main_board.active.where(tournament_id: tournament.id)
    score_boards.each do |score_board| 
      score_board.update_points(type)
    end
  end

  def update_points(type)
    count = self.number_of_same_teams(type)
    if type == Match::R16_MAIN
      self.points += count * 4
    elsif type == Match::QUARTER_MAIN
      self.points += count * 5
    elsif type == Match::SEMI_MAIN
      self.points += count * 6
    end
    self.save
  end

def calculate_proper_matches(type)
  official_matches = []
  if type == Match::R16_MAIN
    official_matches = self.calculate_round_of_16
  elsif type == Match::QUARTER_MAIN
    official_matches = self.calculate_quarters
  elsif type == Match::SEMI_MAIN
    official_matches = self.calculate_semi_finals
  end
end

def status
  if self.is_active
    return "Activa"
  elsif self.is_published
    return "Publicada: Esperando para ser activada por Administrador"
  else
    return "No finalizada"
  end
end

def type
  if self.board_type == 0
      return "General"
  else
      return "High Roller"
  end
end

end
