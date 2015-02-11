# werewolf
Sets up a game of Werewolf/Mafia by text. Only gathers group and hands out random roles by text, does not actually play the full game (yet?)

###instructions:
* Get ready to send a message to 42421-WRWLF, aka <a href="sms:14242197953">424-219-7953</a>
* `host` to get a new game going. This will give you back the id which others need to join.
* `join 1a2b3` to join a game, replacing the second part with whatever the game id is.
* `status` to see how many players are in current game
* If you are the host, text `go` to distribute a role to each player. Must have < 2 players in session to start.
*   keep messaging `go` to redistribute
* `finished` to end the game. `host` does the same thing, they both kick all the players and host.
* `hi` to remind you of the commands
