#include <stdio.h>
#include <stdlib.h>
#include "board.h"
#include "pseudo_moves.h"
#include "moves.h"
#include "evalutation.h"


void addBoardToArray(BoardStruct **boardsArr, BoardStruct new_board, int *arraySize) {
    (*arraySize)++;
    *boardsArr = realloc(*boardsArr, (*arraySize) * sizeof(BoardStruct));
    if (*boardsArr == NULL) {
        printf("Memory reallocation failed\n");
        exit(1);
    }
    (*boardsArr)[*arraySize - 1] = new_board;
}

char pieceColor(char piece)
{
    if (piece == ' '){
        return ' ';
    } else if (piece < 90){
        return 'w';
    } else {
        return 'b';
    }
}

void moveWhitePawn(BoardStruct bs, int x, int y, BoardStruct **boardsArr, int *arraySize)
{
    if (bs.board[x][y+1] == ' '){
        if (y < 6){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][y+1] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][y+1] = 'Q';
            addBoardToArray(boardsArr, new_board, arraySize);
            BoardStruct new_board2 = bs;
            new_board2.board[x][y] = ' ';
            new_board2.board[x][y+1] = 'R';
            addBoardToArray(boardsArr, new_board2, arraySize);
            BoardStruct new_board3 = bs;
            new_board3.board[x][y] = ' ';
            new_board3.board[x][y+1] = 'B';
            addBoardToArray(boardsArr, new_board3, arraySize);
            BoardStruct new_board4 = bs;
            new_board4.board[x][y] = ' ';
            new_board4.board[x][y+1] = 'N';
            addBoardToArray(boardsArr, new_board4, arraySize);
        }

    }
    if (y == 1 && bs.board[x][2] == ' ' && bs.board[x][3] == ' '){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[x][y+2] = bs.board[x][y];
        //Add en passant flag is there is an enemy pawn on one side
        if (new_board.board[x-1][y+2] == 'p' || new_board.board[x+1][y+2] == 'p'){
            new_board.enPassant[0] = x;
            new_board.enPassant[1] = y+1;
        }
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (x+1 < 8 && pieceColor(bs.board[x+1][y+1]) == 'b'){
        if (y<6){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x+1][y+1] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x+1][y+1] = 'Q';
            addBoardToArray(boardsArr, new_board, arraySize);
            BoardStruct new_board2 = bs;
            new_board2.board[x][y] = ' ';
            new_board2.board[x+1][y+1] = 'R';
            addBoardToArray(boardsArr, new_board2, arraySize);
            BoardStruct new_board3 = bs;
            new_board3.board[x][y] = ' ';
            new_board3.board[x+1][y+1] = 'B';
            addBoardToArray(boardsArr, new_board3, arraySize);
            BoardStruct new_board4 = bs;
            new_board4.board[x][y] = ' ';
            new_board4.board[x+1][y+1] = 'N';
            addBoardToArray(boardsArr, new_board4, arraySize);
        }
    }
    if (x-1 >= 0 && pieceColor(bs.board[x-1][y+1]) == 'b'){
        if (y<6){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x-1][y+1] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x-1][y+1] = 'Q';
            addBoardToArray(boardsArr, new_board, arraySize);
            BoardStruct new_board2 = bs;
            new_board2.board[x][y] = ' ';
            new_board2.board[x-1][y+1] = 'R';
            addBoardToArray(boardsArr, new_board2, arraySize);
            BoardStruct new_board3 = bs;
            new_board3.board[x][y] = ' ';
            new_board3.board[x-1][y+1] = 'B';
            addBoardToArray(boardsArr, new_board3, arraySize);
            BoardStruct new_board4 = bs;
            new_board4.board[x][y] = ' ';
            new_board4.board[x-1][y+1] = 'N';
            addBoardToArray(boardsArr, new_board4, arraySize);
        }
    }
}

