class Match < ActiveRecord::Base
    has_many :users, :through => :user_matches
    
    def assign_values(data = {})
        self.date = data[:date] if data[:date]
        self.mode = data[:mode] if data[:mode]
        self.outcome = data[:outcome] if data[:outcome]
        self.game_id = data[:game_id] if data[:game_id]
        self.team_id = data[:team_id] if data[:team_id]
        self.champion = data[:champion] if data[:champion]
        self.kills = data[:kills] if data[:kills]
        self.deaths = data[:deaths] if data[:deaths]
        self.assists = data[:assists] if data[:assists]
        self.cs = data[:cs] if data[:cs]
        self.kda = data[:kda] if data[:kda]
        self.kill_participation = data[:kill_participation] if data[:kill_participation]
        self.ge = data[:ge] if data[:ge]
        self.dg = data[:dg] if data[:dg]
        self.dpg = data[:dpg] if data[:dpg]
        self.dpot = data[:dpot] if data[:dpot]
        self.gpot = data[:gpot] if data[:gpot]
    end
end