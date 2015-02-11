# werewolf
Sets up a game of Werewolf/Mafia by text. Gathers groups and hands out random roles by text, it doesn't have voting or full play (yet?)

##instructions
#####Get ready to send a message to 42421-WRWLF, aka [424-219-7953](sms:4242197953)
####Message choices:
* `host` to get a new game going. This will return the id which others need to join.
* `join <game_id>` to join a game, replace the second part with whatever the game id is.
* `status` to see how many players are in current game
* If you are the host, text `go` to distribute a role to each player. Must have > 2 players in session.
*   keep messaging `go` to redistribute roles
* `finished` to end the game. `host` has the same effect, they both kick all the players and host.
* `hi` to remind you of the commands
