# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



country_teams = [
	{ name: "Algeria", flag: "http://img.fifa.com/imgml/flags/reflected/m/alg.png",
		country_ab: 'ALG'},
	{ name: "Argentina", flag: "http://img.fifa.com/imgml/flags/reflected/m/arg.png",
		country_ab: 'ARG'},
	{name: "Australia", flag: "http://img.fifa.com/imgml/flags/reflected/m/aus.png",
		country_ab: 'AUS'},
	{name: "Belgium", flag: "http://img.fifa.com/imgml/flags/reflected/m/bel.png",
		country_ab: 'BEL'},
	{name: "Bosnia and Herzegovina", flag: "http://img.fifa.com/imgml/flags/reflected/m/bih.png",
		country_ab: 'BIH'},
	{name: "Brazil", flag: "http://img.fifa.com/imgml/flags/reflected/m/bra.png",
		country_ab: 'BRA'},
	{name: "Cameroon", flag: "http://img.fifa.com/imgml/flags/reflected/m/cmr.png",
		country_ab: 'CMR'},
	{name: "Chile", flag: "http://img.fifa.com/imgml/flags/reflected/m/chi.png",
		country_ab: 'CHI'},
	{name: "Colombia", flag: "http://img.fifa.com/imgml/flags/reflected/m/col.png",
		country_ab: 'COL'},
	{name: "Costa Rica", flag: "http://img.fifa.com/imgml/flags/reflected/m/crc.png",
		country_ab: 'CRC'},
	{name: "Côte d\'Ivoire", flag: "http://img.fifa.com/imgml/flags/reflected/m/civ.png",
		country_ab: 'CIV'},
	{name: "Croatia", flag: "http://img.fifa.com/imgml/flags/reflected/m/cro.png",
		country_ab: 'CRO'},
	{name: "Ecuador", flag: "http://img.fifa.com/imgml/flags/reflected/m/ecu.png",
		country_ab: 'ECU'},
	{name: "England", flag: "http://img.fifa.com/imgml/flags/reflected/m/eng.png",
		country_ab: 'ENG'},
	{name: "France", flag: "http://img.fifa.com/imgml/flags/reflected/m/fra.png",
		country_ab: 'FRA'},
	{name: "Germany", flag: "http://img.fifa.com/imgml/flags/reflected/m/ger.png",
		country_ab: 'GER'},
	{name: "Ghana", flag: "http://img.fifa.com/imgml/flags/reflected/m/gha.png",
		country_ab: 'GHA'},
	{name: "Greece", flag: "http://img.fifa.com/imgml/flags/reflected/m/gre.png",
		country_ab: 'GRE'},
	{name: "Honduras", flag: "http://img.fifa.com/imgml/flags/reflected/m/hon.png",
		country_ab: 'HON'},
	{name: "Iran", flag: "http://img.fifa.com/imgml/flags/reflected/m/irn.png",
		country_ab: 'IRN'},
	{name: "Italy", flag: "http://img.fifa.com/imgml/flags/reflected/m/ita.png",
		country_ab: 'ITA'},
	{name: "Japan", flag: "http://img.fifa.com/imgml/flags/reflected/m/jap.png",
		country_ab: 'JAP'},
	{name: "Korea Republic", flag: "http://img.fifa.com/imgml/flags/reflected/m/kor.png",
		country_ab: 'KOR'},
	{name: "Mexico", flag: "http://img.fifa.com/imgml/flags/reflected/m/mex.png",
		country_ab: 'MEX'},
	{name: "Netherlands", flag: "http://img.fifa.com/imgml/flags/reflected/m/ned.png",
		country_ab: 'NED'},
	{name: "Nigeria", flag: "http://img.fifa.com/imgml/flags/reflected/m/nig.png",
		country_ab: 'NIG'},
	{name: "Portugal", flag: "http://img.fifa.com/imgml/flags/reflected/m/por.png",
		country_ab: 'POR'},
	{name: "Russia", flag: "http://img.fifa.com/imgml/flags/reflected/m/rus.png",
		country_ab: 'RUS'},
	{name: "Spain", flag: "http://img.fifa.com/imgml/flags/reflected/m/esp.png",
		country_ab: 'ESP'},
	{name: "Switzerland", flag: "http://img.fifa.com/imgml/flags/reflected/m/sui.png",
		country_ab: 'SUI'},
	{name: "Uruguay", flag: "http://img.fifa.com/imgml/flags/reflected/m/uru.png",
		country_ab: 'URU'},
	{name: "USA", flag: "http://img.fifa.com/imgml/flags/reflected/m/usa.png",
		country_ab: 'USA'},
]



country_teams.each do |c|
  @t1 = Team.new
  @t1.country = c[:name]
  @t1.country_ab = c[:country_ab]
  @t1.flag = c[:flag]
  @t1.name = c[:name]
  @t1.save
end


# For each Match, add its stadium

## Stadium ##

# Sao Paolo http://www.fifa.com/worldcup/destination/stadiums/stadium=5025136/index.html

# User Admin #

admin = User.new(username: "Admin", email: "admin@tupote.com", password: "tupote.admin", password_confirmation: "tupote.admin", is_admin: true)
admin.save

## Tournament ##

t = Tournament.new(name: "2014 FIFA World Cup Brazil", number: "0", start_date: "2014-06-12", end_date: "2014-07-13", country: "Brazil", tournament_type: 0, is_active: true)
t.save

