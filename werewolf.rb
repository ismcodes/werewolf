require 'sinatra'
require 'sinatra/activerecord'
require 'securerandom'

class Player < ActiveRecord::Base
belongs_to :session
end
class Session < ActiveRecord::Base
has_many :players
has_one :host, class_name: 'Player'

def self.find_by_host_number(num)
self.all.map{|x|x if x.host.number==num}.first
end

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

if body.include? "join"

player = Player.where(phone_number:num).first
player ||= Player.create(phone_number:num)
game_id = body.split(" ")[1]
s=Session.where(uuid:game_id).first
if s
s.players << player
else
return send_msg(num, "Could not join game with id of #{game_id}")
end

if player.session
if player.session.host != player
send_msg(num, "Successfully joined game with #{player.session.players.size-1} other players.")
else
send_msg(num, "Could not join game with id of #{game_id}")
end
else
send_msg(num, "Could not join game with id of #{game_id}")
end

elsif body.include? "status"
s = Session.where(uuid:body.split(" ")[1]).first
if s
send_msg(num,"#{s.players.size} players")
else
send_msg(num,"game not found")
end

elsif body.include? "host"

s = Session.create(uuid:SecureRandom.uuid[0..5])
player = Player.where(phone_number:num).first
player ||= Player.create(phone_number:num)
s.host = player

#send text with uuid
send_msg(num, "Created new game with id of #{s.uuid}")

elsif body.include? "start"
s = Session.find_by_host_number(num)
return send_msg(num,"You are not the host") unless s
all_players = s.players
return send_msg(num,"Must have at least 3 players. You have #{all_players.size}.") if s.players.size+1 < 3
special = [-1,-1,-1]
3.times do |i|
r = rand(all_players.count)

while special.include?(r)
r = rand(all_players.count)
end

special[i] = r

end

all_players<<player
#should the host also play?

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


if Session.find_by_host_number(num).host.phone_number == num
Session.where(uuid:game_id).destroy
end

end

end
