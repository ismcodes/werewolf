require 'sinatra'
require 'sinatra/activerecord'

class Player < ActiveRecord::Base
belongs_to :session
end
class Session < ActiveRecord::Base
has_many :players
has_one :host, class_name: :player

def find_by_host_number(num)
self.all.map{|x|x if x.host.number==num}.first
end

end

get '/' do
num = params[:From]
body = params[:Body].downcase

if body.includes? "join"

player = Player.find(num)
player ||= Player.create(phone_number:num)
game_id = body.split(" ")[1]

player.session = Session.where(uuid:game_id).first

elsif body.includes? "host"

s = Session.create(uuid:"asdf")
player = Player.find(num)
player ||= Player.create(phone_number:num)
s.host = player

elsif body.includes? "start"

all_players = Session.find_by_host_phone(num).first.players
special = [-1,-1,-1]
3.times do |i|
r = rand(all_players.count)

while special.includes?(r)
r = rand(all_players.count)
end

special[i] = r

end

all_players.each do |p|

end

elsif body.includes? "end"

game_id = body.split(" ")[1]

if Session.where(uuid:game_id).first.host.phone_number == num
Session.where(uuid:game_id).destroy
end

end

end
