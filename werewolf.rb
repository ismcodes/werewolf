require 'sinatra'
require 'sinatra/activerecord'
require 'securerandom'

class Player < ActiveRecord::Base
belongs_to :session
end
class Session < ActiveRecord::Base
has_many :players
has_one :host, class_name: 'Player'
end

def send_msg(_to, content)
$client.account.messages.create(
    from:"+14242197953",
    to: _to,
    body: content)
end


post '/' do
num = params[:From]
body = params[:Body].downcase
player = Player.where(phone_number:num).first
player ||= Player.create(phone_number:num)
session = player.session


if body.include? "join"

return send_msg(num, "no game id supplied") unless /join (\d|[a-z]){5}/ =~ body
game_id = body.split(" ")[1]
s=Session.where(uuid:game_id).first
if session
session.players << player
else
return send_msg(num, "Could not join game with id of #{game_id}")
end

if session
if session.host != player
send_msg(num, "Successfully joined game with #{player.session.players.size-1} other players.")
else
send_msg(num, "Could not join game with id of #{game_id}")
end
else
send_msg(num, "Could not join game with id of #{game_id}")
end

elsif body.include? "status"

if session
send_msg(num,"#{session.players.size} players")
else
send_msg(num,"game not found")
end

elsif body.include? "host"

s = Session.create(uuid:SecureRandom.uuid[0..4])
s.host = player

#send text with uuid
send_msg(num, "Created new game with id of #{s.uuid}")

elsif body.include? "start"

return send_msg(num,"You are not the host") unless session.host = player
all_players = session.players
all_players<<player #host can play too?
return send_msg(num,"Must have at least 3 players. You have #{all_players.size}.") if all_players.size<3
special = [-1,-1]
2.times do |i|
r = rand(all_players.count)

while special.include?(r)
r = rand(all_players.count)
end

special[i] = r

end

all_players.each_with_index do |p,i|
character = ""

if special[0]==i || special[1]==i
character = "Merlin the wizard (*.*)"
elsif special[2]==i
character = "Werewolf :> awoOooOOOO!"
else
character = "You are a #{Bazaar.adj} villager named #{Faker::Name.name}"
end

send_msg(p.phone_number,character)

end

elsif body.include? "end"
if session.host==player
session.destroy
return send_msg(num,"Successfully ended game")
else
return send_msg(num,"You're not the host of that game")
end


#end cases
end


#end routes
end
