groupA = "FIFA_players/Group_A"
file = File.open("#{groupA}/Brazil.txt", "r")

contents = file.read

puts contents