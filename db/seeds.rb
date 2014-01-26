# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



country_teams = [
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
	{name: "Spain", flag: "http://img.fifa.com/imgml/flags/reflected/m/spa.png",
		country_ab: 'SPA'},
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
end