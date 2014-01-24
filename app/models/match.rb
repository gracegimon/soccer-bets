class Match < ActiveRecord::Base
  has_many :teams

  validates_presence_of :team_1_id, :team_2_id, :type, :date, :city

  def initialize(attributes = {})
    super # must allow the active record to initialize!
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

end
