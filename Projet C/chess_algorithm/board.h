#ifndef BOARD.H
#define BOARD.H

#include <pthread.h>
//Fonction du fichier


/*
 * char board[8][8]: Double char array representing the squares of a chess board ex. board[1][0] = square b1
 * char playerTurn: 'w' = whites turn to play, 'b' = blacks turn to play
 * castlingRights: 'KQkq' K means white can still castle king side, etc.
 * enPassant: If an enpassant is permitted, the square code will appear in the array (needs to be converted to our format)
 */
typedef struct {
    char board[8][8];
    char playerTurn;
    char castlingRights[4];
    int enPassant[2];
} BoardStruct;


typedef struct BoardNode BoardNode;
struct BoardNode{
    BoardStruct board_struct;
    BoardNode **next_boards_arr;
    int next_board_num;
};


typedef struct {
    BoardNode *node;
    pthread_mutex_t *mutex;
} ThreadData2;




/*
 * Input: Pointer to the 8x8 board matrix
 * Output: Prints to console the board as per whites prespective
 */
void printBoardWhitePrespective(char (*board)[8]);

/*
 * Input: Pointer to the 8x8 board matrix
 * Output: Prints to console the board as per whites prespective
 */
void printBoardBlackPrespective(char (*board)[8]);


/*
 * Input: Board structure
 * Input: Players color
 * Output: Prints the Board from the prespective of the player using the printBoard (Block or White) Prespective func.
 *         Also prints remaining game information found in the Board Structure.
 */
void dispBoardStruct(BoardStruct board_struct, char player_color);

/*
 * Input: String of FEN code representing a chess position
 * Input: pointer to an empty 8x8 char array representing a chess board
 * Output: returns a filed in board according to the FEN code
 */
 /*
 * Input: String of FEN code representing a chess position
 * Input: Length of the previous string
 * Input: Pointer to a character byte representing the color of the next player to move
 * Input: 4 byte array that displays the casling rights available for the position
 * Input: 2 byte array that displays the enPassant square available if the move is possible, -- if not
 * Input: Pointer to an int representing the halfCounter
 * Input: Pointer to an int representing the fullCounter
 * Output: All status values used as inputs are initialized by the function
 */
/*
 * Input: String of FEN code representing a chess position
 * Input: Length of the previous string
 * Output: Initializes global variables representing the current game status
 */
BoardNode FenToBoard(char position_FEN[], int position_LEN_lenght, char player_color);


int countMoves(BoardNode *board_node, int depth);

void freeBoardNode(BoardNode *board_node);


void freeRootNode(BoardNode *root_node);

#endif /* BOARD.H */































