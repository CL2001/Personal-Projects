import copy
import os

import chess
import chess.engine
import PySimpleGUI as sg
import time
import threading
import firebase_admin
from firebase_admin import db, credentials
import serial

CRED = credentials.Certificate("C:/Users/chris/VSCode/Projet Python/Chess Embedded System/icb-capstone-firebase-adminsdk-1i71d-5a223a0865.json")
firebase_admin.initialize_app(CRED, {"databaseURL": "https://icb-capstone-default-rtdb.firebaseio.com/"})

#STOCKFISH_PATH = "/home/jetson/Desktop/capstone/Stockfish/src/stockfish"
STOCKFISH_PATH = "C:/Users/chris/OneDrive/Documents/stockfish/stockfish-windows-x86-64-modern.exe"
STOCKFISH_TIME = 0.1

#Board_ID
G_BOARD_ID = "Board1"

"""
Game conditions inputs from the webapp
These variables are final and remain unchanged in the code
"""
# Player IDs from the database
G_WHITE_PLAYER_ID = None
G_BLACK_PLAYER_ID = None

# "Trainer Assisted" for move recommendation
# "Easy" for legal move display
# "Normal" for no in game display
G_ASSISTANCE = None

# "Multiplayer" for a two player game
# "Singleplayer" for a one person vs chess AI game
G_GAMEMODE = None

# If game mode is single player, this input determines the color of the player
G_SINGLE_PLAYER_COLOR = None
# If game mode is single player, this input is the strength of the bot (min 1320)
G_SINGLE_PLAYER_AI_STRENGTH = None

# True if the players are playing with a manual clock and false if players are playing with an automatic clock
G_WITH_CLOCK = None

# Sets both players clocks to this time in minutes at the start of the game
G_TIMER = None
# Extra time in seconds that is added to a players clock after each move they make
G_EXTRA_TIME = None


"""
Inputs from the web app during the game
"""
# Is changed to True when the white timer button is pressed
g_white_timer_button = False
# Is changed to True when the black timer button is pressed
g_black_timer_button = False
# Is changed to True if the white player requests a draw on the web app
# This value can be changed back to False if the player changes their mind about drawing the game
g_white_draw = False
# Is changed to True if the black player requests a draw on the web app
# This value can be changed back to False if the player changes their mind about drawing the game
g_black_draw = False
# Is changed to True if the white player resigns on the web app
g_white_resign = False
# Is changed to True if the black player resigns on the web app
g_black_resign = False
# Player picks a piece to promote between a "Queen", "Rook", "Knight" or "Bishop", "None" when waiting for a pick
g_promoted_piece = "None"


"""
Global inputs received from the hardware
"""
# Bit board received from the 64 Reed Switches on the board. Set to 1 when no piece is detected and set to 0 when a piece is detected
g_bit_board = [1 for _ in range(64)]

"""
Global outputs sent to the hardware
"""
# Array of LED lights, first value is if the light is light, the next three values are the RGB values of the light
g_colors = [(False, 255, 255, 255) for _ in range(64)]

#Serial connection to the Arduino
G_SER = None

"""
Global functions of the game flow
"""
# White player ref to the database
g_white_player_ref = None
# Black player ref to the database
g_black_player_ref = None

# Game data template
TEMPLATE_GAME_DATA = {
    "White Elo": 0,
    "Black Elo": 0,
    "Player Color": "",
    "Moves": ['None'],
    "White Time": [None],
    "Black Time": [None],
    "Material Advantages": [0],
    "AI Evaluations": ['0.33'],
    "AI Recommended Moves": ['None', 'e2e4'],
    "Victory Probabilities": [None],
    "Moves Classifications": ['None'],
    "Tactics": ['None'],
    "Trainer Messages": ['None'],
    "Result": 'None',
}
# White game data
g_white_game_data = copy.deepcopy(TEMPLATE_GAME_DATA)
# Black game data
g_black_game_data = copy.deepcopy(TEMPLATE_GAME_DATA)
# White game key
g_white_game_key = None
# Black game key
g_black_game_key = None

# Bit Board status must be equivalent to this in order to start the game
STARTING_BIT_BOARD = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                      1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
# Game status if the game has been started
g_game_started = False
# Game terminated
g_game_terminated = False
# White time remaining in deci-seconds
g_white_timer = 0
# Black time remaining in deci-seconds
g_black_timer = 0
# Chess module board of the current game
g_board = chess.Board().empty()
# Previous Bit Board before an action is made
g_old_bit_board = [1 for _ in range(64)]
# Previous LED array
g_color_pre_lifted_piece = [(False, 255, 255, 255) for _ in range(64)]
# Previous LED for errors
g_color_pre_error = [(False, 255, 255, 255) for _ in range(64)]
# Boolean flag for an illegal move
g_illegal_move = False
# Saves the current piece lifted by the player
g_lifted_piece = None
# Save the current piece captured by the player in a move
g_captured_piece = None
# Set to False when something is being uploaded to the database
g_upload_over = True














# Temporary UI for demo/testing
####################################################################

def chess_UI():
    global g_board, g_colors, g_white_timer_button, g_black_timer_button, g_white_resign, g_black_resign, g_white_draw
    global g_black_draw, g_white_timer, g_black_timer, g_game_started, g_game_terminated, g_promoted_piece

    # Create the 8x8 grid of sg.Text elements to display the board
    board_layout = [
        [
            sg.Text(
                str(g_board.piece_at(row * 8 + col) or '.'),  # Show piece symbol or empty space
                size=(2, 1),
                font=("Courier New", 12),
                text_color="black",
                background_color=f'#{g_colors[row * 8 + col][1]:02x}{g_colors[row * 8 + col][2]:02x}{g_colors[row * 8 + col][3]:02x}',
                key=(row, col)
            ) for col in range(8)
        ] for row in reversed(range(8))  # Start from bottom row up to the top row
    ]

    # Create the 8x8 grid of buttons, using a 1D list for the states
    button_board = [
        [sg.Button(str(g_bit_board[row * 8 + col]), size=(2, 1), key=row * 8 + col) for col in range(8)]
        for row in reversed(range(8))  # Start from bottom row up to the top row
    ]

    # Define the layout
    layout = [
        *board_layout,
        [sg.Text("From physical board: ")],
        *button_board,
        [sg.Button("Place Pieces")],
        [sg.Text("From Web Application")],
        [sg.Text("White Timer:", size=(15, 1)),
         sg.Text("", size=(10, 1), font=("Courier New", 20), key="-WHITE_TIMER-")],
        [sg.Text("Black Timer:", size=(15, 1)),
         sg.Text("", size=(10, 1), font=("Courier New", 20), key="-BLACK_TIMER-")],
        [sg.Button("White Timer"), sg.Button("White resign"), sg.Button("White draw")],
        [sg.Button("Black Timer"), sg.Button("Black resign"), sg.Button("Black draw")],
        [sg.Button("Queen"), sg.Button("Rook"), sg.Button("Bishop"), sg.Button("Knight")],
        [sg.Button("Exit")]  # Additional buttons
    ]

    # Create the window
    window = sg.Window("Embedded UI", layout)

    def format_time(seconds):
        minutes = int(seconds // 60)
        sec = int(seconds % 60)
        deciseconds = int((seconds % 1) * 10)
        return f"{minutes:02}:{sec:02}.{deciseconds}"

    def refresh_timers():
        window["-WHITE_TIMER-"].update(format_time(g_white_timer))
        window["-BLACK_TIMER-"].update(format_time(g_black_timer))

    def refresh_buttons():
        # Update buttons
        for idx in range(64):
            window[idx].update(str(g_bit_board[idx]))

    def refresh_board():
        for row in range(8):
            for col in range(8):
                square_index = row * 8 + col
                piece = g_board.piece_at(square_index)
                color_hex = f'#{g_colors[square_index][1]:02x}{g_colors[square_index][2]:02x}{g_colors[square_index][3]:02x}'
                window[(row, col)].update(
                    str(piece or '.'),  # Update piece text
                )
                if window[(row, col)].Widget.cget("background") != color_hex:
                    window[(row, col)].update(
                        background_color=f'#{g_colors[square_index][1]:02x}{g_colors[square_index][2]:02x}{g_colors[square_index][3]:02x}')

    def periodic_refresh():
        global g_game_terminated
        target_time = time.perf_counter() + 0.1

        while not g_game_terminated:
            current_time = time.perf_counter()
            sleep_duration = max(0, target_time - current_time)
            time.sleep(sleep_duration)
            window.write_event_value("REFRESH_TIMERS", None)
            window.write_event_value("REFRESH_BOARD", None)
            target_time += 0.1


    while not g_game_terminated:
        event, values = window.read(timeout=100)

        # If user closes window or clicks "Exit" (not used in actual system)
        if event == sg.WIN_CLOSED or event == "Exit":
            g_game_terminated = True
            break

        elif event == "REFRESH_TIMERS":
            refresh_timers()

        elif event == "REFRESH_BOARD":
            refresh_board()

        # Code for when a button is pressed on our UI
        elif event == "Black Timer":
            g_black_timer_button = True
            refresh_buttons()
            refresh_board()



        # Place pieces will be is done physically by placing the pieces on the board
        elif event == "Place Pieces":
            refresh_thread = threading.Thread(target=periodic_refresh, daemon=True)
            refresh_thread.start()
            for i in range(16):
                g_bit_board[i] = 0
                g_old_bit_board[i] = 0
            for i in range(48, 64):
                g_bit_board[i] = 0
                g_old_bit_board[i] = 0
            refresh_buttons()


        # Changes the state of the array when a button is pressed. This is done physically by moving pieces on the board
        elif isinstance(event, int) and 0 <= event < 64:
            g_bit_board[event] = 1 - g_bit_board[event]
            refresh_buttons()
            refresh_board()


        elif event == "White Timer":
            g_white_timer_button = True
            refresh_buttons()
            refresh_board()
            continue
        elif event == "White resign":
            g_white_resign = True
            refresh_buttons()
            refresh_board()
            continue
        elif event == "White draw":
            if g_white_draw:
                g_white_draw = False
            else:
                g_white_draw = True
            refresh_buttons()
            refresh_board()
            continue
        elif event == "Black resign":
            g_black_resign = True
            refresh_buttons()
            refresh_board()
            continue
        elif event == "Black draw":
            if g_black_draw:
                g_black_draw = False
            else:
                g_black_draw = True
            refresh_buttons()
            refresh_board()
            continue
        elif event == "Queen":
            g_promoted_piece = "Queen"
            continue
        elif event == "Rook":
            g_promoted_piece = "Rook"
            continue
        elif event == "Bishop":
            g_promoted_piece = "Bishop"
            continue
        elif event == "Knight":
            g_promoted_piece = "Knight"
            continue

    # Close the window
    window.close()


####################################################################
def extract_game_data():
    global G_BOARD_ID, G_WHITE_PLAYER_ID, G_BLACK_PLAYER_ID, G_ASSISTANCE, G_GAMEMODE, G_SINGLE_PLAYER_COLOR, G_SINGLE_PLAYER_AI_STRENGTH
    global G_WITH_CLOCK, G_TIMER, G_EXTRA_TIME, g_colors

    game_setting_ref = db.reference(f"{G_BOARD_ID} Current Game")
    game_setting_data = game_setting_ref.get()
    print("Start the game on the web app")
    #Start animation
    ring1 = [27, 28, 35, 36]
    ring2 = [18, 19, 20, 21, 26, 29, 34, 37, 42, 43, 44, 45]
    ring3 = [9, 10, 11, 12, 13, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 50, 51, 52, 53, 54]
    ring4 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 15, 16, 23, 24, 31, 32, 39, 40, 47, 48, 55, 56, 57, 58, 59, 60, 61, 62, 63]
    g_colors = [(True, 0, 255, 0) if i in ring1 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(True, 0, 255, 0) if i in ring2 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(True, 0, 255, 0) if i in ring3 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(True, 0, 255, 0) if i in ring4 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(True, 0, 255, 0) if i in ring3 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(True, 0, 255, 0) if i in ring2 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(True, 0, 255, 0) if i in ring1 else (False, 0, 0, 0) for i in range(64)]
    time.sleep(1)
    #updateLEDS()
    g_colors = [(False, 255, 255, 255) for _ in range(64)]
    time.sleep(1)
    #updateLEDS()
    print("Press Start_Game on the web app")

    while True:
        if game_setting_data.get("Start_Game"):
            break
        game_setting_data = game_setting_ref.get() 
        time.sleep(0.1)   
    G_WHITE_PLAYER_ID = game_setting_data.get("White_Player_ID")
    G_BLACK_PLAYER_ID = game_setting_data.get("Black_Player_ID")
    G_ASSISTANCE = game_setting_data.get("Assistance")
    G_GAMEMODE = game_setting_data.get("Gamemode")
    G_SINGLE_PLAYER_COLOR = game_setting_data.get("Single_Player_Color")
    G_SINGLE_PLAYER_AI_STRENGTH = game_setting_data.get("Single_Player_AI_Strength")
    if G_SINGLE_PLAYER_AI_STRENGTH < 1320:
        G_SINGLE_PLAYER_AI_STRENGTH = 1320
    G_WITH_CLOCK = game_setting_data.get("Play_with_clock")
    G_TIMER = game_setting_data.get("Timer")
    G_EXTRA_TIME = game_setting_data.get("Extra_Time")
    game_setting_data["Start_Game"] = False
    game_setting_ref.set(game_setting_data)

