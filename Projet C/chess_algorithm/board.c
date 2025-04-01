#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#include "board.h"
#include "pseudo_moves.h"
#include "moves.h"
#include "evalutation.h"



void printBoardWhitePerspective(char (*board)[8])
{
    for (int i = 0; i < 8; i++){
        printf("---------------------------------\n");
        printf("| %c | %c | %c | %c | %c | %c | %c | %c | %d\n", board[0][7-i], board[1][7-i], board[2][7-i],
               board[3][7-i], board[4][7-i], board[5][7-i], board[6][7-i], board[7][7-i], 8-i);
    }
    printf("---------------------------------\n");
    printf("  a   b   c   d   e   f   g   h\n");
}

void printBoardBlackPerspective(char (*board)[8])
{
    for (int i = 0; i < 8; i++){
        printf("---------------------------------\n");
        printf("| %c | %c | %c | %c | %c | %c | %c | %c | %d\n", board[7][i], board[6][i], board[5][i], board[4][i],
               board[3][i], board[2][i], board[1][i], board[0][i], i+1);
    }
    printf("---------------------------------\n");
    printf("  h   g   f   e   d   c   b   a\n");
}

void dispBoardStruct(BoardStruct board_struct, char player_color)
{
    if (player_color == 'w'){
        printBoardWhitePerspective(board_struct.board);
    } else {
        printBoardBlackPerspective(board_struct.board);
    }
    printf("PlayerTurn: %c\n", board_struct.playerTurn);
    printf("CastlingRights: %c%c%c%c\n", board_struct.castlingRights[0], board_struct.castlingRights[1],
            board_struct.castlingRights[2], board_struct.castlingRights[3]);
    printf("EnPassantSquare: [%d][%d]\n", board_struct.enPassant[0], board_struct.enPassant[1]);
}

BoardNode FenToBoard(char position_FEN[], int position_FEN_length, char player_color)
{
    BoardNode board_node;
    char tempBoard[8][8];
    int row = 7;
    int column = 0;
    int i = 0;
    while (position_FEN[i] != ' '){
        if (position_FEN[i] >= '1' && position_FEN[i] <= '8'){
            int num = position_FEN[i] - '0';
            for (int j = 0; j < num; j++) {
                tempBoard[row][column] = ' ';
                column++;
            }
        } else if (position_FEN[i] == '/'){
            row--;
            column = 0;
        } else {
            tempBoard[row][column] = position_FEN[i];
            column++;
        }
        i++;
    }
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            board_node.board_struct.board[i][j] = tempBoard[j][i];
        }
    }


    int spaceCounter = 0;
    int spaceIndexArray[4];
    spaceIndexArray[3] = position_FEN_length;
    for (int i = 0; i < position_FEN_length; i++){
        if (position_FEN[i] == ' '){
            spaceIndexArray[spaceCounter] = i;
            spaceCounter++;
        }
    }
    board_node.board_struct.playerTurn = position_FEN[spaceIndexArray[0] + 1];

    for (int i = 0; i < 4; i++){
        board_node.board_struct.castlingRights[i] = '-';
    }

    for (int i = 0; i < spaceIndexArray[2] - spaceIndexArray[1] - 1; i++){
        if (position_FEN[i + spaceIndexArray[1] + 1] == 'K'){
            board_node.board_struct.castlingRights[0] = 'K';
        }
        if (position_FEN[i + spaceIndexArray[1] + 1] == 'Q'){
            board_node.board_struct.castlingRights[1] = 'Q';
        }
        if (position_FEN[i + spaceIndexArray[1] + 1] == 'k'){
            board_node.board_struct.castlingRights[2] = 'k';
        }
        if (position_FEN[i + spaceIndexArray[1] + 1] == 'q'){
            board_node.board_struct.castlingRights[3] = 'q';
        }
    }

    int enPassantFenlen = spaceIndexArray[3] - spaceIndexArray[2] - 1;
    if (enPassantFenlen == 1){
        board_node.board_struct.enPassant[0] = -1;
        board_node.board_struct.enPassant[1] = -1;
    } else {
        board_node.board_struct.enPassant[0] = position_FEN[spaceIndexArray[2] + 1] - 'a';
        board_node.board_struct.enPassant[1] = position_FEN[spaceIndexArray[2] + 2] - '1';
    }


    board_node.next_boards_arr = NULL;
    board_node.next_board_num = 0;

    return board_node;
}



void freeBoardNode(BoardNode *board_node) {
    if (board_node->next_boards_arr == NULL) {
        return;
    }
    for (int i = 0; i < board_node->next_board_num; i++) {
        freeBoardNode(board_node->next_boards_arr[i]);
        free(board_node->next_boards_arr[i]);
    }

    free(board_node->next_boards_arr);
}


































