class ExtraPhase < ActiveRecord::Base
  belongs_to :score_board

  def penal_team
  	Team.find(self.penal_team_id)
  end

  def red_card_team
  	Team.find(self.red_card_team_id)
  end
end