void moveBlackPawn(BoardStruct bs, int x, int y, BoardStruct **boardsArr, int *arraySize)
{
    if (bs.board[x][y-1] == ' '){
        if (y > 1){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][y-1] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][y-1] = 'q';
            addBoardToArray(boardsArr, new_board, arraySize);
            BoardStruct new_board2 = bs;
            new_board2.board[x][y] = ' ';
            new_board2.board[x][y-1] = 'r';
            addBoardToArray(boardsArr, new_board2, arraySize);
            BoardStruct new_board3 = bs;
            new_board3.board[x][y] = ' ';
            new_board3.board[x][y-1] = 'b';
            addBoardToArray(boardsArr, new_board3, arraySize);
            BoardStruct new_board4 = bs;
            new_board4.board[x][y] = ' ';
            new_board4.board[x][y-1] = 'n';
            addBoardToArray(boardsArr, new_board4, arraySize);
        }
    }
    if (y == 6 && bs.board[x][5] == ' ' && bs.board[x][4] == ' '){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[x][y-2] = bs.board[x][y];
        //Add en passant flag is there is an enemy pawn on one side
        if (new_board.board[x-1][y-2] == 'P' || new_board.board[x+1][y-2] == 'P'){
            new_board.enPassant[0] = x;
            new_board.enPassant[1] = y-1;
        }
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (x+1 < 8 && pieceColor(bs.board[x+1][y-1]) == 'w'){
        if (y > 1){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x+1][y-1] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x+1][y-1] = 'q';
            addBoardToArray(boardsArr, new_board, arraySize);
            BoardStruct new_board2 = bs;
            new_board2.board[x][y] = ' ';
            new_board2.board[x+1][y-1] = 'r';
            addBoardToArray(boardsArr, new_board2, arraySize);
            BoardStruct new_board3 = bs;
            new_board3.board[x][y] = ' ';
            new_board3.board[x+1][y-1] = 'b';
            addBoardToArray(boardsArr, new_board3, arraySize);
            BoardStruct new_board4 = bs;
            new_board4.board[x][y] = ' ';
            new_board4.board[x+1][y-1] = 'n';
            addBoardToArray(boardsArr, new_board4, arraySize);
        }
    }
    if (x-1 >= 0 && pieceColor(bs.board[x-1][y-1]) == 'w'){
        if (y > 1){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x-1][y-1] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x-1][y-1] = 'q';
            addBoardToArray(boardsArr, new_board, arraySize);
            BoardStruct new_board2 = bs;
            new_board2.board[x][y] = ' ';
            new_board2.board[x-1][y-1] = 'r';
            addBoardToArray(boardsArr, new_board2, arraySize);
            BoardStruct new_board3 = bs;
            new_board3.board[x][y] = ' ';
            new_board3.board[x-1][y-1] = 'b';
            addBoardToArray(boardsArr, new_board3, arraySize);
            BoardStruct new_board4 = bs;
            new_board4.board[x][y] = ' ';
            new_board4.board[x-1][y-1] = 'n';
            addBoardToArray(boardsArr, new_board4, arraySize);
        }
    }
}