#Incomplet
def read_database_inputs():
    global g_game_terminated, g_white_timer_button, g_black_timer_button, g_white_resign, g_black_resign, g_white_draw, g_black_draw, g_promoted_piece
    while not g_game_terminated:
        game_setting_ref = db.reference(f"{G_BOARD_ID} Current Game")
        game_setting_data = game_setting_ref.get()
        if game_setting_data.get("White_Timer_Button"):
            g_white_timer_button = True
            game_setting_data["White_Timer_Button"] = False
            game_setting_ref.set(game_setting_data)
        if game_setting_data.get("Black_Timer_Button"):
            g_black_timer_button = True
            game_setting_data["Black_Timer_Button"] = False
            game_setting_ref.set(game_setting_data)
        if game_setting_data.get("White_Resign"):
            g_white_resign = True
            game_setting_data["White_Resign"] = False
            game_setting_ref.set(game_setting_data)
        if game_setting_data.get("Black_Resign"):
            g_black_resign = True
            game_setting_data["Black_Resign"] = False
            game_setting_ref.set(game_setting_data)
        if game_setting_data.get("White_Draw"):
            g_white_draw = True
            game_setting_data["White_Draw"] = False
            game_setting_ref.set(game_setting_data)
        if game_setting_data.get("Black_Draw"):
            g_black_draw = True
            game_setting_data["Black_Draw"] = False
            game_setting_ref.set(game_setting_data)
        promoted_piece = game_setting_data.get("Promoted_Piece")
        if promoted_piece != "None":
            g_promoted_piece = promoted_piece
            game_setting_data["Promoted_Piece"] = "None"
            game_setting_ref.set(game_setting_data)

def initialize_serial():
    while True:
        try:
            ser = serial.Serial(port='COM10', baudrate=9600, timeout=1)
            print("connected to serial")
            time.sleep(2) 
            return ser
        except serial.SerialException as e:
            print(f"Failed to connect: {e}")
            print("Retrying in 2 seconds...")
            time.sleep(2)

"""
def #updateLEDS():
    global G_SER, g_colors
    color_array = [(r, g, b) if is_on else (0, 0, 0) for is_on, r, g, b in g_colors]
    color_string = ";".join([f"{r},{g},{b}" for r, g, b in color_array]) + "\n"
    G_SER.write(color_string.encode())
    time.sleep(0.1)
    print(color_string)
"""
            
def bitboard_leds_loop():
    global G_SER, g_colors, g_bit_board
    Mux_Mapping = [55, 51, 48, 54, 50, 49, 52, 53, 
                34, 32, 33, 35, 37, 36, 39, 38, 
                46, 40, 41, 42, 43, 44, 45, 47, 
                17, 16, 18, 19, 20, 21, 22, 23, 
                31, 25, 27, 29, 28, 26, 30, 24, 
                63, 61, 56, 57, 59, 62, 58, 60, 
                10, 8, 11, 9, 12, 13, 14, 15, 
                6, 7, 1, 0, 3, 2, 5, 4]
    while True:
        time.sleep(0.05)
        # Wait for "STATE:" header
        while True:
            header = G_SER.read(6).decode('utf-8', errors='ignore')
            if header == "STATE:":
                break

        # Read 64 bytes of state data
        state_bytes = G_SER.read(64)
        try:
            bitboard_unmapped = [int(b) for b in state_bytes.decode('utf-8')]
        except Exception as e:
            print("Error decoding bitboard:", e)
            continue

        for i in range(64):
            g_bit_board[Mux_Mapping[i]] = bitboard_unmapped[i]

        led = [(False, 255, 255, 255) for _ in range(64)]
        for i in range(64):
            if g_colors[i] == (False, 255, 255, 255) and g_bit_board[i] == 0:
                led[i] = (True, 0, 127, 0)
            else:
                led[i] = g_colors[i]
        # Send LED colors to the Arduino
        G_SER.write(b"LED:")
        for bool, r, g, b in led:
            if bool:
                G_SER.write(bytes([r, g, b]))
            else:
                G_SER.write(bytes([0, 0, 0]))



# Classification limit values
EXCELLENT_GOOD_LIM = 0.02
GOOD_BAD_LIM = 0.05
BAD_HORRIBLE_LIM = 0.2

# Statistical victory probability (0 = win for black and 1 = win for white)
VICTORY_PROBABILITY = {-1500: 0.1, -700: 0.2, -300: 0.3, -100: 0.4, 0: 0.5, 100: 0.6, 300: 0.7, 700: 0.8,
                       1500: 0.9}
VICTORY_PROBABILITY_CHECKMATE = {-1: 0, -2: 0.01, -32: 0.05, 32: 0.95, 2: 0.99, 1: 1}
def findEvals(board, score):
    if not board.turn:
        if score.is_mate():
            return f"M{-score.mate()}"
        else:
            return -score.score()
    else:
        if score.is_mate():
            return f"M{score.mate()}"
        else:
            return score.score()

def findProbabilityVictory(board, eval):
    if isinstance(eval, str) and eval.startswith('M'):
        numeric_value = int(eval[1:])
        if -32 >= numeric_value:
            return VICTORY_PROBABILITY_CHECKMATE[-32]
        elif -32 < numeric_value <= -2:
            return VICTORY_PROBABILITY_CHECKMATE[-2] + (
                    VICTORY_PROBABILITY_CHECKMATE[-32] - VICTORY_PROBABILITY_CHECKMATE[-2]) / (-32 + 2) * (
                    numeric_value + 2)
        elif numeric_value == -1:
            return VICTORY_PROBABILITY_CHECKMATE[-1]
        elif numeric_value >= 32:
            return VICTORY_PROBABILITY_CHECKMATE[32]
        elif 2 <= numeric_value < 32:
            return VICTORY_PROBABILITY_CHECKMATE[32] + (
                    VICTORY_PROBABILITY_CHECKMATE[32] - VICTORY_PROBABILITY_CHECKMATE[2]) / (32 - 2) * (
                    numeric_value - 32)
        elif numeric_value == 1:
            return VICTORY_PROBABILITY_CHECKMATE[1]
        else:
            if board.is_checkmate() and not board.turn:
                return VICTORY_PROBABILITY_CHECKMATE[1]
            else:
                return VICTORY_PROBABILITY_CHECKMATE[-1]
    else:
        eval_value = eval
        if -1500 > eval_value:
            return VICTORY_PROBABILITY[-1500]
        elif -1500 <= eval_value < -700:
            return VICTORY_PROBABILITY[-1500] + (VICTORY_PROBABILITY[-700] - VICTORY_PROBABILITY[-1500]) / (
                    -700 + 1500) * (eval_value + 1500)
        elif -700 <= eval_value < -300:
            return VICTORY_PROBABILITY[-700] + (VICTORY_PROBABILITY[-300] - VICTORY_PROBABILITY[-700]) / (
                    -300 + 700) * (eval_value + 700)
        elif -300 <= eval_value < -100:
            return VICTORY_PROBABILITY[-300] + (VICTORY_PROBABILITY[-100] - VICTORY_PROBABILITY[-300]) / (
                    -100 + 300) * (eval_value + 300)
        elif -100 <= eval_value < 0:
            return VICTORY_PROBABILITY[-100] + (VICTORY_PROBABILITY[0] - VICTORY_PROBABILITY[-100]) / (
                    0 + 100) * (eval_value + 100)
        elif 0 <= eval_value < 100:
            return VICTORY_PROBABILITY[0] + (VICTORY_PROBABILITY[100] - VICTORY_PROBABILITY[0]) / (
                    100 - 0) * eval_value
        elif 100 <= eval_value < 300:
            return VICTORY_PROBABILITY[100] + (VICTORY_PROBABILITY[300] - VICTORY_PROBABILITY[100]) / (
                    300 - 100) * (eval_value - 100)
        elif 300 <= eval_value < 700:
            return VICTORY_PROBABILITY[300] + (VICTORY_PROBABILITY[700] - VICTORY_PROBABILITY[300]) / (
                    700 - 300) * (eval_value - 300)
        elif 700 <= eval_value <= 1500:
            return VICTORY_PROBABILITY[700] + (VICTORY_PROBABILITY[1500] - VICTORY_PROBABILITY[700]) / (
                    1500 - 700) * (eval_value - 700)
        else:
            return VICTORY_PROBABILITY[1500]

def moveClassification(board, current_victory_prob, last_victory_prob):
    if not board.turn:
        prob_change = -current_victory_prob + last_victory_prob
    else:
        prob_change = current_victory_prob - last_victory_prob

    if prob_change <= EXCELLENT_GOOD_LIM:
        return "Excellent"
    elif prob_change <= GOOD_BAD_LIM:
        return "Good"
    elif prob_change <= BAD_HORRIBLE_LIM:
        return "Bad"
    else:
        return "Horrible"
