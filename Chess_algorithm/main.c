#include <stdio.h>
#include <stdlib.h>

#include "board.h"
#include "pseudo_moves.h"
#include "moves.h"
#include "evalutation.h"



//Lire fichier
#include <unistd.h>
#include <string.h>


//TEMP
#include <time.h>
//

//Global final variables
char INIT_POSITION_FEN[] = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
char PLAYER_COLOR = 'w';
int DEPTH = 3;
int DEPTH2 = 4;

char testpos[] = "4kb1r/p2n1ppp/4q3/4p1B1/4P3/1Q6/PPP2PPP/2KR4 w k - 1 1";
//char testpos[] = "4kb1r/p2n1ppp/4q3/4p1B1/4P3/1Q6/PPP2PPP/2KR4 w k - 1 1";
//char testpos[] = "8/4KPq1/8/8/3k4/8/8/8 w - -";




int main()
{
    //*
    clock_t start, end;
    start = clock();
    //currentBoard = FenToBoard(INIT_POSITION_FEN, (sizeof(INIT_POSITION_FEN)/sizeof(INIT_POSITION_FEN[0])-1), PLAYER_COLOR);
    printf("Fen: %s\n", testpos);
    BoardNode root_node = FenToBoard(testpos, (sizeof(testpos)/sizeof(testpos[0])-1), PLAYER_COLOR);
    dispBoardStruct(root_node.board_struct, PLAYER_COLOR);



    BoardStruct best_move = findBestMove(root_node.board_struct, DEPTH, DEPTH2);

    printf("\nBest next position\n");
    dispBoardStruct(best_move, PLAYER_COLOR);



    printf("\nNum of evals made %d", num_of_evals);


    freeBoardNode(&root_node);




    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

    printf("\nTime taken: %f seconds\n", cpu_time_used);


    return 0;

}




























