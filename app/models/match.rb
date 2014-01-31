class Match < ActiveRecord::Base
  has_many :teams
  has_one :score
  belongs_to :group

  validates_presence_of :team_1_id, :team_2_id, :match_type, :date, :city

  #MATCH_TYPE = 0 --> GROUP 
  #MATCH_TYPE = 1 --> Round of 16,
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


end
