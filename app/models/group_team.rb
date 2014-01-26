class GroupTeam < ActiveRecord::Base
	belongs_to :group
	belongs_to :team
	validates_uniqueness_of :group, :scope => :team
end