s = ScoreBoard.new(name: "Resultados Oficiales", is_active: true, user_id: nil, tournament_id: t.id)
s.save
## Group ##

g = Group.new( name: "A", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g.save

## Match ##

m = Match.new(team_1_id: 6, team_2_id: 12, city: "Sao Paulo", stadium_id: nil, match_type: 0, date: "2014-06-12 00:00:00", score_board_id: s.id, match_number: 1)
m.save

m1 = Match.new(team_1_id: 24, team_2_id: 7, city: "Natal", stadium_id: nil, match_type: 0, date: "2014-06-13 11:30:00", score_board_id: s.id, match_number: 2 )
m1.save

g.teams << Team.find_by_name("Brazil")
g.teams << Team.find_by_name("Croatia")
g.teams << Team.find_by_name("Cameroon")
g.teams << Team.find_by_name("Mexico")

g.matches << m
g.matches << m1

g2 = Group.new( name: "B", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g2.save
g2.teams << Team.find_by_name("Spain")
g2.teams << Team.find_by_name("Chile")
g2.teams << Team.find_by_name("Australia")
g2.teams << Team.find_by_name("Netherlands")
g2.save

m2 = Match.new(team_1_id: Team.find_by_name("Spain").id, team_2_id: Team.find_by_name("Netherlands").id, city: "Salvador", stadium_id: nil, match_type: 0, date: "2014-06-13 14:30:00", score_board_id: s.id, match_number: 3 )
m2.save

m3 = Match.new(team_1_id: Team.find_by_name("Chile").id, team_2_id: Team.find_by_name("Australia").id, city: "Cuiaba", stadium_id: nil, match_type: 0, date: "2014-06-13 17:30:00", score_board_id: s.id, match_number: 4 )
m3.save

g2.matches << m2

g2.matches << m3 

g3 =  Group.new( name: "C", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g3.save
g3.teams << Team.find_by_name("Colombia")
g3.teams << Team.find_by_name("Côte d\'Ivoire")
g3.teams << Team.find_by_name("Greece")
g3.teams << Team.find_by_name("Japan")
g3.save

m4 = Match.new(team_1_id: Team.find_by_name("Colombia").id, team_2_id: Team.find_by_name("Greece").id, city: "Belo Horizonte", stadium_id: nil, match_type: 0, date: "2014-06-14 11:30:00", score_board_id: s.id, match_number: 5 )
m4.save

g3.matches << m4

g4 = Group.new( name: "D", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g4.save
g4.teams << Team.find_by_name("Costa Rica")
g4.teams << Team.find_by_name("England")
g4.teams << Team.find_by_name("Italy")
g4.teams << Team.find_by_name("Uruguay")
g4.save



m5 = Match.new(team_1_id: Team.find_by_name("Uruguay").id, team_2_id: Team.find_by_name("Costa Rica").id, city: "Fortaleza", stadium_id: nil, match_type: 0, date: "2014-06-14 14:30:00", score_board_id: s.id, match_number: 7 )
m5.save
g4.matches << m5

g5 = Group.new( name: "E", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g5.save
g5.teams << Team.find_by_name("Ecuador")
g5.teams << Team.find_by_name("France")
g5.teams << Team.find_by_name("Honduras")
g5.teams << Team.find_by_name("Switzerland")
g5.save

m6 = Match.new(team_1_id: Team.find_by_name("Switzerland").id, team_2_id: Team.find_by_name("Ecuador").id, city: "Brasilia", stadium_id: nil, match_type: 0, date: "2014-06-15 11:30:00", score_board_id: s.id, match_number: 9 )
m6.save

g5.matches << m6


g6 = Group.new( name: "F", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g6.save
g6.teams << Team.find_by_name("Argentina")
g6.teams << Team.find_by_name("Bosnia and Herzegovina")
g6.teams << Team.find_by_name("Iran")
g6.teams << Team.find_by_name("Nigeria")
g6.save

m7 = Match.new(team_1_id: Team.find_by_name("Argentina").id, team_2_id: Team.find_by_name("Bosnia and Herzegovina").id, city: "Rio de Janeiro", stadium_id: nil, match_type: 0, date: "2014-06-15 17:30:00", score_board_id: s.id, match_number: 11 )
m7.save

g6.matches << m7

g7 = Group.new( name: "G", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g7.save
g7.teams << Team.find_by_name("Germany")
g7.teams << Team.find_by_name("Ghana")
g7.teams << Team.find_by_name("Portugal")
g7.teams << Team.find_by_name("USA")
g7.save

m8 = Match.new(team_1_id: Team.find_by_name("Germany").id, team_2_id: Team.find_by_name("Portugal").id, city: "Salvador", stadium_id: nil, match_type: 0, date: "2014-06-16 11:30:00", score_board_id: s.id, match_number: 13 )
m8.save

g7.matches << m8

g8 = Group.new( name: "H", first_place_team_id: 0, second_place_team_id: 0, tournament_id: t.id)
g8.save
g8.teams << Team.find_by_name("Algeria")
g8.teams << Team.find_by_name("Belgium")
g8.teams << Team.find_by_name("Korea Republic")
g8.teams << Team.find_by_name("Russia")
g8.save

m9 = Match.new(team_1_id: Team.find_by_name("Belgium").id, team_2_id: Team.find_by_name("Algeria").id, city: "Belo Horizonte", stadium_id: nil, match_type: 0, date: "2014-06-17 11:30:00", score_board_id: s.id, match_number: 15 )
m9.save

g8.matches << m9

s.create_team_stats