def upload_current_game():
    global g_upload_over, g_board, g_white_game_data, g_black_game_data, g_white_game_key, g_black_game_key, g_white_timer, g_black_timer, STOCKFISH_PATH, STOCKFISH_TIME

    PIECE_NAMES = {
        chess.PAWN: "Pawn",
        chess.KNIGHT: "Knight",
        chess.BISHOP: "Bishop",
        chess.ROOK: "Rook",
        chess.QUEEN: "Queen",
        chess.KING: "King"
    }

    PIECE_VAL = {
        chess.PAWN: 1,
        chess.KNIGHT: 3,
        chess.BISHOP: 3,
        chess.ROOK: 5,
        chess.QUEEN: 9,
        chess.KING: 0
    }

    # Function that generates a tactic and a trainer message
    def generate_tactics(is_player_white, board, move, current_eval, past_eval, recommended_move, recommended_next_move, move_class):

        # Retourne vrai si il y a un smothered checkmate sur la planche ainsi que la case du roi et la case de l'attaqueur
        def is_smothered_checkmate_fs():
            if not board.is_checkmate():
                return False, None, None

            king_color = chess.WHITE if board.turn else chess.BLACK
            king_square = board.king(king_color)

            surrounding_squares = [
                chess.square(x, y)
                for x in range(max(0, chess.square_file(king_square) - 1), min(7, chess.square_file(king_square) + 1) + 1)
                for y in range(max(0, chess.square_rank(king_square) - 1), min(7, chess.square_rank(king_square) + 1) + 1)
                if chess.square(x, y) != king_square
            ]

            for square in surrounding_squares:
                if not board.is_attacked_by(king_color, square):
                    return False, None, None

            for attacker_square in board.attackers(not king_color, king_square):
                if board.piece_at(attacker_square).piece_type == chess.KNIGHT:
                    return True, chess.square_name(king_square), chess.square_name(attacker_square)

            return False, None, None

        # Retourne vrai si il y a un backrank checkmate ainsi que la case du roi, case de l'attaqueur, la piece attaquante et
        # le nombre de pièce qui bloque le roi dans le dernier rang
        def is_backrank_mate_fs():
            if not board.is_checkmate():
                return False, None, None, None, None

            king_color = chess.WHITE if board.turn else chess.BLACK
            king_square = board.king(king_color)
            rank = chess.square_rank(king_square)

            if (king_color == chess.WHITE and rank != 0) or (king_color == chess.BLACK and rank != 7):
                return False, None, None, None, None

            surrounding_squares = [
                chess.square(file, rank)
                for file in range(max(0, chess.square_file(king_square) - 1), min(8, chess.square_file(king_square) + 2))
                for rank in range(max(0, chess.square_rank(king_square) - 1), min(8, chess.square_rank(king_square) + 2))
                if chess.square(file, rank) != king_square
            ]

            blocked_by_own_pieces = sum(
                1 for square in surrounding_squares if board.piece_at(square) and board.piece_at(square).color == king_color
            )

            if blocked_by_own_pieces < 2:
                return False, None, None, None, None

            for attacker_square in board.attackers(not king_color, king_square):
                attacking_piece = board.piece_at(attacker_square)
                if attacking_piece.piece_type is chess.ROOK:
                    return True, chess.square_name(king_square), chess.square_name(attacker_square), "Rook", blocked_by_own_pieces
                if attacking_piece.piece_type is chess.QUEEN:
                    return True, chess.square_name(king_square), chess.square_name(attacker_square), "Queen", blocked_by_own_pieces

            return False, None, None, None, None

        # Retourne vrai si il y a un checkmate ainsi que la case du roi, la case de l'attaqeur et la type de pièce de l'attaqueur
        def is_checkmate_fs():
            if not board.is_checkmate():
                return False, None, None, None

            king_color = chess.WHITE if board.turn else chess.BLACK
            king_square = board.king(king_color)
            for attacker_square in board.attackers(not king_color, king_square):
                attacking_piece = board.piece_at(attacker_square)
                attacking_piece_name = PIECE_NAMES.get(attacking_piece.piece_type, "Unkown")
                return True, chess.square_name(king_square), chess.square_name(attacker_square), attacking_piece_name
            return False, None, None, None

        # Retourne vrai s'il y a un stalemate ainsi que la case du roi qui ne peut plus bouger
        def is_stalemate_fs():
            if not board.is_stalemate():
                return False, None
            king_color = chess.WHITE if board.turn else chess.BLACK
            king_square = board.king(king_color)
            return True, chess.square_name(king_square)

        # Retourne vrai si il y a un threefolds repitition ainsi que la case et la piece d udernier move de blanc et de noir
        def detect_threefolds_repition_fs():
            if board.can_claim_threefold_repetition() and len(board.move_stack) > 1:
                if board.turn:
                    black_move = board.peek()
                    board.pop()
                    white_move = board.peek()
                    board.push_uci(move)
                else:
                    white_move = board.peek()
                    board.pop()
                    black_move = board.peek()
                    board.push_uci(move)
                white_repitition_square = white_move.to_square
                black_repitition_square = black_move.to_square
                white_piece_name = PIECE_NAMES.get(board.piece_at(white_repitition_square).piece_type, "Unkown")
                black_piece_name = PIECE_NAMES.get(board.piece_at(black_repitition_square).piece_type, "Unkown")

                return True, chess.square_name(white_repitition_square), white_piece_name, chess.square_name(black_repitition_square), black_piece_name
            return False, None, None, None, None

        #Retourne vrai s'il n'y a pas assez de matériels ainsi que les pieces restante de chaque couleur
        def is_insufficient_material_fs():
            if board.is_insufficient_material():
                white_pieces = [PIECE_NAMES.get(piece.piece_type, "Unkown") for piece in board.piece_map().values() if piece.color == chess.WHITE]
                black_pieces = [PIECE_NAMES.get(piece.piece_type, "Unkown") for piece in board.piece_map().values() if piece.color == chess.BLACK]
                if len(white_pieces) == 1:
                    white_pieces_str = white_pieces[0]
                else:
                    white_pieces_str = ", ".join(white_pieces[:-1]) + " and " + white_pieces[-1]
                if len(black_pieces) == 1:
                    black_pieces_str = black_pieces[0]
                else:
                    black_pieces_str = ", ".join(black_pieces[:-1]) + " and " + black_pieces[-1]
                return True, white_pieces_str, black_pieces_str
            return False, None, None

        #Retourne vrai si un sacrifice est détecter ainsi que la pièce étant sacrifié et son carré d'arrivé
        def sacrifice_fs():
            board.pop()
            captured_piece = board.piece_at(chess.Move.from_uci(move).to_square)
            if captured_piece is not None:
                captured_piece_value = PIECE_VAL.get(captured_piece.piece_type, 0)
            else:
                captured_piece_value = 0
            board.push_uci(move)
            moved_piece = board.piece_at(chess.Move.from_uci(move).to_square)
            moved_piece_name = PIECE_NAMES.get(moved_piece.piece_type, "Unkown")
            moved_piece_value = PIECE_VAL.get(moved_piece.piece_type, 0)
            if captured_piece_value >= moved_piece_value or moved_piece_value < 3:
                return False, None, None
            temp_board = board.copy()
            temp_board.remove_piece_at(chess.Move.from_uci(move).to_square)
            is_defended = temp_board.is_attacked_by(not board.turn, chess.Move.from_uci(move).to_square)
            is_attacked = board.is_attacked_by(board.turn, chess.Move.from_uci(move).to_square)
            if not is_defended and is_attacked:
                return True, moved_piece_name, chess.square_name(chess.Move.from_uci(move).to_square)
            return False, None, None

        #Retourne vrai si une promotion résulte en un check
        def promotion_check_fs():
            if len(move) != 5 or not board.is_check():
                return False, None, None, None
            king_color = chess.WHITE if board.turn else chess.BLACK
            king_square = board.king(king_color)
            for attacker_square in board.attackers(not king_color, king_square):
                if attacker_square == chess.Move.from_uci(move).to_square:
                    attacking_piece_name = PIECE_NAMES.get(board.piece_at(attacker_square).piece_type, "Unkown")
                    return True, attacking_piece_name, chess.square_name(attacker_square), chess.square_name(king_square)
            return False, None, None, None

        #Retourne vrai si un echec est un royal fork, ainsi que les cases du chevalier, la rêne et le roi
        def royal_fork_fs():
            if not board.is_check():
                return False, None, None, None
            knight_square = chess.Move.from_uci(move).to_square
            if board.piece_at(knight_square).piece_type != chess.KNIGHT:
                return False, None, None, None
            king_check = queen_attack = False
            king_square = queen_square = None
            for knight_attack in board.attacks(knight_square):
                piece = board.piece_at(knight_attack)
                if piece:
                    if piece.piece_type == chess.KING and piece.color == board.turn:
                        king_check = True
                        king_square = chess.square_name(knight_attack)
                    elif piece.piece_type == chess.QUEEN and piece.color == board.turn:
                        queen_attack = True
                        queen_square = chess.square_name(knight_attack)
            if king_check and queen_attack:
                return True, chess.square_name(knight_square), king_square, queen_square
            return False, None, None, None

        #Retourne vrai si un double echec est en jeu, ainsi que les deux cases et piece et la case du roi
        def double_check_fs():
            if not board.is_check():
                return False, None, None, None, None, None
            king_square = board.king(board.turn)
            attacking_pieces = []
            attacking_squares = []
            for attacker_square in board.attackers(not board.turn, king_square):
                piece = board.piece_at(attacker_square)
                if piece:
                    attacking_pieces.append(PIECE_NAMES.get(piece.piece_type, "Unkown"))
                    attacking_squares.append(chess.square_name(attacker_square))
            if len(attacking_squares) == 2:
                return True, chess.square_name(king_square), attacking_pieces[0], attacking_squares[0], attacking_pieces[1], attacking_squares[1]
            return False, None, None, None, None, None

        #Retourne vrai si un discovered check existe ainsi que la case du roi, la pièce/case d'arrivé bougé et la piece/case piece qui met en echec
        def discovered_check_fs():
            if not board.is_check():
                return False, None, None, None, None, None
            king_square = board.king(board.turn)
            for attacker_square in board.attackers(not board.turn, king_square):
                check_piece = board.piece_at(attacker_square)
                if attacker_square != chess.Move.from_uci(move).to_square:
                    return True, chess.square_name(king_square), PIECE_NAMES.get(board.piece_at(chess.Move.from_uci(move).to_square).piece_type, "Unkown"), chess.square_name(chess.Move.from_uci(move).from_square), PIECE_NAMES.get(check_piece.piece_type, "Unkown"), chess.square_name(attacker_square)
            return False, None, None, None, None, None

        #Retroune vrai si un check est joué, ainsi que la case du roi, la pièce et la case de l'attaqueur
        def check_fs():
            if not board.is_check():
                return False, None, None, None
            king_square = board.king(board.turn)
            for attacker_square in board.attackers(not board.turn, king_square):
                check_piece = board.piece_at(attacker_square)
                return True, chess.square_name(king_square), PIECE_NAMES.get(check_piece.piece_type, "Unkown"), chess.square_name(attacker_square)
            return False, None, None, None

        #Retourne vrai si il y a une promotion d'une reine et le carré de la promotion
        def normal_promotion_fs():
            if len(move) != 5:
                return False, None
            if move[4] == 'q':
                return True, chess.square_name(chess.Move.from_uci(move).to_square)
            return False, None

        #Retourne vrai si il y a une sous promotion, ainsi que le carré et la piece de la sous promotion
        def under_promotion_fs():
            if len(move) != 5:
                return False, None, None
            if move[4] != 'q':
                under_promotion_to_square = chess.Move.from_uci(move).to_square
                return True, chess.square_name(under_promotion_to_square), PIECE_NAMES.get(board.piece_at(under_promotion_to_square).piece_type, 'Unknown')
            return False, None, None

        #Retourne vrai si il y a un queen capture, ainsi que le nom de la piece et le carré de la capture
        def queen_capture_fs():
            board.pop()
            qc_to_square = chess.Move.from_uci(move).to_square
            captured_piece = board.piece_at(qc_to_square)
            if captured_piece is not None and captured_piece.piece_type == chess.QUEEN:
                board.push_uci(move)
                return True, PIECE_NAMES.get(board.piece_at(qc_to_square).piece_type, 'Unkown'), chess.square_name(qc_to_square)
            board.push_uci(move)
            return False, None, None

        # Retourne vrai si une pièce est épinglée au roi ainsi que la pièce épinglée, son carré, et le carré de l'attaqueur
        def king_pin_fs():
            king_color = chess.WHITE if board.turn else chess.BLACK
            king_square = board.king(king_color)
            for square, piece in board.piece_map().items():
                if piece.color != king_color and piece.piece_type in {chess.BISHOP, chess.ROOK, chess.QUEEN}:
                    for attack_square in board.attacks(square):
                        attacked_piece = board.piece_at(attack_square)
                        if attacked_piece and attacked_piece.color == king_color and PIECE_VAL.get(attacked_piece.piece_type, 0) >= PIECE_VAL.get(piece.piece_type, 0):
                            line_squares = chess.SquareSet.ray(square, attack_square)
                            if king_square in line_squares:
                                between_squares = list(line_squares.between(attack_square, king_square))
                                if all(board.piece_at(sq) is None for sq in between_squares):
                                    return True, PIECE_NAMES.get(attacked_piece.piece_type, "Unknown"), chess.square_name(attack_square), PIECE_NAMES.get(board.piece_at(square).piece_type, "Unkown"), chess.square_name(square)
            return False, None, None, None, None


        # Retourne vrai si une pièce est épinglée à la reine ainsi que la pièce épinglée, son carré, et le carré de l'attaqueur
        def queen_pin_fs():
            queen_color = chess.WHITE if board.turn else chess.BLACK
            queen_square = None
            for square, piece in board.piece_map().items():
                if piece.color == queen_color and piece.piece_type == chess.QUEEN:
                    queen_square = square
                    break
            if queen_square is None:
                return False, None, None, None, None
            for square, piece in board.piece_map().items():
                if piece.color != queen_color and piece.piece_type in {chess.BISHOP, chess.ROOK}:
                    for attack_square in board.attacks(square):
                        attacked_piece = board.piece_at(attack_square)
                        if attacked_piece and attacked_piece.color == queen_color and attacked_piece.piece_type != chess.KING and attacked_piece.piece_type != chess.QUEEN and PIECE_VAL.get(attacked_piece.piece_type, 0) >= PIECE_VAL.get(piece.piece_type, 0):
                            line_squares = chess.SquareSet.ray(square, attack_square)
                            if queen_square in line_squares:
                                between_squares = list(line_squares.between(attack_square, queen_square))
                                if all(board.piece_at(sq) is None for sq in between_squares):
                                    return True, PIECE_NAMES.get(attacked_piece.piece_type, "Unknown"), chess.square_name(attack_square), PIECE_NAMES.get(board.piece_at(square).piece_type, "Unkown"), chess.square_name(square)
            return False, None, None, None, None

        #Retourne vrai si la reine se fait skewer, ainsi que la piece se faisant attacker et son carré, ainsi que l'attaqueur et son carré
        def queen_skewer_fs():
            queen_color = chess.WHITE if board.turn else chess.BLACK
            queen_square = None
            for square, piece in board.piece_map().items():
                if piece.color == queen_color and piece.piece_type == chess.QUEEN:
                    queen_square = square
                    break
            if queen_square is None:
                return False, None, None, None, None
            for square, piece in board.piece_map().items():
                if piece.color != queen_color and piece.piece_type in {chess.BISHOP, chess.ROOK, chess.QUEEN}:
                    for attack_square in board.attacks(square):
                        # Check if the first piece along the attack is the queen
                        if attack_square == queen_square:
                            # Continue along the line to find the next piece
                            line_squares = chess.SquareSet.ray(square, queen_square)
                            for skewer_square in line_squares:
                                if skewer_square != queen_square and board.piece_at(skewer_square):
                                    skewered_piece = board.piece_at(skewer_square)
                                    # Ensure it's the same color as the queen and weaker
                                    if skewered_piece.color == queen_color and PIECE_VAL.get(skewered_piece.piece_type, 0) <= PIECE_VAL.get(piece.piece_type, 0):
                                        between_squares = list(line_squares.between(queen_square, skewer_square))
                                        if all(board.piece_at(sq) is None for sq in between_squares):
                                            return True, PIECE_NAMES.get(skewered_piece.piece_type, "Unknown"), chess.square_name(skewer_square), PIECE_NAMES.get(board.piece_at(square).piece_type, "Unknown"), chess.square_name(square)
            return False, None, None, None, None

        # Detecte une fork et retourne la piece qui attaque ainsi que les deux piece qui se font attaacker
        def fork_fs():
            attacker_square = chess.Move.from_uci(move).to_square
            attacker_piece = board.piece_at(attacker_square)
            attacker_piece_name = PIECE_NAMES.get(attacker_piece.piece_type, "Unknown")
            attacker_value = PIECE_VAL.get(attacker_piece.piece_type, 0)
            attacked_squares = list(board.attacks(attacker_square))
            attacked_pieces = []
            for square in attacked_squares:
                piece = board.piece_at(square)
                if piece and piece.color != attacker_piece.color:
                    attacked_pieces.append((PIECE_VAL.get(piece.piece_type, 0), PIECE_NAMES.get(piece.piece_type, "Unknown"), chess.square_name(square)))
            attacked_pieces.sort(reverse=True, key=lambda x: x[0])
            if len(attacked_pieces) < 2:
                return False, None, None, None, None, None, None
            strongest_attacked = attacked_pieces[:2]
            if attacker_piece.piece_type == chess.PAWN:
                if strongest_attacked[0][0] <= attacker_value or strongest_attacked[1][0] <= attacker_value:
                    return False, None, None, None, None, None, None
            else:
                if strongest_attacked[0][0] < attacker_value or strongest_attacked[1][0] < attacker_value:
                    return False, None, None, None, None, None, None
            return True, attacker_piece_name, chess.square_name(attacker_square), strongest_attacked[0][1], strongest_attacked[0][2], strongest_attacked[1][1], strongest_attacked[1][2]


        # Detecte une discovered attack
        def discovered_attack_fs():
            move_obj = chess.Move.from_uci(move)
            to_square = move_obj.to_square
            moved_piece = board.piece_at(to_square)
            discovered_attacker_square = None
            discovered_attacker = None
            attacked_piece = None
            attacked_piece_square = None
            for square, piece in board.piece_map().items():
                if piece.color == moved_piece.color and square != to_square:
                    for attacked_square in board.attacks(square):
                        enemy_piece = board.piece_at(attacked_square)
                        if enemy_piece and enemy_piece.color != piece.color and PIECE_VAL.get(enemy_piece.piece_type, 0) > PIECE_VAL.get(piece.piece_type, 0):
                            board.pop()
                            was_attacking = attacked_square in board.attacks(square)
                            board.push(move_obj)
                            if not was_attacking:
                                discovered_attacker_square = chess.square_name(square)
                                discovered_attacker = PIECE_NAMES.get(piece.piece_type, "Unknown")
                                attacked_piece = PIECE_NAMES.get(enemy_piece.piece_type, "Unknown")
                                attacked_piece_square = chess.square_name(attacked_square)
                                break
            if discovered_attacker_square:
                return True, PIECE_NAMES.get(moved_piece.piece_type, "Unknown"), chess.square_name(to_square), discovered_attacker, discovered_attacker_square, attacked_piece, attacked_piece_square
            return False, None, None, None, None, None, None


        # Detecte un en passant
        def en_passant_fs():
            move_obj = board.pop()
            if board.is_en_passant(move_obj):
                board.push(move_obj)
                to_square = move_obj.to_square
                from_square = move_obj.from_square
                moved_piece = board.piece_at(to_square)
                captured_pawn_square = chess.square(chess.square_file(to_square), chess.square_rank(from_square))
                return True, chess.square_name(from_square), chess.square_name(captured_pawn_square), chess.square_name(to_square)
            board.push(move_obj)
            return False, None, None, None


        # Detecte une capture de pièce
        def capture_fs():
            move = board.pop()
            captured_piece = board.piece_at(move.to_square)
            if captured_piece:
                board.push(move)
                attacking_piece = board.piece_at(move.to_square)
                return True, PIECE_NAMES.get(attacking_piece.piece_type, "Unknown"), PIECE_NAMES.get(captured_piece.piece_type, "Unknown"), chess.square_name(move.to_square)
            board.push(move)
            return False, None, None, None

        #Detecte un passed pawn
        def push_passed_pawn_fs():
            move_obj = chess.Move.from_uci(move)
            to_square = move_obj.to_square
            from_square = move_obj.from_square
            moved_piece = board.piece_at(to_square)
            if moved_piece and moved_piece.piece_type == chess.PAWN:
                to_rank = chess.square_rank(to_square)
                to_file = chess.square_file(to_square)
                if moved_piece.color == chess.WHITE and 5 <= to_rank <= 7:
                    for rank in range(to_rank + 1, 8):
                        if board.piece_at(chess.square(to_file, rank)) and board.piece_at(chess.square(to_file, rank)).color != moved_piece.color:
                            return False, None, None
                    return True, chess.square_name(from_square), chess.square_name(to_square)
                elif moved_piece.color == chess.BLACK and 0 <= to_rank <= 2:
                    for rank in range(to_rank - 1, -1, -1):
                        if board.piece_at(chess.square(to_file, rank)) and board.piece_at(chess.square(to_file, rank)).color != moved_piece.color:
                            return False, None, None
                    return True, chess.square_name(from_square), chess.square_name(to_square)

            return False, None, None

        # Detecte un en castling
        def castling_fs():
            move_obj = board.pop()
            if board.is_castling(move_obj):
                board.push(move_obj)
                if chess.square_file(move_obj.from_square) < chess.square_file(move_obj.to_square):
                    castling = "king-side"
                else:
                    castling = "queen-side"
                return True, castling
            board.push(move_obj)
            return False, None

        # Detecte un king walk
        def king_walk_fs():
            move_obj = chess.Move.from_uci(move)
            to_square = move_obj.to_square
            from_square = move_obj.from_square
            moved_piece = board.piece_at(to_square)
            if not (moved_piece and moved_piece.piece_type == chess.KING):
                return False, None, None
            white_pieces = [piece for square, piece in board.piece_map().items() if piece.color == chess.WHITE]
            black_pieces = [piece for square, piece in board.piece_map().items() if piece.color == chess.BLACK]
            if len(white_pieces) > 5 or len(black_pieces) > 5:
                return False, None, None
            opponent_color = not moved_piece.color
            opponent_squares = [
                square for square, piece in board.piece_map().items() if piece.color == opponent_color
            ]
            if not opponent_squares:
                return False, None, None
            center_of_gravity = (
                sum(chess.square_file(square) for square in opponent_squares) / len(opponent_squares),
                sum(chess.square_rank(square) for square in opponent_squares) / len(opponent_squares),
            )
            king_start = (chess.square_file(from_square), chess.square_rank(from_square))
            king_end = (chess.square_file(to_square), chess.square_rank(to_square))
            def distance(pos1, pos2):
                return ((pos1[0] - pos2[0]) ** 2 + (pos1[1] - pos2[1]) ** 2) ** 0.5
            dist_before = distance(king_start, center_of_gravity)
            dist_after = distance(king_end, center_of_gravity)
            if dist_after < dist_before:
                return True, chess.square_name(from_square), chess.square_name(to_square)
            return False, None, None

        # Detecte un threat
        def threat_fs():
            move_obj = chess.Move.from_uci(move)
            to_square = move_obj.to_square
            moved_piece = board.piece_at(to_square)
            if not moved_piece:
                return False, None, None, None
            for threatened_square in board.attacks(to_square):
                threatened_piece = board.piece_at(threatened_square)
                if (
                        threatened_piece
                        and threatened_piece.color != moved_piece.color
                        and PIECE_VAL[threatened_piece.piece_type] >= PIECE_VAL[moved_piece.piece_type]
                ):
                    threatened_piece_name = PIECE_NAMES.get(threatened_piece.piece_type, "Unknown")
                    threatening_piece_name = PIECE_NAMES.get(moved_piece.piece_type, "Unknown")
                    return True, threatening_piece_name, threatened_piece_name, chess.square_name(threatened_square)

            return False, None, None, None

        # Detecte un avantage d'espace gagné
        def detect_space_control_increase_fs():
            move_obj = board.pop()
            current_color = board.turn
            squares_controlled_before = sum(
                1 for square in chess.SQUARES if board.is_attacked_by(current_color, square)
            )
            board.push(move_obj)
            squares_controlled_after = sum(
                1 for square in chess.SQUARES if board.is_attacked_by(current_color, square)
            )
            if squares_controlled_after > squares_controlled_before:
                return True, squares_controlled_before, squares_controlled_after
            return False, squares_controlled_before, squares_controlled_after

        # Detecte un blunder
        def detect_blunder_fs():
            move_obj = board.pop()
            captured_piece = board.piece_at(move_obj.to_square)
            board.push(move_obj)
            blundered_piece = board.piece_at(move_obj.to_square)
            captured_piece_value = PIECE_VAL.get(captured_piece.piece_type, 0) if captured_piece is not None else 0
            if PIECE_VAL.get(blundered_piece.piece_type, 0) < captured_piece_value or PIECE_VAL.get(blundered_piece.piece_type, 0) <= PIECE_VAL[chess.PAWN]:
                return False, None, None, None, None
            recommended_next_move_obj = chess.Move.from_uci(recommended_next_move)
            if recommended_next_move_obj.to_square != move_obj.to_square:
                return False, None, None, None, None
            blunder_square = chess.square_name(recommended_next_move_obj.to_square)
            blunder_piece = PIECE_NAMES.get(blundered_piece.piece_type, "Unknown")
            attacking_piece = PIECE_NAMES.get(board.piece_at(recommended_next_move_obj.from_square).piece_type, "Unknown")
            return True, blunder_square, blunder_piece, recommended_next_move, attacking_piece

        # Detecte un gain manqué
        def missed_gain_fs():
            move_obj = board.pop()
            recommended_move_obj = chess.Move.from_uci(recommended_move)
            captured_piece = board.piece_at(recommended_move_obj.to_square)
            if not captured_piece or PIECE_VAL.get(captured_piece.piece_type, 0) <= PIECE_VAL[chess.PAWN]:
                board.push(move_obj)
                return False, None, None, None, None
            missed_gain_square = chess.square_name(recommended_move_obj.to_square)
            missed_gain_piece_name = PIECE_NAMES.get(captured_piece.piece_type, "Unknown")
            recommended_capturing_piece_name = PIECE_NAMES.get(board.piece_at(recommended_move_obj.from_square).piece_type, "Unknown")
            board.push(move_obj)
            return True, missed_gain_square, missed_gain_piece_name, recommended_capturing_piece_name, recommended_move

        # Detecte une surextension d'un pion
        def detect_pawn_overextension_fs():
            move_obj = chess.Move.from_uci(move)
            to_square = move_obj.to_square
            from_square = move_obj.from_square
            moved_piece = board.piece_at(to_square)
            if moved_piece.piece_type != chess.PAWN:
                return False, None, None
            to_rank = chess.square_rank(to_square)
            is_white = moved_piece.color == chess.WHITE
            if (is_white and to_rank <= 3) or (not is_white and to_rank >= 4):
                return False, None, None
            return True, chess.square_name(from_square), chess.square_name(to_square)

        # Detecte une mauvaise echange
        def detect_exchange_error_fs():
            move_obj = board.pop()
            to_square = move_obj.to_square
            from_square = move_obj.from_square
            capturing_piece = board.piece_at(from_square)
            captured_piece = board.piece_at(to_square)
            board.push(move_obj)
            if not captured_piece or PIECE_VAL.get(capturing_piece.piece_type, 0) != PIECE_VAL.get(captured_piece.piece_type, 0):
                return False, None, None, None, None
            if not board.is_attacked_by(board.turn, to_square):
                return False, None, None, None, None
            capturing_piece_name = PIECE_NAMES.get(capturing_piece.piece_type, "Unknown")
            captured_piece_name = PIECE_NAMES.get(captured_piece.piece_type, "Unknown")
            return True, chess.square_name(from_square), chess.square_name(to_square), capturing_piece_name, captured_piece_name


        # Detecte une surextension
        def overextension_fs():
            move_obj = chess.Move.from_uci(move)
            to_square = move_obj.to_square
            from_square = move_obj.from_square
            moved_piece = board.piece_at(to_square)
            board.pop()
            if board.piece_at(to_square) or board.piece_at(from_square).piece_type == chess.PAWN:
                board.push(move_obj)
                return False, None, None, None
            board.push(move_obj)
            if board.is_attacked_by(not moved_piece.color, to_square):
                return False, None, None, None
            own_pieces = [
                square for square, piece in board.piece_map().items() if piece.color == moved_piece.color
            ]
            if not own_pieces:
                return False, None, None, None
            own_center_of_gravity = (
                sum(chess.square_file(square) for square in own_pieces) / len(own_pieces),
                sum(chess.square_rank(square) for square in own_pieces) / len(own_pieces),
            )
            opponent_pieces = [
                square for square, piece in board.piece_map().items() if piece.color != moved_piece.color
            ]
            if not opponent_pieces:
                return False, None, None, None
            opponent_center_of_gravity = (
                sum(chess.square_file(square) for square in opponent_pieces) / len(opponent_pieces),
                sum(chess.square_rank(square) for square in opponent_pieces) / len(opponent_pieces),
            )
            start_pos = (chess.square_file(from_square), chess.square_rank(from_square))
            end_pos = (chess.square_file(to_square), chess.square_rank(to_square))
            def distance(pos1, pos2):
                return ((pos1[0] - pos2[0]) ** 2 + (pos1[1] - pos2[1]) ** 2) ** 0.5
            dist_to_own_cog_before = distance(start_pos, own_center_of_gravity)
            dist_to_own_cog_after = distance(end_pos, own_center_of_gravity)
            dist_to_enemy_cog_before = distance(start_pos, opponent_center_of_gravity)
            dist_to_enemy_cog_after = distance(end_pos, opponent_center_of_gravity)
            if dist_to_own_cog_after > dist_to_own_cog_before and dist_to_enemy_cog_after < dist_to_enemy_cog_before:
                return True, chess.square_name(from_square), chess.square_name(to_square), PIECE_NAMES.get(moved_piece.piece_type, "Unknown")
            return False, None, None, None


        # Gère une erreur défensive du roi
        def is_king_defensive_error():
            move_obj = board.pop()
            recommended_move_obj = chess.Move.from_uci(recommended_move)
            if board.is_castling(recommended_move_obj):
                board.push(move_obj)
                castling_side = "king-side" if chess.square_file(recommended_move_obj.from_square) < chess.square_file(recommended_move_obj.to_square) else "queen-side"
                return True, castling_side
            board.push(move_obj)
            return False, None

        def get_recommended_move_details(recommended_move):
            recommended_move_obj = chess.Move.from_uci(recommended_move)
            from_square = recommended_move_obj.from_square
            to_square = recommended_move_obj.to_square
            piece = board.piece_at(from_square)
            if not piece:
                return None, None, None
            piece_name = PIECE_NAMES.get(piece.piece_type, "Unknown")
            return piece_name, chess.square_name(from_square), chess.square_name(to_square)

        #Vérifie si le jeu detecte un smothered mate
        is_smothered, smothered_king_square, smothered_attacker_square = is_smothered_checkmate_fs()
        if is_smothered:
            tactic = "Smothered Checkmate"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"Congrats on achieving a Smothered Checkmate, one of the rarest checkmates in the whole game! "
                                     f"The enemy king is surrounded by its own pieces on {smothered_king_square} and can not escape the "
                                     f"attack of the knight on {smothered_attacker_square}")
            else:
                generated_message = (f"Your King has fallen to a Smothered Checkmate, one of the rarest check mates in the whole game."
                                     f"Your king is surrounded by its own pieces on {smothered_king_square} and can not escape the "
                                     f"attack of the enemy knight on {smothered_attacker_square}")
            return tactic, generated_message

        #Vérifie si le jeu détecte un backrank checkmate
        is_backrank, backrank_king_square, backrank_attacker_square, backrank_attacker, backrank_block_by_own_pieces = is_backrank_mate_fs()
        if is_backrank:
            tactic = "Backrank Checkmate"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"Congrats on achieving a Backrank Checkmate! "
                                     f"Your opponent left their king in a weak position and you were able to take advantage of that. "
                                     f"The enemy king on {backrank_king_square} has its escape blocked by {backrank_block_by_own_pieces} of its own pieces. "
                                     f"He is therefore stuck on the backrank and checkmated by your {backrank_attacker} on {backrank_attacker_square}.")
            else:
                generated_message = (f"Your King has fallen to a Backrank Checkmate.. "
                                     f"You left your king weak position and your opponent was able to take advantage of that. "
                                     f"Your king on {backrank_king_square} has its escape blocked by {backrank_block_by_own_pieces} of its own pieces. "
                                     f"He is therefore stuck on the backrank and checkmated by the attackers {backrank_attacker} on {backrank_attacker_square}.")
            return tactic, generated_message

        #Vérifie si le jeu détecte un checkmate normal
        is_normal_checkmate, mate_king_square, mate_attacker_square, mate_attacker_piece = is_checkmate_fs()
        if is_normal_checkmate:
            tactic = "Checkmate"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"Congrats on achieving a Checkmate! "
                                     f"The enemy king on {mate_king_square} is attacked by your {mate_attacker_piece} on {mate_attacker_square}. "
                                     f"Since the enemy cannot escape this attack, the game is won! ")
            else:
                generated_message = (f"Your King has fallen to a Checkmate.. "
                                     f"Your king on {mate_king_square} is attacked by an enemy {mate_attacker_piece} on {mate_attacker_square}. "
                                     f"Since your king cannot escape this square, the game is lost. ")
            return tactic, generated_message

        #Vérifie si le jeu détecte un stalemate
        is_normal_stalemate, stalemate_king_square = is_stalemate_fs()
        if is_normal_stalemate:
            tactic = "Stalemate"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"The game is over due to a Stalemate. "
                                     f"The enemy King on {stalemate_king_square} is not in a check, but is unable to move. "
                                     f"Since the opponent has no other legal moves to play the game ends in a draw. ")
            else:
                generated_message = (f"The game is over due to a Stalemate. "
                                     f"Your King on {stalemate_king_square} is not in a check, but is unable to move. "
                                     f"Since you have no other legal moves to play the game ends in a draw. ")
            return tactic, generated_message

        #Vérifie si le jeu detecte une répitition de 3 mouvement
        is_repitition, repitition_white_square, repitition_white_piece, repitition_black_square, repitition_black_piece = detect_threefolds_repition_fs()
        if is_repitition:
            tactic = "Threefolds reptition"
            if is_player_white:
                generated_message = (f"The game is over due to a Threefolds reptition! "
                                     f"You returned your {repitition_white_piece} to the {repitition_white_square} square three turns in a row. "
                                     f"At the same time, your opponent returned their {repitition_black_piece} to the {repitition_black_square} square for three turns in a row as well. "
                                     f"This results in an automatic draw")
            else:
                generated_message = (f"The game is over due to a Threefolds reptition! "
                                     f"You returned your {repitition_black_piece} to the {repitition_black_square} square three turns in a row. "
                                     f"At the same time, your opponent returned their {repitition_white_piece} to the {repitition_white_square} square for three turns in a row as well. "
                                     f"This results in an automatic draw")
            return tactic, generated_message

        #Vérifie si le jeu est terminé par la règle de 50 moves
        if board.can_claim_fifty_moves():
            tactic = "50 Move Rule"
            generated_message = (f"The game is over due to the 50 move rule! "
                                 f"No captures have been made and no pawns have been moved for the last 50 moves. "
                                 f"This results in an automatic draw")
            return tactic, generated_message

        #Vérifie si le matériel est insufisent
        is_insufficient_material, insufficient_white_pieces, insufficient_black_pieces = is_insufficient_material_fs()
        if is_insufficient_material:
            tactic = "Insufficient material"
            if is_player_white:
                generated_message = (f"The game is over due to their being insufficient material for a checkmate on both sides of the board. "
                                     f"You only have a {insufficient_white_pieces} on the board, while your opponent only has a{insufficient_black_pieces}. "
                                     f"Since there is not enough material for you or your opponent to checkmate eachother, the result is a draw")
            else:
                generated_message = (f"The game is over due to their being insufficient material for a checkmate on both sides of the board. "
                                     f"You only have a {insufficient_black_pieces} on the board, while your opponent only has a {insufficient_white_pieces}. "
                                     f"Since there is not enough material for you or your opponent to checkmate eachother, the result is a draw")
            return tactic, generated_message

        #Vérifie si un echec et mat forcé est détecté
        if isinstance(eval, str) and eval.startswith('M'):
            eval_forced_value = int(eval[1:])
            tactic = "Forced Checkmate"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                if (is_player_white and eval_forced_value > 0) or (not is_player_white and eval_forced_value < 0):
                    generated_message = (f"You have placed you opponent in a forced checkmate position. "
                                         f"You can force a checkmate on your opponent in {abs(eval_forced_value)} moves. "
                                         f"By playing the right moves you are assured a victory")
                else:
                    generated_message = (f"You are in a forced checkmate position. "
                                         f"Your opponent can force a checkmate on you in {abs(eval_forced_value)} moves. "
                                         f"If they play the correct moves, you are assured to lose this game")
            else:
                if (is_player_white and eval_forced_value > 0) or (not is_player_white and eval_forced_value < 0):
                    generated_message = (f"Your opponent is in a forced checkmate position. "
                                         f"You can force a checkmate on your opponent in {abs(eval_forced_value)} moves. "
                                         f"By playing the right moves you are assured a victory")
                else:
                    generated_message = (f"Your opponent has placed you in a forced checkmate position. "
                                         f"Your opponent can force a checkmate on you in {abs(eval_forced_value)} moves. "
                                         f"If they play the correct moves, you are assured to lose this game")
            return tactic, generated_message

        #Vérifie s'il y a un move forcé
        board.pop()
        if len(list(board.legal_moves)) == 1:
            board.push_uci(move)
            tactic = "Forced move"
            from_square_forced_move = chess.square_name(chess.Move.from_uci(move).from_square)
            to_square_forced_move = chess.square_name(chess.Move.from_uci(move).to_square)
            piece_name_forced_move = PIECE_NAMES.get(board.piece_at(chess.Move.from_uci(move).to_square).piece_type, "Unkown")
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"You just played a forced move. "
                                     f"In this position, moving your {piece_name_forced_move} from {from_square_forced_move} to {to_square_forced_move} was the only move available")
            else:
                generated_message = (f"Your opponent played a forced move. "
                                     f"In this position, moving their {piece_name_forced_move} from {from_square_forced_move} to {to_square_forced_move} was the only move available")
            return tactic, generated_message
        board.push_uci(move)

        #Verifie pour un move théorie

        #Gestion des tactics excellente
        if move_class == "Excellent":
            #Détecte un sacrifice
            is_sacrifice, sacrificed_piece, sacrifice_square_name = sacrifice_fs()
            #Appel un sacrifice gagnant
            if is_sacrifice and ((eval > 0 and not board.turn) or (eval < 0 and board.turn)):
                tactic = "Sacrifice"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Congrats on executing a brilliant sacrifice! "
                                         f"You boldly sacrificed your {sacrificed_piece} on {sacrifice_square_name}. "
                                         f"While this involves a temporary loss of material, it paves the way for a strong initiative. "
                                         f"With precise play in the following moves, you'll capitalize on the opportunities you've created and win the game. ")
                else:
                    generated_message = (f"Your opponent executed a brilliant sacrifice! "
                                         f"They placed their {sacrificed_piece} on {sacrifice_square_name}, leaving it undefended. "
                                         f"While the capture of this involves a temporary gain in material, it paves the way for a strong initiative created by your opponent. "
                                         f"With precise play they'll capitalize on the opportunities they've created to win the game.")
                return tactic, generated_message

            #Losing sacrifice
            if is_sacrifice and ((eval < 0 and not board.turn) or (eval > 0 and board.turn)):
                tactic = "Losing Sacrifice"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"You played a losing sacrifice! "
                                         f"You sacrificed your {sacrificed_piece} on {sacrifice_square_name}. "
                                         f"While this involves a loss of material, it allows the game to be extended. "
                                         f"Without this sacifice, it could have lead to a forced checkmate")
                else:
                    generated_message = (f"Your opponent played a losing sacrifice! "
                                         f"They placed their {sacrificed_piece} on {sacrifice_square_name}, leaving it undefended. "
                                         f"While the capture of this piece involves a gain in material, it breaks down your attack therefore extending the game. "
                                         f"Although you are still winning the game. Keep playing wisely!")
                return tactic, generated_message

        #Gère les tactics good et excellente
        if move_class == "Excellent" or move_class == "Good":
            is_promotion_check, check_promotion_attacking_name, check_promotion_attacking_square, check_promotion_king_square = promotion_check_fs()
            #Gère un check promotion
            if is_promotion_check:
                tactic = "Promotion Check"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                        generated_message = (f"You played a brilliant promotion check! "
                                             f"Your pawn advanced to {check_promotion_attacking_square}, promoting to a {check_promotion_attacking_name}. "
                                             f"This clever move puts your opponent's king on {check_promotion_king_square} in check, gaining a decisive advantage. "
                                             f"Such tactical foresight can lead to a swift victory—well done!")
                    else:
                        generated_message = (f"Your opponent played a stunning promotion check! "
                                             f"Their pawn reached {check_promotion_attacking_square} and promoted to a {check_promotion_attacking_name}, "
                                             f"placing your king on {check_promotion_king_square} in check. "
                                             f"This move complicates the position, but stay calm and seek a counterplay opportunity. "
                                             f"You still have chances to fight back!")
                    return tactic, generated_message

            #Gère un fork royale
            is_royal_fork, royal_fork_knight_square, royal_fork_king_square, royal_fork_queen_square = royal_fork_fs()
            if is_royal_fork:
                tactic = "Royal Fork"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"You executed a brilliant royal fork! Your knight on {royal_fork_knight_square} "
                                         f"simultaneously attacks your opponent's king on {royal_fork_king_square} "
                                         f"and queen on {royal_fork_queen_square}. This incredible tactical maneuver "
                                         f"leaves your opponent in a bind and puts you in a commanding position. "
                                         f"Fantastic play!")
                else:
                    generated_message = (f"Your opponent unleashed a powerful royal fork! Their knight on {royal_fork_knight_square} "
                                         f"attacks your king on {royal_fork_king_square} and queen on {royal_fork_queen_square} "
                                         f"at the same time. This puts you in a tough spot, but keep your composure and "
                                         f"look for creative defensive resources to turn the tide.")
                return tactic, generated_message

            #Gère un double echec
            is_double_check, double_check_king_square, double_check_attack_piece1, double_check_attack_square1, double_check_attack_piece2, double_check_attack_square2 = double_check_fs()
            if is_double_check:
                tactic = "Double Check"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"You executed a masterful double check! Your move placed your opponent's king on {double_check_king_square} "
                                         f"in double check from your {double_check_attack_piece1} on {double_check_attack_square1} "
                                         f"and your {double_check_attack_piece2} on {double_check_attack_square2}. This creates immense tactical pressure, "
                                         f"forcing your opponent into moving their King. Well done!")
                else:
                    generated_message = (f"Your opponent delivered a stunning double check! Their move placed your king on {double_check_king_square} "
                                         f"in double check from their {double_check_attack_piece1} on {double_check_attack_square1} "
                                         f"and their {double_check_attack_piece2} on {double_check_attack_square2}. This situation is challenging, "
                                         f"forcing you to move your king.")
                return tactic, generated_message

            #Gère un echec découvert
            is_discovered_check, discovered_check_king_square, discovered_check_moved_piece, discovered_check_moved_piece_square, discovered_check_check_piece, discovered_check_check_piece_square = discovered_check_fs()
            if is_discovered_check:
                tactic = "Discovered Check"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"You executed a brilliant discovered check! By moving your {discovered_check_moved_piece} from {discovered_check_moved_piece_square}, "
                                         f"you revealed an attack from your {discovered_check_check_piece} on {discovered_check_check_piece_square} "
                                         f"to your opponent's king on {discovered_check_king_square}. This tactical maneuver forces your opponent into a defensive position. "
                                         f"Excellent play!")
                else:
                    generated_message = (f"Your opponent unleashed a clever discovered check! By moving their {discovered_check_moved_piece} from {discovered_check_moved_piece_square}, "
                                         f"they revealed an attack from their {discovered_check_check_piece} on {discovered_check_check_piece_square} "
                                         f"to your king on {discovered_check_king_square}. This puts you in a tough spot, but focus on finding the best defensive move.")
                return tactic, generated_message

            #Gère un echec normal
            is_check_normal, check_king_square, check_attacking_name, check_attacking_square = check_fs()
            if is_check_normal:
                tactic = "Check"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"You delivered a precise check! Your {check_attacking_name} on {check_attacking_square} "
                                         f"attacks your opponent's king on {check_king_square}. This move puts them on the defensive, "
                                         f"giving you a chance to maintain the initiative. Well done!")
                else:
                    generated_message = (f"Your opponent delivered a check! Their {check_attacking_name} on {check_attacking_square} "
                                         f"attacks your king on {check_king_square}. Stay focused and look for the best way to neutralize the threat. "
                                         f"Keep fighting!")
                return tactic, generated_message

            # Gère une promotion normale
            is_normal_promotion, normal_promotion_square = normal_promotion_fs()
            if is_normal_promotion:
                tactic = "Promotion"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Congratulations! Your pawn on {normal_promotion_square} has been promoted to a queen. "
                                         f"This move significantly increases your material advantage and puts you in a commanding position. "
                                         f"Fantastic play!")
                else:
                    generated_message = (f"Your opponent's pawn on {normal_promotion_square} has been promoted to a queen. "
                                         f"Stay vigilant and look for opportunities to counter this new threat. The battle isn’t over yet!")
                return tactic, generated_message

            # Gère une sous-promotion
            is_under_promotion, under_promotion_square, under_promotion_piece_name = under_promotion_fs()
            if is_under_promotion:
                tactic = "Under-promotion"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Impressive strategy! Your pawn on {under_promotion_square} has been under-promoted to a {under_promotion_piece_name}. "
                                         f"This creative choice showcases your tactical acumen and could lead to exciting opportunities. "
                                         f"Brilliant move!")
                else:
                    generated_message = (f"Your opponent's pawn on {under_promotion_square} has been under-promoted to a {under_promotion_piece_name}. "
                                         f"This unconventional choice might hide a clever plan. Stay alert and find ways to counter their strategy. "
                                         f"Keep thinking ahead!")
                return tactic, generated_message

            #Gère capture d'une reine
            is_queen_capture, attacker_piece_name, capture_square = queen_capture_fs()
            if is_queen_capture:
                tactic = "Queen Capture"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Amazing move! Your {attacker_piece_name} has captured your opponent's Queen on {capture_square}. "
                                         f"This is a decisive blow to their position and significantly tilts the game in your favor. "
                                         f"Keep up the pressure!")
                else:
                    generated_message = (f"Tough break! Your opponent's {attacker_piece_name} has captured your Queen on {capture_square}. "
                                         f"Stay calm and look for counterplay opportunities to fight back. "
                                         f"Remember, the game isn’t over yet!")
                return tactic, generated_message

            # Gère l'épinglage d'une pièce au roi
            is_king_pin, kp_pinned_piece_name, kp_pinned_square, kp_attacker_piece, kp_attacker_square = king_pin_fs()
            if is_king_pin:
                tactic = "King Pin"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Excellent tactical awareness! Your opponent's {kp_pinned_piece_name} on {kp_pinned_square} is pinned to their King by your {kp_attacker_piece} on {kp_attacker_square}. "
                                         f"This pin severely limits their mobility and options. Consider how to capitalize on this weakness!")
                else:
                    generated_message = (f"Be cautious! Your {kp_pinned_piece_name} on {kp_pinned_square} is pinned to your King by your opponent's {kp_attacker_piece} on {kp_attacker_square}. "
                                         f"Ensure that your King’s safety is not compromised while looking for ways to break free of this pin.")
                return tactic, generated_message

            # Gère l'épinglage d'une pièce à la reine
            is_queen_pin, qp_pinned_piece_name, qp_pinned_square, qp_attacker_piece, qp_attacker_square = queen_pin_fs()
            if is_queen_pin:
                tactic = "Queen Pin"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Great move! Your opponent's {qp_pinned_piece_name} on {qp_pinned_square} is pinned to their Queen by your {qp_attacker_piece} on {qp_attacker_square}. "
                                         f"This pin puts significant pressure on their position and might lead to material gain. Stay sharp!")
                else:
                    generated_message = (f"Watch out! Your {qp_pinned_piece_name} on {qp_pinned_square} is pinned to your Queen by your opponent's {qp_attacker_piece} on {qp_attacker_square}. "
                                         f"Try to maneuver carefully to minimize the impact of this pin and protect your Queen.")
                return tactic, generated_message

            # Gère le skewering d'une pièce à la reine
            is_queen_skewer, qs_skewered_piece_name, qs_skewered_square, qs_attacker_piece, qs_attacker_square = queen_skewer_fs()
            if is_queen_skewer:
                tactic = "Queen Skewer"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Brilliant move! Your {qs_attacker_piece} on {qs_attacker_square} has skewered your opponent's Queen, exposing their {qs_skewered_piece_name} on {qs_skewered_square}. "
                                         f"This tactical play creates a winning opportunity. Keep up the pressure!")
                else:
                    generated_message = (f"Watch out! Your Queen has been skewered by your opponent's {qs_attacker_piece} on {qs_attacker_square}, exposing your {qs_skewered_piece_name} on {qs_skewered_square}. "
                                         f"Think carefully to mitigate the damage and stay in the game.")
                return tactic, generated_message

            # Gère les forks
            is_fork, fork_attacker_name, fork_attacker_square, fork_attacked_name1, fork_attacked_square1, fork_attacked_name2, fork_attacked_square2 = fork_fs()
            if is_fork:
                tactic = "Fork"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Great! Your {fork_attacker_name} on {fork_attacker_square} "
                                         f"attacks {fork_attacked_name1} on {fork_attacked_square1} and {fork_attacked_name2} on {fork_attacked_square2}. "
                                         f"This tactical fork creates immense pressure on your opponent. Fantastic play!")
                else:
                    generated_message = (f"Your opponent executed a fork! Their {fork_attacker_name} on {fork_attacker_square} "
                                         f"attacks your {fork_attacked_name1} on {fork_attacked_square1} and {fork_attacked_name2} on {fork_attacked_square2}. "
                                         f"Stay calm, analyze your position, and minimize the damage.")
                return tactic, generated_message

            # Gère les attaques découvertes
            is_discovered_attack, da_moved_piece_name, da_moved_piece_square, da_attacking_piece_name, da_attacking_piece_square, da_attacked_piece_name, da_attacked_piece_square = discovered_attack_fs()
            if is_discovered_attack:
                tactic = "Discovered Attack"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Fantastic move! Your {da_moved_piece_name} on {da_moved_piece_square} "
                                         f"enabled a discovered attack by your {da_attacking_piece_name} on {da_attacking_piece_square}, "
                                         f"targeting your opponent's {da_attacked_piece_name} on {da_attacked_piece_square}. "
                                         f"This brilliant tactical play puts immense pressure on your opponent. Well done!")
                else:
                    generated_message = (f"Be cautious! Your opponent's {da_moved_piece_name} on {da_moved_piece_square} "
                                         f"enabled a discovered attack by their {da_attacking_piece_name} on {da_attacking_piece_square}, "
                                         f"targeting your {da_attacked_piece_name} on {da_attacked_piece_square}. "
                                         f"Look for ways to minimize the damage and defend effectively.")
                return tactic, generated_message

            # Check for en passant
            is_en_passant, ep_capturing_pawn_square, ep_captured_pawn_square, ep_capture_square = en_passant_fs()
            if is_en_passant:
                tactic = "En Passant"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = ( f"Good Move! You executed an en passant capture by moving your pawn from "
                                          f"{ep_capturing_pawn_square} to {ep_capture_square}, capturing your opponent's pawn "
                                          f"on {ep_captured_pawn_square}. This rare tactical strike demonstrates excellent "
                                          f"awareness—keep it up!")
                else:
                    generated_message = (f"Be cautious! Your opponent executed an en passant capture, moving their pawn from "
                                         f"{ep_capturing_pawn_square} to {ep_capture_square} and capturing your pawn on "
                                         f"{ep_captured_pawn_square}. This tactical move can be tricky to defend against, so "
                                         f"stay sharp!")
                return tactic, generated_message


            # Gère un simple capture
            is_capture, c_attacking_piece_name, captured_piece_name, capture_square = capture_fs()
            if is_capture:
                tactic = "Capture"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Great move! Your {c_attacking_piece_name} captured your opponent's {captured_piece_name} on {capture_square}. "
                                         f"This gain in material strengthens your position—keep up the good work!")
                else:
                    generated_message = (f"Be careful! Your opponent's {c_attacking_piece_name} captured your {captured_piece_name} on {capture_square}. "
                                         f"Stay vigilant and look for opportunities to regain the advantage.")
                return tactic, generated_message

            # Gère passed pawn
            is_passed_pawn, ppawn_start_square, ppawn_end_square = push_passed_pawn_fs()
            if is_passed_pawn:
                tactic = "Push Passed Pawn"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Excellent strategy! You pushed your passed pawn from {ppawn_start_square} to {ppawn_end_square}, "
                                         f"advancing closer to promotion. This move increases your chances of converting the pawn into a more powerful piece—"
                                         f"keep up the momentum!")
                else:
                    generated_message = (f"Be cautious! Your opponent advanced their passed pawn from {ppawn_start_square} to {ppawn_end_square}, "
                                         f"bringing it closer to promotion. Look for opportunities to stop the pawn before it becomes a decisive factor in the game.")
                return tactic, generated_message


            # Detect castling
            is_castling, castling_side = castling_fs()
            if is_castling:
                tactic = "Castling"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Great move! You performed {castling_side} castling. "
                                         f"This ensures better king safety and connects your rooks for improved coordination.")
                else:
                    generated_message = (f"Be alert! Your opponent executed {castling_side} castling. "
                                         f"This improves their king safety and connects their rooks, giving them better chances to attack.")
                return tactic, generated_message

            # Detect king walk
            is_king_walk, king_start_square, king_end_square = king_walk_fs()
            if is_king_walk:
                tactic = "King Walk"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Fantastic King Walk! Your king moved from {king_start_square} to {king_end_square}, "
                                         f"heading towards the action near the enemy pieces. "
                                         f"Taking an active role, your king demonstrates excellent endgame positioning.")
                else:
                    generated_message = (f"Your opponent's King Walk is bold! Their king moved from {king_start_square} to {king_end_square}, "
                                         f"approaching the center of gravity of your pieces. "
                                         f"Prepare to counter this active maneuver in the endgame!")
                return tactic, generated_message

            # Gère threat
            is_threat, threatening_piece, threatened_piece, threatened_square = threat_fs()
            if is_threat:
                tactic = "Threat"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Great move! Your {threatening_piece} is now threatening your opponent's {threatened_piece} on {threatened_square}. "
                                         f"This increases pressure on your opponent—keep the initiative going!")
                else:
                    generated_message = (f"Be cautious! Your opponent's {threatening_piece} is now threatening your {threatened_piece} on {threatened_square}. "
                                         f"Stay alert and consider how to defend or counter this threat effectively.")
                return tactic, generated_message

            # Gère space advantage increase
            is_space_advantage, control_before, control_after = detect_space_control_increase_fs()
            if is_space_advantage:
                tactic = "Space Control Increased"
                control_increase = control_after - control_before
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Well played! You gained a space advantage by increasing control over {control_increase} additional squares. "
                                         f"This improvement strengthens your position and restricts your opponent's options—excellent strategic play!")
                else:
                    generated_message = (f"Your opponent payed well! Your opponent has gained a space advantage by increasing control over {control_increase} additional squares. "
                                         f"This could limit your mobility, so look for ways to counteract their dominance in space.")
                return tactic, generated_message

            tactic = "No tactic positive move"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"Nice move! While no specific tactic was detected, your {move_class.lower()} move contributes positively to your position. "
                                     f"Keep up the good work and stay focused on your overall strategy.")
            else:
                generated_message = (f"Your opponent played a {move_class.lower()} move. Although no tactics were found, this strengthens their position. "
                                     f"Stay sharp and look for opportunities to counter their plans.")
            return tactic, generated_message

        #Gère les tactics horrible
        if move_class == "Horrible":
            #Gère un blunder
            is_blunder, blunder_square, blunder_piece_name, blunder_recommended_next_move, blunder_attacking_piece = detect_blunder_fs()
            if is_blunder:
                tactic = "Blunder"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Oh no! You just committed a blunder. "
                                         f"Your move allowed your opponent to potentially capture your {blunder_piece_name} on {blunder_square} "
                                         f"with their {blunder_attacking_piece} by playing the move {blunder_recommended_next_move}. "
                                         f"This has caused a significant drop in evaluation. "
                                         f"Try to regain composure and find counterplay opportunities!")
                else:
                    generated_message = (f"Great opportunity! Your opponent made a blunder. "
                                         f"They left their {blunder_piece_name} on {blunder_square} undefended, and you can capture it. "
                                         f"Capture their piece with your {blunder_attacking_piece} by playing the move {blunder_recommended_next_move}. "
                                         f"This has caused their position to drop in evaluation. "
                                         f"Capitalize on this mistake to gain a decisive advantage!")
                return tactic, generated_message

            # Gère un mat forcé perdu
            if isinstance(past_eval, str) and past_eval.startswith('M') and isinstance(current_eval, int):
                past_eval_forced_value = int(past_eval[1:])
                tactic = "Missed Forced Mate"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Oh no! You missed a forced mate in {past_eval_forced_value} moves. "
                                         f"This was a golden opportunity to secure a victory by playing more accurately. "
                                         f"Instead, your move has shifted the evaluation significantly, allowing your opponent a chance to stay in the game. "
                                         f"Stay focused and look for ways to regain control of the position!")
                else:
                    generated_message = (f"Your opponent missed a forced mate in {past_eval_forced_value} moves! "
                                         f"They had a clear winning opportunity but failed to capitalize on it. "
                                         f"Use this chance to improve your position and create counterplay to fight back. "
                                         f"Stay sharp and make the most of this critical moment!")
                return tactic, generated_message


        #Gère les tactics horrible et mauvaiuse
        if move_class == "Horrible" or move_class == "Bad":
            #Gère les gains manqué
            is_missed_gain, missed_gain_square, missed_gain_piece_name, capturing_piece_name, missed_gain_move = missed_gain_fs()
            if is_missed_gain:
                tactic = "Missed Capture"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Oh no! You missed an opportunity to capture material. "
                                         f"By playing the move {missed_gain_move}, you could have captured your opponent's {missed_gain_piece_name} on {missed_gain_square} "
                                         f"using your {capturing_piece_name}. This missed gain could have significantly improved your position. "
                                         f"Stay focused and look for such opportunities in future moves!")
                else:
                    generated_message = (f"Your opponent missed an opportunity to capture material. "
                                         f"They could have played the move {missed_gain_move} to capture your {missed_gain_piece_name} on {missed_gain_square} "
                                         f"using their {capturing_piece_name}. Take advantage of their oversight to strengthen your position and create counterplay!")
                return tactic, generated_message

            #Gère une surextension d'un pion
            is_pawn_overextended, overextended_from_square, overextended_to_square = detect_pawn_overextension_fs()
            if is_pawn_overextended:
                tactic = "Pawn Overextension"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Be careful! You pushed your pawn from {overextended_from_square} to {overextended_to_square}, "
                                         f"deep into your opponent's territory. While advancing pawns can be strong, "
                                         f"this move overextends the pawn and leaves it vulnerable to attack or blockades. "
                                         f"Consider advancing pawns more cautiously to avoid weakening your position.")
                else:
                    generated_message = (f"Good opportunity! Your opponent overextended their pawn by pushing it from {overextended_from_square} to {overextended_to_square}. "
                                         f"This move leaves the pawn vulnerable to attacks or blockades. "
                                         f"Look for ways to exploit this overextension and improve your position!")
                return tactic, generated_message

            #Gère les mauvaise échanges
            is_exchange_error, from_square, to_square, capturing_piece_name, captured_piece_name = detect_exchange_error_fs()
            if is_exchange_error:
                tactic = "Exchange Error"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Oops! Your {capturing_piece_name} on {from_square} captured your opponent's {captured_piece_name} on {to_square}. "
                                         f"While these pieces are of equal material value, your {capturing_piece_name} was in a more valuable position due to its influence on the board. "
                                         f"This exchange has worsened your position and given your opponent a strategic advantage. "
                                         f"Consider moves that preserve key pieces in strong positions to maintain your advantage!")
                else:
                    generated_message = (f"Your opponent made an exchange error! Their {capturing_piece_name} on {from_square} captured your {captured_piece_name} on {to_square}. "
                                         f"Although the pieces are of equal material value, their {capturing_piece_name} was more valuable due to its strong position and influence on the game. "
                                         f"Take the piece and leverage this oversight to capitalize on your positional advantage and take control of the game!")
                return tactic, generated_message

            # Gère la surextension
            is_overextended, overextended_from_square, overextended_to_square, overextended_piece_name = overextension_fs()
            if is_overextended:
                tactic = "Overextension"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Be cautious! Your {overextended_piece_name} moved from {overextended_from_square} to {overextended_to_square}, overextending into your opponent's territory. "
                                         f"This move places your piece further from the support of your own pieces and closer to the opponent's pieces, "
                                         f"making it vulnerable to counterplay. Consider moves that maintain cohesion among your pieces!")
                else:
                    generated_message = (f"Good opportunity! Your opponent's {overextended_piece_name} moved from {overextended_from_square} to {overextended_to_square}, overextending into your side. "
                                         f"The piece is now further from their own pieces' support and closer to your pieces, making it a vulnerable target. "
                                         f"Look for ways to exploit this positional error and gain an advantage!")
                return tactic, generated_message


            # Gère une mauvaise promotion
            is_bad_promotion, bad_promotion_square = normal_promotion_fs()
            if is_bad_promotion:
                tactic = "Bad Promotion"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Oops! Your promotion of the pawn on {bad_promotion_square} to a queen might not have been the best choice. "
                                         f"While promoting to a queen is often optimal, in this case, it seems to weaken your position or allow counterplay by your opponent. "
                                         f"Consider the board situation more carefully when promoting pawns to ensure your advantage remains intact.")
                else:
                    generated_message = (f"Great news! Your opponent promoted their pawn on {bad_promotion_square} to a queen, but it seems to weaken their position. "
                                         f"Take advantage of this error by creating pressure and exploiting the queen's placement.")
                return tactic, generated_message

            # Gère une mauvaise sous-promotion
            is_bad_under_promotion, bad_under_promotion_square, bad_under_promotion_piece_name = under_promotion_fs()
            if is_bad_under_promotion:
                tactic = "Bad Under-promotion"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Careful! Your under-promotion of the pawn on {bad_under_promotion_square} to a {bad_under_promotion_piece_name} may not have been ideal. "
                                         f"While under-promotion can be clever in certain scenarios, in this case, it seems to have missed a stronger opportunity to maintain or improve your position.")
                else:
                    generated_message = (f"Your opponent under-promoted their pawn on {bad_under_promotion_square} to a {bad_under_promotion_piece_name}, "
                                         f"but it might not have been the best decision. Look for ways to exploit this suboptimal promotion to gain an advantage!")
                return tactic, generated_message

            # Gère une erreur de sécurité du roi
            is_bad_king_walk, king_start_square, king_end_square = king_walk_fs()
            if is_bad_king_walk and ((eval < 0 and not board.turn) or (eval > 0 and board.turn)):
                tactic = "King Safety Error"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Be careful! Your king's move from {king_start_square} to {king_end_square} has compromised its safety. "
                                         f"This move puts your king closer to the opponent's pieces or leaves it more exposed to potential attacks. "
                                         f"Consider prioritizing king safety, especially in critical positions, to avoid unnecessary risks.")
                else:
                    generated_message = (f"Good news! Your opponent's king move from {king_start_square} to {king_end_square} has worsened their king's safety. "
                                         f"Their king is now closer to your attacking pieces or in a more vulnerable position. "
                                         f"Capitalize on this mistake by increasing pressure on the exposed king!")
                return tactic, generated_message

            # Detect a King Defensive Error
            is_king_defensive_error_detected, castling_side = is_king_defensive_error()
            if is_king_defensive_error_detected and ((eval < 0 and not board.turn) or (eval > 0 and board.turn)):
                tactic = "King Defensive Error"
                if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                    generated_message = (f"Oops! Your move could have been better. Stockfish recommended castling {castling_side}, which would have significantly improved your king's safety. "
                                         f"Instead, your move leaves your king more vulnerable to potential attacks. Consider castling earlier in the game to enhance your king's security and position.")
                else:
                    generated_message = (f"Good opportunity! Your opponent's move was a King Defensive Error. Stockfish recommended castling {castling_side}, but they chose a different move, leaving their king more vulnerable. "
                                         f"Capitalize on this mistake by targeting their exposed king and putting pressure on their position!")
                return tactic, generated_message

            piece_name, from_square, to_square = get_recommended_move_details(recommended_move)
            tactic = "No Tactic Negative Move"
            if (not board.turn and is_player_white) or (board.turn and not is_player_white):
                generated_message = (f"Your move was {move_class.lower()}, but no specific tactical error was detected. "
                                     f"Stockfish recommends moving your {piece_name} from {from_square} to {to_square} with the move {recommended_move}. "
                                     f"This move would have improved your position significantly. Consider playing more accurate moves to maintain a stronger position.")
            else:
                generated_message = (f"Your opponent's move was {move_class.lower()}, but no specific tactical error was detected. "
                                     f"Stockfish recommends moving their {piece_name} from {from_square} to {to_square} with the move {recommended_move}. "
                                     f"This move would have strengthened their position, but they failed to find it. "
                                     f"Take advantage of this opportunity to improve your position!")
            return tactic, generated_message

    # Main of the upload function
    # Make sure all previous uploads are complete before starting this one
    while not g_upload_over:
        time.sleep(0.01)
    g_upload_over = False
    # Finds the last move made
    board = copy.deepcopy(g_board)
    move_obj = board.pop()
    board.push(move_obj)
    move_uci = move_obj.uci()
    g_white_game_data["Moves"].append(move_uci)
    g_black_game_data["Moves"].append(move_uci)

    # Adds the timer data
    g_white_game_data["White Time"].append(g_white_timer)
    g_black_game_data["White Time"].append(g_white_timer)
    g_white_game_data["Black Time"].append(g_black_timer)
    g_black_game_data["Black Time"].append(g_black_timer)

    # Calcule l'avantage materiel
    material_balance = 0
    for square, piece in board.piece_map().items():
        value = PIECE_VAL.get(piece.piece_type, 0)
        material_balance += value if piece.color == chess.WHITE else -value
    g_white_game_data["Material Advantages"].append(material_balance)
    g_black_game_data["Material Advantages"].append(material_balance)

    # Find the stockfish evaluation
    engine = chess.engine.SimpleEngine.popen_uci(STOCKFISH_PATH)
    info = engine.analyse(board, chess.engine.Limit(time=STOCKFISH_TIME))
    eval = findEvals(board, info["score"].relative)
    engine.quit()
    if isinstance(eval, str):
        upload_eval = eval
    else:
        upload_eval = str(eval / 100)
    g_white_game_data["AI Evaluations"].append(upload_eval)
    g_black_game_data["AI Evaluations"].append(upload_eval)
    try:
        recommended_next_move = info["pv"][0].uci()
        g_white_game_data["AI Recommended Moves"].append(recommended_next_move)
        g_black_game_data["AI Recommended Moves"].append(recommended_next_move)
    except (KeyError, IndexError, AttributeError):
        recommended_next_move = None

    # Find the victory probability
    victory_prob = findProbabilityVictory(board, eval)
    g_white_game_data["Victory Probabilities"].append(f"{round(victory_prob * 100, 2)}%")
    g_black_game_data["Victory Probabilities"].append(f"{round((1-victory_prob) * 100, 2)}%")

    board.pop()
    past_eval_str = g_white_game_data["AI Evaluations"][-2]
    if past_eval_str.startswith('M'):
        past_eval = past_eval_str
    else:
        past_eval = float(past_eval_str) * 100
    victory_prob_past = findProbabilityVictory(board, past_eval)
    board.push(move_obj)

    # Find move class
    move_class = moveClassification(board, victory_prob, victory_prob_past)
    g_white_game_data["Moves Classifications"].append(move_class)
    g_black_game_data["Moves Classifications"].append(move_class)

    # Generate trainer tactic and message for white
    white_tactic, white_generated_message = generate_tactics(True, board, move_uci, eval, past_eval, g_white_game_data["AI Recommended Moves"][-2], recommended_next_move, move_class)
    g_white_game_data["Tactics"].append(white_tactic)
    g_white_game_data["Trainer Messages"].append(white_generated_message)
    black_tactic, black_generated_message = generate_tactics(False, board, move_uci, eval, past_eval, g_white_game_data["AI Recommended Moves"][-2], recommended_next_move, move_class)
    g_black_game_data["Tactics"].append(black_tactic)
    g_black_game_data["Trainer Messages"].append(black_generated_message)

    g_white_player_ref.child("Games").child(g_white_game_key).set(g_white_game_data)
    g_black_player_ref.child("Games").child(g_black_game_key).set(g_black_game_data)
    g_upload_over = True


