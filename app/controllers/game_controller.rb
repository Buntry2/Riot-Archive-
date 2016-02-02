require_relative "application_controller"
require 'lol'
# Game Controller
class ApplicationController < Sinatra::Base
	
	post '/update' do
		
		# Update MatchDatabase 
		games = LC.game.recent(ID)
		games.reverse.each do |game|
			data = {
				date: game.create_date.asctime[4..9],
				mode: 
					case game.sub_type
					when "RANKED_SOLO_5x5"
						0
					when "NORMAL"
						1
					else
						-1
					end,
				outcome: game.stats[:win],
				game_id: game.game_id,
				team_id: 	
					case game.stats[:team]
					when 200
						2
					when
						1
					else
						-1
					end,
				champion: LC.static.champion.get(game.champion_id).name,
				kills: game.stats[:champions_killed],
				deaths: game.stats[:num_deaths],
				assists: game.stats[:assists] || 0,
				cs: ((game.stats[:minions_killed] || 0) + (game.stats[:neutral_minions_killed] || 0)).to_i,
				kda: 
					if game.stats[:num_deaths] == 0
						game.stats[:champions_killed].to_f + game.stats[:assists].to_f
					else
						(game.stats[:champions_killed].to_f + game.stats[:assists].to_f)/game.stats[:num_deaths].to_f
					end,
				ge: game.stats[:gold_earned].to_f,
				dg: game.stats[:total_damage_dealt_to_champions].to_f,
				dpg: game.stats[:total_damage_dealt_to_champions].to_f/game.stats[:gold_earned].to_f
			}
			m = Match.new(
					date: data[:date],
					mode: data[:mode],
					outcome: data[:outcome],
					game_id: data[:game_id],
					team_id: data[:team_id],
					champion: data[:champion],
					kills: data[:kills],
					deaths: data[:deaths],
					assists: data[:assists],
					cs: data[:cs],
					kda: data[:kda],
					ge: data[:ge],
					dg: data[:dg],
					dpg: data[:dpg]
				)
			#If we have any duplicate matches don't add them
			unless Match.where(:game_id => m.game_id).any?
				m.save
			end
			
			#Adds LP mark on day specific ranked games
			if m.mode == 0 && !Day.exists?(:date => m.date)
				league_id = LC.league.get(ID)["36759700"].first.entries.find_index { |e| e.player_or_team_id == ID.to_s }
				entry = LC.league.get(ID)["36759700"].first.entries[league_id]
				division = LC.league.get(ID)["36759700"].first.tier + " " + entry.division
				lp = entry.league_points

				case LC.league.get(ID)["36759700"].first.tier
				when "BRONZE"
					score_1 = 0
				when "SILVER"
					score_1 = 500
				when "GOLD"
					score_1 = 1000
				when "PLATINUM"
					score_1 = 1500
				when "DIAMOND"
					score_1 = 2000
				when "MASTER"
					score_1 = 2500
				else
					score_1 = 0
				end
				
				case entry.division
				when "V"
					score_2 = 0
				when "IV"
					score_2 = 100
				when "III"
					score_2 = 200
				when "II"
					score_2 = 300
				when "I"
					score_2 = 400
				else
					score_2 = 0
				end
				
				d = Day.new(
					date: m.date,
					lp: lp,
					division: division,
					score: score_1 + score_2 + lp
					)
				d.save
			end
		end
		redirect "/ranked"
	end
	
	get '/game_data.json' do
		json Match.all.as_json
	end
	
	get '/ranked' do
		@games = Match.where(:mode => 0).to_a.reverse
		
		erb :"games/index"
	end
	
	get '/normal' do
		@games = Match.where(:mode => 1).to_a.reverse
	
		erb :"games/index"
	end
	
end