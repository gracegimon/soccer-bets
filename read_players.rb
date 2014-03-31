ROOT = "FIFA_players"

def read_file_for_group(group, group_file)
  group.teams.each do |t|
    team_name = t.name
    file = File.open("#{ROOT}/#{group_file}/#{team_name}.txt", "r")
    file.readlines.each do |line|
      player_s = line.split(",")
      next if player_s[1] == "Pos."
      # player_s[1] POS
      # player_s[2] Name
      # player_s[3] Date of birth
      player = Player.new(position: player_s[1], 
                name: player_s[2], 
                date_of_birth: player_s[3].to_date, 
                team_id: t.id)
      player.save
    end
  end
end
t = Tournament.last
t.groups.each do | group|
  group_file = "Group_#{group.name}"
  read_file_for_group(group, group_file)
end
