class Match < ActiveRecord::Base
  has_many :teams
  has_one :score
  belongs_to :score_board
  belongs_to :group

  validates_presence_of :team_1_id, :team_2_id, :match_type, :date, :city
 
  GROUP_MAIN = 0
  GROUP_USERS = 1 
  R16_MAIN = 2
  R16 = 3
  QUARTER_MAIN = 4
  QUARTER = 5
  SEMI_MAIN = 6
  SEMI = 7
  THIRD_MAIN = 8
  THIRD = 9
  FINAL_MAIN = 10
  FINAL = 11



  #MATCH_TYPE = 0 --> GROUP MAIN
  #MATCH_TYPE = 1 --> GROUP USERS
  #MATCH_TYPE = 2 --> Round of 16,
  # AND CONTINUES FOR: Quarter-finals, Semi-finals, Third-place play-off, Final
  def initialize(attributes = {})
    super # must allow the active record to initialize!
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def team_1
    Team.find(team_1_id)
  end

  def team_2
    Team.find(team_2_id)
  end

  def time
    self.date.strftime("%I:%M%p")
  end

  def day
    self.date.strftime("%d-%b")
  end

  def stadium_name
    Stadium.find(stadium_id).name unless self.stadium_id.nil?
  end

  def self.find_by_team_group(t)
    Match.where(team_1_id: t.id) | Match.where(team_2_id: t.id)
  end

  def self.find_by_team_group_score_board(t,sb)
    Match.where(team_1_id: t.id, score_board_id: sb.id) | Match.where(team_2_id: t.id, score_board_id: sb.id)
  end

  def update_teams_stats
    team_stats_1 = self.team_1.read_team_stats(self.score_board)
    team_stats_2 = self.team_2.read_team_stats(self.score_board)
  end


end