void moveRook(BoardStruct bs, int x, int y, BoardStruct **boardsArr, int *arraySize)
{
    int new_x = x+1;
    while (new_x < 8){
        if (bs.board[new_x][y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[new_x][y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_x++;
    }
    new_x = x-1;
    while (new_x >= 0){
        if (bs.board[new_x][y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[new_x][y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_x--;
    }
    int new_y = y+1;
    while (new_y < 8){
        if (bs.board[x][new_y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[x][new_y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_y++;
    }
    new_y = y-1;
    while (new_y >= 0){
        if (bs.board[x][new_y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[x][new_y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_y--;
    }
}
void moveBishop(BoardStruct bs, int x, int y, BoardStruct **boardsArr, int *arraySize)
{
    int new_x = x+1;
    int new_y = y+1;
    while (new_x < 8 && new_y < 8){
        if (bs.board[new_x][new_y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[new_x][new_y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_x++;
        new_y++;
    }
    new_x = x-1;
    new_y = y+1;
    while (new_x >= 0 && new_y < 8){
        if (bs.board[new_x][new_y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[new_x][new_y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_x--;
        new_y++;
    }
    new_x = x-1;
    new_y = y-1;
    while (new_x >= 0 && new_y >= 0){
        if (bs.board[new_x][new_y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[new_x][new_y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_x--;
        new_y--;
    }
    new_x = x+1;
    new_y = y-1;
    while (new_x < 8 && new_y >= 0){
        if (bs.board[new_x][new_y] == ' '){
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
        } else if (pieceColor(bs.board[new_x][new_y]) == bs.playerTurn){
            break;
        } else {
            BoardStruct new_board = bs;
            new_board.board[x][y] = ' ';
            new_board.board[new_x][new_y] = bs.board[x][y];
            addBoardToArray(boardsArr, new_board, arraySize);
            break;
        }
        new_x++;
        new_y--;
    }
}

void moveKnight(BoardStruct bs, int x, int y, BoardStruct **boardsArr, int *arraySize)
{
    int minus_x = x-1;
    int plus_x = x+1;
    int minus_y = y-1;
    int plus_y = y+1;
    int minus_x2 = x-2;
    int plus_x2 = x+2;
    int minus_y2 = y-2;
    int plus_y2 = y+2;
    if (minus_x2 >= 0 && minus_y >= 0 && pieceColor(bs.board[minus_x2][minus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x2][minus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (minus_x2 >= 0 && plus_y < 8 && pieceColor(bs.board[minus_x2][plus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x2][plus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (minus_x >= 0 && minus_y2 >= 0 && pieceColor(bs.board[minus_x][minus_y2]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x][minus_y2] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (minus_x >= 0 && plus_y2 < 8 && pieceColor(bs.board[minus_x][plus_y2]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x][plus_y2] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x < 8 && minus_y2 >= 0 && pieceColor(bs.board[plus_x][minus_y2]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x][minus_y2] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x < 8 && plus_y2 < 8 && pieceColor(bs.board[plus_x][plus_y2]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x][plus_y2] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x2 < 8 && minus_y >= 0 && pieceColor(bs.board[plus_x2][minus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x2][minus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x2 < 8 && plus_y < 8 && pieceColor(bs.board[plus_x2][plus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x2][plus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
}

void moveKing(BoardStruct bs, int x, int y, BoardStruct **boardsArr, int *arraySize)
{
    int minus_x = x-1;
    int plus_x = x+1;
    int minus_y = y-1;
    int plus_y = y+1;
    if (minus_x >= 0 && minus_y >= 0 && pieceColor(bs.board[minus_x][minus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x][minus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (minus_x >= 0 && plus_y < 8 && pieceColor(bs.board[minus_x][plus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x][plus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x < 8 && minus_y >= 0 && pieceColor(bs.board[plus_x][minus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x][minus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x < 8 && plus_y < 8 && pieceColor(bs.board[plus_x][plus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x][plus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (minus_x >= 0 && pieceColor(bs.board[minus_x][y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[minus_x][y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_x < 8 && pieceColor(bs.board[plus_x][y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[plus_x][y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (minus_y >= 0 && pieceColor(bs.board[x][minus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[x][minus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (plus_y < 8 && pieceColor(bs.board[x][plus_y]) != bs.playerTurn){
        BoardStruct new_board = bs;
        new_board.board[x][y] = ' ';
        new_board.board[x][plus_y] = bs.board[x][y];
        addBoardToArray(boardsArr, new_board, arraySize);
    }
}

void enPassantWhite(BoardStruct bs, BoardStruct **boardsArr, int *arraySize)
{
    if (bs.enPassant[0]-1 >= 0 && bs.board[bs.enPassant[0]-1][bs.enPassant[1]-1] == 'P'){
        BoardStruct new_board = bs;
        new_board.board[bs.enPassant[0]-1][bs.enPassant[1]-1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]-1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]] = 'P';
        new_board.enPassant[0] = -1;
        new_board.enPassant[1] = -1;
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (bs.enPassant[0]+1 < 8 && bs.board[bs.enPassant[0]+1][bs.enPassant[1]-1] == 'P'){
        BoardStruct new_board = bs;
        new_board.board[bs.enPassant[0]+1][bs.enPassant[1]-1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]-1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]] = 'P';
        new_board.enPassant[0] = -1;
        new_board.enPassant[1] = -1;
        addBoardToArray(boardsArr, new_board, arraySize);
    }

}

void enPassantBlack(BoardStruct bs, BoardStruct **boardsArr, int *arraySize)
{
    if (bs.enPassant[0]-1 >= 0 && bs.board[bs.enPassant[0]-1][bs.enPassant[1]+1] == 'p'){
        BoardStruct new_board = bs;
        new_board.board[bs.enPassant[0]-1][bs.enPassant[1]+1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]+1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]] = 'p';
        new_board.enPassant[0] = -1;
        new_board.enPassant[1] = -1;
        addBoardToArray(boardsArr, new_board, arraySize);
    }
    if (bs.enPassant[0]+1 < 8 && bs.board[bs.enPassant[0]+1][bs.enPassant[1]+1] == 'p'){
        BoardStruct new_board = bs;
        new_board.board[bs.enPassant[0]+1][bs.enPassant[1]+1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]+1] = ' ';
        new_board.board[bs.enPassant[0]][bs.enPassant[1]] = 'p';
        new_board.enPassant[0] = -1;
        new_board.enPassant[1] = -1;
        addBoardToArray(boardsArr, new_board, arraySize);
    }
}




void genPseudoLegal(BoardStruct bs, BoardStruct **boardsArr, int *num_moves)
{
    if (bs.enPassant[0] != -1 && bs.playerTurn == 'w'){
        enPassantWhite(bs, boardsArr, num_moves);
        bs.enPassant[0] = -1;
        bs.enPassant[1] = -1;
    }
    else if (bs.enPassant[0] != -1 && bs.playerTurn == 'b'){
        enPassantBlack(bs, boardsArr, num_moves);
        bs.enPassant[0] = -1;
        bs.enPassant[1] = -1;
    }
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (bs.board[i][j] == ' '){
                continue;
            }
            else if (bs.board[i][j] == 'P' && bs.playerTurn == 'w'){
                moveWhitePawn(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'p' && bs.playerTurn == 'b'){
                moveBlackPawn(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'R' && bs.playerTurn == 'w'){
                moveRook(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'r' && bs.playerTurn == 'b'){
                moveRook(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'B' && bs.playerTurn == 'w'){
                moveBishop(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'b' && bs.playerTurn == 'b'){
                moveBishop(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'N' && bs.playerTurn == 'w'){
                moveKnight(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'n' && bs.playerTurn == 'b'){
                moveKnight(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'K' && bs.playerTurn == 'w'){
                moveKing(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'k' && bs.playerTurn == 'b'){
                moveKing(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'Q' && bs.playerTurn == 'w'){
                moveBishop(bs, i, j, boardsArr, num_moves);
                moveRook(bs, i, j, boardsArr, num_moves);
            }
            else if (bs.board[i][j] == 'q' && bs.playerTurn == 'b'){
                moveBishop(bs, i, j, boardsArr, num_moves);
                moveRook(bs, i, j, boardsArr, num_moves);
            }
        }
    }
    if (bs.castlingRights[0] == 'K' && bs.playerTurn == 'w'){
        if (bs.board[5][0] == ' ' && bs.board[6][0] == ' ' && bs.board[4][0] == 'K'){
            if (inCheckWhite(bs, 4, 0) == 'F' && inCheckWhite(bs, 5, 0) == 'F'){
                BoardStruct new_board = bs;
                new_board.board[4][0] = ' ';
                new_board.board[5][0] = 'R';
                new_board.board[6][0] = 'K';
                new_board.board[7][0] = ' ';
                addBoardToArray(boardsArr, new_board, num_moves);
            }
        }
    }
    if (bs.castlingRights[1] == 'Q' && bs.playerTurn == 'w'){
        if (bs.board[3][0] == ' ' && bs.board[2][0] == ' ' && bs.board[1][0] == ' ' && bs.board[4][0] == 'K'){
            if (inCheckWhite(bs, 4, 0) == 'F' && inCheckWhite(bs, 3, 0) == 'F'){
                BoardStruct new_board = bs;
                new_board.board[0][0] = ' ';
                new_board.board[2][0] = 'K';
                new_board.board[3][0] = 'R';
                new_board.board[4][0] = ' ';
                addBoardToArray(boardsArr, new_board, num_moves);
            }
        }
    }
    if (bs.castlingRights[2] == 'k' && bs.playerTurn == 'b'){
        if (bs.board[5][7] == ' ' && bs.board[6][7] == ' ' && bs.board[4][7] == 'k'){
            if (inCheckBlack(bs, 4, 7) == 'F' && inCheckBlack(bs, 5, 7) == 'F'){
                BoardStruct new_board = bs;
                new_board.board[4][7] = ' ';
                new_board.board[5][7] = 'r';
                new_board.board[6][7] = 'k';
                new_board.board[7][7] = ' ';
                addBoardToArray(boardsArr, new_board, num_moves);
            }
        }
    }
    if (bs.castlingRights[3] == 'q' && bs.playerTurn == 'b'){
        if (bs.board[3][7] == ' ' && bs.board[2][7] == ' ' && bs.board[1][7] == ' ' && bs.board[4][7] == 'k'){
            if (inCheckBlack(bs, 4, 7) == 'F' && inCheckBlack(bs, 3, 7) == 'F'){
                BoardStruct new_board = bs;
                new_board.board[0][7] = ' ';
                new_board.board[2][7] = 'k';
                new_board.board[3][7] = 'r';
                new_board.board[4][7] = ' ';
                addBoardToArray(boardsArr, new_board, num_moves);
            }
        }
    }

}




















