#include <stdio.h>
#include <stdlib.h>
#include "board.h"
#include "pseudo_moves.h"
#include "moves.h"
#include "evalutation.h"





double evaluateBoard(BoardNode board_node)
{

    double score = 0;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {

            char piece = board_node.board_struct.board[i][j];


            if (piece == ' '){
                continue;
            }
            // White pieces
            else if (piece == 'P') {
                score += 1 + i/100.0 + j/200.0;
            } else if (piece == 'N') {
                score += 3 + i/100.0 + j/200.0;
            } else if (piece == 'B') {
                score += 3.2 + i/100.0 + j/200.0;
            } else if (piece == 'R') {
                score += 5 + i/100.0 + j/200.0;
            } else if (piece == 'Q') {
                score += 9 + i/100.0 + j/200.0;
            }

            // Black pieces
            else if (piece == 'p') {
                score -= 1 - i/100.0 + j/200.0;
            } else if (piece == 'n') {
                score -= 3 - i/100.0 + j/200.0;
            } else if (piece == 'b') {
                score -= 3.2 - i/100.0 + j/200.0;
            } else if (piece == 'r') {
                score -= 5 - i/100.0 + j/200.0;
            } else if (piece == 'q') {
                score -= 9 - i/100.0 + j/200.0;
            }
        }
    }

    return score;
}


double minimax(BoardNode *board_node, double alpha, double beta, char maximizingPlayer, int depth) {
    if (board_node->next_board_num == 0 && depth == 0) {
        return evaluateBoard(*board_node);
    } else if (board_node->next_board_num == 0 && depth > 0) {
        return 10000.22;
    }
    if (maximizingPlayer == 'w') {
        double maxEval = -1000000;
        for (int i = 0; i < board_node->next_board_num; i++) {
            double eval = minimax(board_node->next_boards_arr[i], alpha, beta, 'b', depth-1);
            maxEval = maxEval > eval ? maxEval : eval;
            alpha = alpha > eval ? alpha : eval;
            if (beta <= alpha) {
                break;
            }
        }
        return maxEval;
    } else {
        double minEval = 1000000;
        for (int i = 0; i < board_node->next_board_num; i++) {
            double eval = minimax(board_node->next_boards_arr[i], alpha, beta, 'w', depth-1);
            minEval = minEval < eval ? minEval : eval;
            beta = beta < eval ? beta : eval;
            if (beta <= alpha) {
                break;
            }
        }
        return minEval;
    }
}