def game_loop():
    global G_WHITE_PLAYER_ID, G_BLACK_PLAYER_ID, G_ASSISTANCE, g_board, g_colors, g_color_pre_lifted_piece, g_promoted_piece, g_upload_over
    global g_white_player_ref, g_black_player_ref, g_white_game_data, g_black_game_data, g_white_game_key, g_black_game_key
    global g_game_terminated, g_game_started, g_white_timer, g_black_timer, g_white_timer_button, g_black_timer_button, G_TIMER
    global g_white_resign, g_black_resign, g_white_draw, g_black_draw, g_bit_board, g_old_bit_board, g_lifted_piece, g_captured_piece
    global g_color_pre_error, g_illegal_move, G_EXTRA_TIME, G_WITH_CLOCK, G_GAMEMODE, G_SINGLE_PLAYER_COLOR, G_SINGLE_PLAYER_AI_STRENGTH
    global STOCKFISH_TIME, STOCKFISH_PATH

    def validateAndMakeMove():
        global g_board, g_bit_board, g_colors, g_lifted_piece, g_captured_piece, g_promoted_piece, g_illegal_move
        def boardToBitBoard(board):
            bit_board = [1] * 64
            for square, piece in board.piece_map().items():
                bit_board[square] = 0
            return bit_board
        def is_castling_move(board, move):
            if board.turn == chess.WHITE:
                if move.from_square == chess.E1 and board.piece_at(chess.E1) == chess.Piece(chess.KING, chess.WHITE):
                    # Kingside castling for white
                    if move.to_square == chess.G1 and board.has_kingside_castling_rights(chess.WHITE):
                        return True
                    # Queenside castling for white
                    elif move.to_square == chess.C1 and board.has_queenside_castling_rights(chess.WHITE):
                        return True
            else:
                if move.from_square == chess.E8 and board.piece_at(chess.E8) == chess.Piece(chess.KING, chess.BLACK):
                    # Kingside castling for black
                    if move.to_square == chess.G8 and board.has_kingside_castling_rights(chess.BLACK):
                        return True
                    # Queenside castling for black
                    elif move.to_square == chess.C8 and board.has_queenside_castling_rights(chess.BLACK):
                        return True
            return False

        #Main of validate and make move
        for legal_move in g_board.legal_moves:
            if legal_move.promotion and legal_move.from_square == g_lifted_piece and legal_move.to_square == g_captured_piece:
                while g_promoted_piece == "None":
                    time.sleep(0.1)
                promotion_map = {
                    "Queen": chess.QUEEN,
                    "Rook": chess.ROOK,
                    "Knight": chess.KNIGHT,
                    "Bishop": chess.BISHOP
                }
                promotion_piece = promotion_map.get(g_promoted_piece)

                if legal_move.promotion == promotion_piece:
                    g_board.push(legal_move)
                    if g_bit_board == boardToBitBoard(g_board):
                        g_lifted_piece = None
                        g_captured_piece = None
                        g_promoted_piece = "None"
                        g_board.pop()
                        return legal_move
                    else:
                        g_board.pop()


        for legal_move in g_board.legal_moves:
            if is_castling_move(g_board, legal_move):
                g_board.push(legal_move)
                if g_bit_board == boardToBitBoard(g_board):
                    g_lifted_piece = None
                    g_captured_piece = None
                    g_board.pop()
                    return legal_move
                else:
                    g_board.pop()
        for legal_move in g_board.legal_moves:
            if legal_move.from_square == g_lifted_piece and legal_move.to_square == g_captured_piece:
                g_board.push(legal_move)
                if g_bit_board != boardToBitBoard(g_board):
                    g_board.pop()
                    return None
                g_lifted_piece = None
                g_captured_piece = None
                g_board.pop()
                return legal_move

        # Illegal move here
        if g_lifted_piece is not None and g_captured_piece is not None:
            g_illegal_move = True
            g_colors[g_lifted_piece] = (True, 255, 0, 0)
            g_colors[g_captured_piece] = (True, 200, 100, 100)
            #updateLEDS()
        return None

    # Detects a move on the board and logs the lifted and captured piece. Request a move validation processing if needed
    def boardMovement():
        global G_ASSISTANCE, g_colors, g_board, g_bit_board, g_old_bit_board, g_color_pre_lifted_piece, g_lifted_piece, g_captured_piece
        global g_color_pre_error, g_illegal_move, g_white_game_data
        global G_GAMEMODE, G_SINGLE_PLAYER_COLOR

        # Detects if a change has occurred, if not we return False
        square_diff = None
        for i in range(len(g_bit_board)):
            if g_bit_board[i] != g_old_bit_board[i]:
                square_diff = i
        g_old_bit_board = copy.deepcopy(g_bit_board)
        if square_diff is None:
            return False
        piece = g_board.piece_at(square_diff)

        # Detects if the player has picken up on of his own pieces
        if g_bit_board[square_diff] == 1 and piece is not None and piece.color == g_board.turn and g_lifted_piece is None:
            g_lifted_piece = square_diff
            # Light up the stockfish requests if assistance is
            if G_ASSISTANCE == "Trainer Assisted" and (G_GAMEMODE == "Multiplayer" or (G_GAMEMODE == "Singleplayer" and not ((G_SINGLE_PLAYER_COLOR == "White" and not g_board.turn) or (G_SINGLE_PLAYER_COLOR == "Black" and g_board.turn)))):
                g_color_pre_lifted_piece = copy.deepcopy(g_colors)
                g_colors[square_diff] = (True, 0, 0, 255) #Blue
                #updateLEDS()
                moves_from_square = [move for move in g_board.legal_moves if move.from_square == square_diff]
                time_stockfish = 0
                if len(moves_from_square) != 0:
                    time_stockfish = 0.05 / len(moves_from_square)
                current_eval_str = g_white_game_data["AI Evaluations"][-1]
                if current_eval_str.startswith('M'):
                    current_eval = current_eval_str
                else:
                    current_eval = float(current_eval_str) * 100
                current_victory_prob = findProbabilityVictory(g_board, current_eval)
                engine = chess.engine.SimpleEngine.popen_uci(STOCKFISH_PATH)
                board = copy.deepcopy(g_board)
                for move in moves_from_square:
                    board.push(move)
                    info = engine.analyse(board, chess.engine.Limit(time=time_stockfish))
                    next_eval = findEvals(board, info["score"].relative)
                    next_victory_prob = findProbabilityVictory(board, next_eval)
                    move_class = moveClassification(board, next_victory_prob, current_victory_prob)
                    if move_class == "Excellent":
                        g_colors[move.to_square] = (True, 0, 255, 0) # Green
                    elif move_class == "Good":
                        g_colors[move.to_square] = (True, 100, 250, 100) # Light Green
                    elif move_class == "Bad":
                        g_colors[move.to_square] = (True, 250, 100, 100) # Light Red
                    else:
                        g_colors[move.to_square] = (True, 255, 0, 0) # Red
                    board.pop()
                    #updateLEDS()
                engine.quit()

            # Light up the possible legal moves if assistance is easy
            if G_ASSISTANCE == "Easy" and (G_GAMEMODE == "Multiplayer" or (G_GAMEMODE == "Singleplayer" and not ((G_SINGLE_PLAYER_COLOR == "White" and not g_board.turn) or (G_SINGLE_PLAYER_COLOR == "Black" and g_board.turn)))):
                g_color_pre_lifted_piece = copy.deepcopy(g_colors)
                g_colors[square_diff] = (True, 0, 0, 255) #Blue
                moves_from_square = [move for move in g_board.legal_moves if move.from_square == square_diff]
                for move in moves_from_square:
                    g_colors[move.to_square] = (True, 0, 175, 250) #Light Blue
                #updateLEDS()

            return False

        # Detects if the player places the piece back down
        elif g_bit_board[square_diff] == 0 and g_lifted_piece == square_diff:
            g_lifted_piece = None
            g_colors = copy.deepcopy(g_color_pre_lifted_piece)
            #updateLEDS()
            return False

        # Detect if the player has placed down its piece on another square than the original, this indicates the end of a move
        elif g_lifted_piece is not None and g_bit_board[square_diff] == 0 and (piece is None or piece.color != g_board.turn):
            g_captured_piece = square_diff
            g_color_pre_error = copy.deepcopy(g_colors)
            g_colors = copy.deepcopy(g_color_pre_lifted_piece)
            #updateLEDS()
            return True

        # Detect if the player picks up a piece from the other players pieces, this can be the end of a move in the case of an en passant
        elif g_lifted_piece is not None and g_captured_piece is not None and g_bit_board[square_diff] == 1:
            if g_illegal_move:
                g_colors = copy.deepcopy(g_color_pre_error)
                #updateLEDS()
                g_illegal_move = False
                return False
            return True
        return False

    def validateEndGame():
        global g_board, g_white_resign, g_black_resign, g_white_draw, g_black_draw, g_white_timer, g_black_timer
        if g_board.is_checkmate():
            if g_board.turn:
                return True, "Black", "Checkmate! Black wins."
            else:
                return True, "White", "Checkmate! White wins."
        elif g_board.is_stalemate():
            if g_board.turn:
                return True, "Draw", "Stalemate! The white player has no legal moves, the game is a draw."
            else:
                return True, "Draw", "Stalemate! The white player has no legal moves, the game is a draw."
        elif g_white_draw and g_black_draw:
            return True, "Draw", "Draw! Players have agreed to draw the game."
        elif g_white_resign:
            return True, "Black", "Black wins! White has resigned the game."
        elif g_black_resign:
            return True, "White", "White wins! Black has resigned the game."
        elif g_white_timer < 0:
            return True, "Black", "Black wins! White has run out of time."
        elif g_black_timer < 0:
            return True, "White", "White wins! Black has run out of time."
        elif g_board.can_claim_fifty_moves():
            return True, "Draw", "Draw! No captures or pawn moves were made in the last 50 moves, this leeds to a draw."
        elif g_board.is_insufficient_material():
            return True, "Draw", "Draw! There is insufficient material for a checkmate, the game has ended in a draw."
        elif g_board.can_claim_threefold_repetition():
            return True, "Draw", "Draw! There was a threefolds repition, the game has ended in a draw."
        return False, None, None

    """
    Main of the game loop function
    Game initialisation before the game loop
    """
    # Searches if players are in the database
    g_white_player_ref = db.reference(f"users/{G_WHITE_PLAYER_ID}")
    g_black_player_ref = db.reference(f"users/{G_BLACK_PLAYER_ID}")
    white_player_data = g_white_player_ref.get()
    black_player_data = g_black_player_ref.get()
    if white_player_data is None:
        print(f"Player '{G_WHITE_PLAYER_ID}' does not exist in the database.")
        exit(-10)
    if black_player_data is None:
        print(f"Player '{G_BLACK_PLAYER_ID}' does not exist in the database.")
        exit(-10)

    # Extract the elo information and set up the new game dictionary
    white_elo = white_player_data.get("Elo")
    black_elo = black_player_data.get("Elo")
    g_white_game_data["Player Color"] = "White"
    g_white_game_data["White Elo"] = white_elo
    g_white_game_data["Black Elo"] = black_elo
    g_black_game_data["Player Color"] = "Black"
    g_black_game_data["White Elo"] = white_elo
    g_black_game_data["Black Elo"] = black_elo

    # Initialise the games victory probabilities
    g_white_game_data["Victory Probabilities"][0] = "53.3%"
    g_black_game_data["Victory Probabilities"][0] = "46.7%"

    #Initialises the clock time of the game
    g_white_timer = G_TIMER * 60
    g_black_timer = G_TIMER * 60
    g_white_game_data["White Time"][0] = g_white_timer
    g_black_game_data["White Time"][0] = g_white_timer
    g_white_game_data["Black Time"][0] = g_black_timer
    g_black_game_data["Black Time"][0] = g_black_timer


    #Create new game and upload it in the database
    white_games_played = white_player_data.get("Games Played", 0)
    white_games_played += 1
    g_white_player_ref.child("Games Played").set(white_games_played)
    black_games_played = black_player_data.get("Games Played", 0)
    black_games_played += 1
    g_black_player_ref.child("Games Played").set(black_games_played)
    g_white_game_key = f"Game{white_games_played}"
    g_black_game_key = f"Game{black_games_played}"

    g_white_player_ref.child("Games").child(g_white_game_key).set(g_white_game_data)
    g_black_player_ref.child("Games").child(g_black_game_key).set(g_black_game_data)



    g_board = chess.Board()

    # Start the game one the black timer is started and if the bit board is in the correct state
    while True:
        #for i in range(64):
            #if g_bit_board[i] == 0:
                #g_colors[i] = (True, 0, 255, 0)
            #else:
                #g_colors[i] = (False, 255, 255, 255)
        if g_black_timer_button and g_bit_board != STARTING_BIT_BOARD:
            g_black_timer_button = False
        if g_black_timer_button and g_bit_board == STARTING_BIT_BOARD:
            g_black_timer_button = False
            #g_colors = [(False, 255, 255, 255) for _ in range(64)]
            break
        time.sleep(0.01)



    # Game loop
    last_time = time.perf_counter()
    move_made = None
    request_move = True
    while True:
        current_time = time.perf_counter()
        elapsed_time = current_time - last_time
        last_time = current_time

        if g_game_terminated:
            break


        #Single Player mode lights
        if request_move and G_GAMEMODE == "Singleplayer" and ((G_SINGLE_PLAYER_COLOR == "White" and not g_board.turn) or (G_SINGLE_PLAYER_COLOR == "Black" and g_board.turn)):
            request_move = False
            engine = chess.engine.SimpleEngine.popen_uci(STOCKFISH_PATH)
            engine.configure({"UCI_LimitStrength": True, "UCI_Elo": G_SINGLE_PLAYER_AI_STRENGTH})
            result = engine.play(g_board, chess.engine.Limit(time=STOCKFISH_TIME))
            g_colors[result.move.to_square] = (True, 255, 165, 0)
            g_colors[result.move.from_square] = (True, 255, 165, 0)
            #updateLEDS()




        # Looks for movement on the board and logs it, if a move validation is needed, we process it
        process_move = None
        if move_made is None:
            process_move = boardMovement()

        # If processing is needed, move is processed, if no move is detected, None is return
        if process_move and move_made is None:
            move_made = validateAndMakeMove()

        # Push the move to the board in sync with the timer if it is used
        move_complete = False
        if (move_made is not None and not G_WITH_CLOCK) or (move_made is not None and g_board.turn and g_white_timer_button) or (move_made is not None and not g_board.turn and g_black_timer_button):
            g_board.push(move_made)
            if not g_board.turn:
                g_white_timer += G_EXTRA_TIME
            else:
                g_black_timer += G_EXTRA_TIME
            g_colors = [(False, 255, 255, 255) for _ in range(64)]
            g_colors[move_made.from_square] = (True, 200, 200, 100)
            g_colors[move_made.to_square] = (True, 200, 200, 150)
            #updateLEDS()
            move_made = None
            g_white_timer_button = False
            g_black_timer_button = False
            move_complete = True
            request_move = True


        # Gather and save all of the information about the move onto the database, use a thread to do this
        if move_complete:
            upload_thread = threading.Thread(target=upload_current_game, daemon=True)
            upload_thread.start()

        # Validate end of the game
        game_over, winner, game_over_message = validateEndGame()
        if game_over:
            # Calculate Elo change after the game outcome
            probability_victory_white = 1 / (1 + 10 ** ((black_elo - white_elo) / 400))
            probability_victory_black = 1 / (1 + 10 ** ((white_elo - black_elo) / 400))
            if winner == "White":
                new_elo_white = white_elo + 20 * (1 - probability_victory_white)
                new_elo_black = black_elo + 20 * (0 - probability_victory_black)
            elif winner == "Black":
                new_elo_white = white_elo + 20 * (0 - probability_victory_white)
                new_elo_black = black_elo + 20 * (1 - probability_victory_black)
            else:
                new_elo_white = white_elo + 20 * (0.5 - probability_victory_white)
                new_elo_black = black_elo + 20 * (0.5 - probability_victory_black)
            new_elo_white = int(new_elo_white)
            new_elo_black = int(new_elo_black)
            while not g_upload_over:
                time.sleep(0.1)
            g_white_game_data["Result"] = game_over_message
            g_black_game_data["Result"] = game_over_message
            g_white_player_ref.child("Elo").set(new_elo_white)
            g_black_player_ref.child("Elo").set(new_elo_black)
            g_white_player_ref.child("Games").child(g_white_game_key).set(g_white_game_data)
            g_black_player_ref.child("Games").child(g_black_game_key).set(g_black_game_data)
            g_game_terminated = True
            time.sleep(1)
            winning_king_square = None
            losing_king_square = None
            if winner == "White":
                winning_king_square = g_board.king(chess.WHITE)
                losing_king_square = g_board.king(chess.BLACK)
            elif winner == "Black":
                winning_king_square = g_board.king(chess.BLACK)
                losing_king_square = g_board.king(chess.WHITE)
            
            for iter in range(5):
                for i, square in enumerate(chess.SQUARES):
                    file = chess.square_file(square)
                    rank = chess.square_rank(square)
                    fr = file + rank

                    if (iter % 2 == 0 and fr % 2 == 0) or (iter % 2 == 1 and fr % 2 == 1):
                        g_colors[i] = (True, 0, 0, 255)
                    else:
                        g_colors[i] = (False, 0, 0, 0)

                if losing_king_square is not None:
                    g_colors[losing_king_square] = (True, 255, 0, 0)
                if winning_king_square is not None:
                    g_colors[winning_king_square] = (True, 0, 255, 0)
                #updateLEDS()
                time.sleep(1)  
            g_colors = [(False, 255, 255, 255) for _ in range(64)]
            #updateLEDS()
            time.sleep(1)

        if g_board.turn:
            g_white_timer -= elapsed_time
        else:
            g_black_timer -= elapsed_time
        time.sleep(0.1)

def main():
    try:
        global G_SER
        G_SER = initialize_serial()
        bitboard_leds_loop_thread = threading.Thread(target=bitboard_leds_loop, daemon=True)
        bitboard_leds_loop_thread.start()
        read_db_thread = threading.Thread(target=read_database_inputs, daemon=True)
        read_db_thread.start()
        extract_game_data()
        ui_thread = threading.Thread(target=chess_UI, daemon=True)
        ui_thread.start()
        game_loop()
    finally:
        print("Closing")
        G_SER.close()
        os._exit(0)


# Run the main function
if __name__ == "__main__":
    main()
