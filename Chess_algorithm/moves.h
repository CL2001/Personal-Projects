#ifndef MOVES_H_INCLUDED
#define MOVES_H_INCLUDED
#include <pthread.h>

#include "board.h"

typedef struct {
    BoardNode *node;
    int depth;
    int *max_score;
    char maximizingPlayer;
    BoardNode *max_board_node;
    pthread_mutex_t *mutex;
} ThreadData;



char inCheckWhite(BoardStruct bs, int x, int y);
char inCheckBlack(BoardStruct bs, int x, int y);


void genLegalRecurs(BoardNode *board_node, int depth);

BoardStruct findBestMove(BoardStruct board_struct, int depth, int depth2);



#endif // MOVES_H_INCLUDED
