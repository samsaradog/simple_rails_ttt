INITIAL_MEMENTO = '         '

O_TOKEN = "O"
X_TOKEN = "X"
Z_TOKEN = "Z"

PLAYER_X_FIRST_MESSAGE = "Computer moves first\n"
PLAYER_O_FIRST_MESSAGE = "Human moves first\n"

DRAW_GAME_MESSAGE = "Draw Game"
X_WINS_MESSAGE    = "X is the Winner!"
O_WINS_MESSAGE    = "O is the Winner!"
OPEN_GAME_MESSAGE = "Please make your move"

STATE_TO_NOTIFICATION = { :draw  => DRAW_GAME_MESSAGE,
                          :x_win => X_WINS_MESSAGE,
                          :o_win => O_WINS_MESSAGE,
                          :open  => OPEN_GAME_MESSAGE }
