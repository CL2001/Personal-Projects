#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "board.h"
#include "pseudo_moves.h"
#include "moves.h"
#include "evalutation.h"








char inCheckWhite(BoardStruct bs, int x, int y)
{
    int minus_x = x-1;
    int plus_x = x+1;
    int minus_y = y-1;
    int plus_y = y+1;
    int minus_x2 = x-2;
    int plus_x2 = x+2;
    int minus_y2 = y-2;
    int plus_y2 = y+2;

    //check if Knight is producing check
    if (minus_x2 >= 0 && minus_y >= 0 && bs.board[minus_x2][minus_y] == 'n'){
        return 'T';
    }
    if (minus_x2 >= 0 && plus_y < 8 && bs.board[minus_x2][plus_y] == 'n'){
        return 'T';
    }
    if (minus_x >= 0 && minus_y2 >= 0 && bs.board[minus_x][minus_y2] == 'n'){
        return 'T';
    }
    if (minus_x >= 0 && plus_y2 < 8 && bs.board[minus_x][plus_y2] == 'n'){
        return 'T';
    }
    if (plus_x < 8 && minus_y2 >= 0 && bs.board[plus_x][minus_y2] == 'n'){
        return 'T';
    }
    if (plus_x < 8 && plus_y2 < 8 && bs.board[plus_x][plus_y2] == 'n'){
        return 'T';
    }
    if (plus_x2 < 8 && minus_y >= 0 && bs.board[plus_x2][minus_y] == 'n'){
        return 'T';
    }
    if (plus_x2 < 8 && plus_y < 8 && bs.board[plus_x2][plus_y] == 'n'){
        return 'T';
    }

    //Check diagonal (pawn, king, queen, bishop)
    int new_x = x+1;
    int new_y = y+1;
    if (new_x < 8 && new_y < 8 && (bs.board[new_x][new_y] == 'p' || bs.board[new_x][new_y] == 'k')) {
        return 'T';
    }
    while (new_x < 8 && new_y < 8){
        if (bs.board[new_x][new_y] == 'b' || bs.board[new_x][new_y] == 'q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x++;
        new_y++;
    }
    new_x = x-1;
    new_y = y+1;
    if (new_x >= 0 && new_y < 8 && (bs.board[new_x][new_y] == 'p' || bs.board[new_x][new_y] == 'k')) {
        return 'T';
    }
    while (new_x >= 0 && new_y < 8){
        if (bs.board[new_x][new_y] == 'b' || bs.board[new_x][new_y] == 'q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x--;
        new_y++;
    }
    new_x = x-1;
    new_y = y-1;
    if (new_x >= 0 && new_y >= 0 && bs.board[new_x][new_y] == 'k') {
        return 'T';
    }
    while (new_x >= 0 && new_y >= 0){
        if (bs.board[new_x][new_y] == 'b' || bs.board[new_x][new_y] == 'q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x--;
        new_y--;
    }
    new_x = x+1;
    new_y = y-1;
    if (new_x < 8 && new_y >= 0 && bs.board[new_x][new_y] == 'k') {
        return 'T';
    }
    while (new_x < 8 && new_y >= 0){
        if (bs.board[new_x][new_y] == 'b' || bs.board[new_x][new_y] == 'q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x++;
        new_y--;
    }
    //check straight lines (rook, queen, king)
    new_x = x+1;
    if (new_x < 8 && bs.board[new_x][y] == 'k') {
        return 'T';
    }
    while (new_x < 8){
        if (bs.board[new_x][y] == 'r' || bs.board[new_x][y] == 'q'){
            return 'T';
        } else if (bs.board[new_x][y] != ' '){
            break;
        }
        new_x++;
    }
    new_x = x-1;
    if (new_x >= 0 && bs.board[new_x][y] == 'k') {
        return 'T';
    }
    while (new_x >= 0){
        if (bs.board[new_x][y] == 'r' || bs.board[new_x][y] == 'q'){
            return 'T';
        } else if (bs.board[new_x][y] != ' '){
            break;
        }
        new_x--;
    }
    new_y = y+1;
    if (new_y < 8 && bs.board[x][new_y] == 'k') {
        return 'T';
    }
    while (new_y < 8){
        if (bs.board[x][new_y] == 'r' || bs.board[x][new_y] == 'q'){
            return 'T';
        } else if (bs.board[x][new_y] != ' '){
            break;
        }
        new_y++;
    }
    new_y = y-1;
    if (new_y >= 0 && bs.board[x][new_y] == 'k') {
        return 'T';
    }
    while (new_y >= 0){
        if (bs.board[x][new_y] == 'r' || bs.board[x][new_y] == 'q'){
            return 'T';
        } else if (bs.board[x][new_y] != ' '){
            break;
        }
        new_y--;
    }
    return 'F';
}

char inCheckBlack(BoardStruct bs, int x, int y)
{
    int minus_x = x-1;
    int plus_x = x+1;
    int minus_y = y-1;
    int plus_y = y+1;
    int minus_x2 = x-2;
    int plus_x2 = x+2;
    int minus_y2 = y-2;
    int plus_y2 = y+2;

    //check if Knight is producing check
    if (minus_x2 >= 0 && minus_y >= 0 && bs.board[minus_x2][minus_y] == 'N'){
        return 'T';
    }
    if (minus_x2 >= 0 && plus_y < 8 && bs.board[minus_x2][plus_y] == 'N'){
        return 'T';
    }
    if (minus_x >= 0 && minus_y2 >= 0 && bs.board[minus_x][minus_y2] == 'N'){
        return 'T';
    }
    if (minus_x >= 0 && plus_y2 < 8 && bs.board[minus_x][plus_y2] == 'N'){
        return 'T';
    }
    if (plus_x < 8 && minus_y2 >= 0 && bs.board[plus_x][minus_y2] == 'N'){
        return 'T';
    }
    if (plus_x < 8 && plus_y2 < 8 && bs.board[plus_x][plus_y2] == 'N'){
        return 'T';
    }
    if (plus_x2 < 8 && minus_y >= 0 && bs.board[plus_x2][minus_y] == 'N'){
        return 'T';
    }
    if (plus_x2 < 8 && plus_y < 8 && bs.board[plus_x2][plus_y] == 'N'){
        return 'T';
    }

    //Check diagonal (pawn, king, queen, bishop)
    int new_x = x+1;
    int new_y = y+1;
    if (new_x < 8 && new_y < 8 && bs.board[new_x][new_y] == 'K') {
        return 'T';
    }
    while (new_x < 8 && new_y < 8){
        if (bs.board[new_x][new_y] == 'B' || bs.board[new_x][new_y] == 'Q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x++;
        new_y++;
    }
    new_x = x-1;
    new_y = y+1;
    if (new_x >= 0 && new_y < 8 && bs.board[new_x][new_y] == 'K') {
        return 'T';
    }
    while (new_x >= 0 && new_y < 8){
        if (bs.board[new_x][new_y] == 'B' || bs.board[new_x][new_y] == 'Q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x--;
        new_y++;
    }
    new_x = x-1;
    new_y = y-1;
    if (new_x >= 0 && new_y >= 0 && (bs.board[new_x][new_y] == 'P' || bs.board[new_x][new_y] == 'K')){
        return 'T';
    }
    while (new_x >= 0 && new_y >= 0){
        if (bs.board[new_x][new_y] == 'B' || bs.board[new_x][new_y] == 'Q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x--;
        new_y--;
    }
    new_x = x+1;
    new_y = y-1;
    if (new_x < 8 && new_y >= 0 && (bs.board[new_x][new_y] == 'P' || bs.board[new_x][new_y] == 'K')){
        return 'T';
    }
    while (new_x < 8 && new_y >= 0){
        if (bs.board[new_x][new_y] == 'B' || bs.board[new_x][new_y] == 'Q'){
            return 'T';
        } else if (bs.board[new_x][new_y] != ' '){
            break;
        }
        new_x++;
        new_y--;
    }
    //check straight lines (rook, queen, king)
    new_x = x+1;
    if (new_x < 8 && bs.board[new_x][y] == 'K') {
        return 'T';
    }
    while (new_x < 8){
        if (bs.board[new_x][y] == 'R' || bs.board[new_x][y] == 'Q'){
            return 'T';
        } else if (bs.board[new_x][y] != ' '){
            break;
        }
        new_x++;
    }
    new_x = x-1;
    if (new_x >= 0 && bs.board[new_x][y] == 'K') {
        return 'T';
    }
    while (new_x >= 0){
        if (bs.board[new_x][y] == 'R' || bs.board[new_x][y] == 'Q'){
            return 'T';
        } else if (bs.board[new_x][y] != ' '){
            break;
        }
        new_x--;
    }
    new_y = y+1;
    if (new_y < 8 && bs.board[x][new_y] == 'K') {
        return 'T';
    }
    while (new_y < 8){
        if (bs.board[x][new_y] == 'R' || bs.board[x][new_y] == 'Q'){
            return 'T';
        } else if (bs.board[x][new_y] != ' '){
            break;
        }
        new_y++;
    }
    new_y = y-1;
    if (new_y >= 0 && bs.board[x][new_y] == 'K') {
        return 'T';
    }
    while (new_y >= 0){
        if (bs.board[x][new_y] == 'R' || bs.board[x][new_y] == 'Q'){
            return 'T';
        } else if (bs.board[x][new_y] != ' '){
            break;
        }
        new_y--;
    }
    return 'F';
}


BoardStruct finalizeBoard(BoardStruct board)
{
    if (board.playerTurn == 'w'){
        board.playerTurn = 'b';
    } else {
        board.playerTurn = 'w';
    }
    if (board.castlingRights[0] == 'K'){
        if (!(board.board[4][0] == 'K' && board.board[7][0] == 'R')){
            board.castlingRights[0] = '-';
        }
    }
    if (board.castlingRights[1] == 'Q'){
        if (!(board.board[4][0] == 'K' && board.board[0][0] == 'R')){
            board.castlingRights[1] = '-';
        }
    }
    if (board.castlingRights[2] == 'k'){
        if (!(board.board[4][7] == 'k' && board.board[7][7] == 'r')){
            board.castlingRights[2] = '-';
        }
    }
    if (board.castlingRights[3] == 'q'){
        if (!(board.board[4][7] == 'k' && board.board[0][7] == 'r')){
            board.castlingRights[3] = '-';
        }
    }
    return board;
}


void genLegal(BoardNode *board_node)
{
    BoardStruct *pseudoLegalBoardsArr = NULL;
    int num_moves_pseudo = 0;
    genPseudoLegal(board_node->board_struct, &pseudoLegalBoardsArr, &num_moves_pseudo);

    for (int i = 0; i < num_moves_pseudo; i++){
        char inCheck;
        if (pseudoLegalBoardsArr[i].playerTurn == 'w'){
            int x = -1;
            int y = -1;
            for (int j = 0; j < 8; j++) {
                for (int k = 0; k < 8; k++) {
                    if (pseudoLegalBoardsArr[i].board[j][k] == 'K'){
                        x = j;
                        y = k;
                        break;
                    }
                }
            }
            inCheck = inCheckWhite(pseudoLegalBoardsArr[i], x, y);
        } else {
            int x = -1;
            int y = -1;
            for (int j = 0; j < 8; j++) {
                for (int k = 0; k < 8; k++) {
                    if (pseudoLegalBoardsArr[i].board[j][k] == 'k'){
                        x = j;
                        y = k;
                        break;
                    }
                }
            }
            inCheck = inCheckBlack(pseudoLegalBoardsArr[i], x, y);
        }
        if (inCheck == 'F'){
            BoardNode *new_board_node = (BoardNode *)malloc(sizeof(BoardNode));
            if (new_board_node == NULL){
                printf("Memory allocation failed\n");
                exit(1);
            }
            board_node->next_board_num++;
            board_node->next_boards_arr = realloc(board_node->next_boards_arr, board_node->next_board_num * sizeof(BoardNode *));
            if (board_node->next_boards_arr == NULL){
                printf("Memory allocation failed\n");
                exit(1);
            }
            BoardStruct new_board = finalizeBoard(pseudoLegalBoardsArr[i]);
            new_board_node->board_struct = new_board;
            new_board_node->next_boards_arr = NULL;
            new_board_node->next_board_num = 0;
            board_node->next_boards_arr[board_node->next_board_num - 1] = new_board_node;
        }
    }
    free(pseudoLegalBoardsArr);
}


void genLegalRecurs(BoardNode *board_node, int depth)
{
    if (depth <= 0){
        return;
    }

    genLegal(board_node);


    for (int i = 0; i < board_node->next_board_num; i++){
        genLegalRecurs(board_node->next_boards_arr[i], depth - 1);
    }
    return;
}

double bestThreeMoves(BoardStruct *original_struct, int depth, BoardStruct *topBoard1, BoardStruct *topBoard2, BoardStruct *topBoard3)
{
    double topScore1, topScore2, topScore3;
    if (original_struct->playerTurn == 'w'){
        topScore1 = -100000;
        topScore2 = -100000;
        topScore3 = -100000;
    } else {
        topScore1 = 100000;
        topScore2 = 100000;
        topScore3 = 100000;
    }
    BoardNode node;
    node.board_struct = *original_struct;
    node.next_boards_arr = NULL;
    node.next_board_num = 0;
    genLegal(&node);

    for (int i = 0; i < node.next_board_num; i++) {
        genLegalRecurs(node.next_boards_arr[i], depth-1);
        double temp_score = minimax(node.next_boards_arr[i], -1000000, 1000000, node.next_boards_arr[i]->board_struct.playerTurn, depth-1);
        if ((original_struct->playerTurn == 'w' && temp_score > topScore1) || (original_struct->playerTurn == 'b' && temp_score < topScore1)){
            topScore3 = topScore2;
            topScore2 = topScore1;
            topScore1 = temp_score;
            *topBoard3 = *topBoard2;
            *topBoard2 = *topBoard1;
            *topBoard1 = node.next_boards_arr[i]->board_struct;
        } else if ((original_struct->playerTurn == 'w' && temp_score > topScore2) || (original_struct->playerTurn == 'b' && temp_score < topScore2)){
            topScore3 = topScore2;
            topScore2 = temp_score;
            *topBoard3 = *topBoard2;
            *topBoard2 = node.next_boards_arr[i]->board_struct;
        }  else if ((original_struct->playerTurn == 'w' && temp_score > topScore3) || (original_struct->playerTurn == 'b' && temp_score < topScore3)){
            topScore3 = temp_score;
            *topBoard3 = node.next_boards_arr[i]->board_struct;
        }
    }
    if (node.next_board_num == 2){
        topScore3 = topScore2;
        *topBoard3 = *topBoard2;
    } else if (node.next_board_num == 1){
        topScore3 = topScore2;
        topScore2 = topScore1;

        *topBoard3 = *topBoard2;
        *topBoard2 = *topBoard1;
    }
    freeBoardNode(&node);

    return topScore1;

}


double findBestMoveRecurs(BoardStruct *original_struct, int depth, int depth2) //use a board struct pointer so there is less memory issues
{
    BoardStruct topBoard1, topBoard2, topBoard3;
    double topScore = bestThreeMoves(original_struct, depth, &topBoard1, &topBoard2, &topBoard3);

    if (depth2 <= 0){
        return topScore;
    }
    printf(" "); //do not delete for now, if not the program crashes
    double score1 = findBestMoveRecurs(&topBoard1, depth, depth2-1);
    double score2 = findBestMoveRecurs(&topBoard2, depth, depth2-1);
    double score3 = findBestMoveRecurs(&topBoard3, depth, depth2-1);



    if (original_struct->playerTurn == 'w'){
        if (score1 >= score2 && score1 >= score3){
            return score1;
        } else if (score2 >= score3){
            return score2;
        } else {
            return score3;
        }
    } else {
        if (score1 <= score2 && score1 <= score3){
            return score1;
        } else if (score2 <= score3){
            return score2;
        } else {
            return score3;
        }
    }
}

BoardStruct findBestMove(BoardStruct root_board, int depth, int depth2)
{
    BoardStruct topBoard1, topBoard2, topBoard3;
    bestThreeMoves(&root_board, depth, &topBoard1, &topBoard2, &topBoard3);

    double score1 = findBestMoveRecurs(&topBoard1, depth, depth2-1);
    double score2 = findBestMoveRecurs(&topBoard2, depth, depth2-1);
    double score3 = findBestMoveRecurs(&topBoard3, depth, depth2-1);


    if (root_board.playerTurn == 'w'){
        if (score1 >= score2 && score1 >= score3){
            return topBoard1;
        } else if (score2 >= score3){
            return topBoard2;
        } else {
            return topBoard3;
        }
    } else {
        if (score1 <= score2 && score1 <= score3){
            return topBoard1;
        } else if (score2 <= score3){
            return topBoard2;
        } else {
            return topBoard3;
        }
    }
}




































