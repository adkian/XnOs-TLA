-------------------------------- MODULE xnos --------------------------------
EXTENDS Integers
VARIABLES board, row1, row2, row3, curr

Init == /\ row1 = <<0,0,0>>
/\ row2 = <<0,0,0>>
/\ row3 = <<0,0,0>>
/\ curr = 1
/\ board = <<row1, row2, row3>>


Move(row, col, player) == 
/\ board[row][col] = 0
/\ curr = player
/\ IF row = 1 THEN 
        /\ row1' = [i \in 1..3 |-> IF i = col THEN player ELSE row1[i]]
        /\ UNCHANGED <<row2, row3>>
    ELSE IF row = 2 THEN 
        /\ row2' = [i \in 1..3 |-> IF i = col THEN player ELSE row2[i]]
        /\ UNCHANGED <<row1, row3>>
    ELSE 
        /\ row3' = [i \in 1..3 |-> IF i = col THEN player ELSE row3[i]]
        /\ UNCHANGED <<row1, row2>>
/\ IF player = 1 THEN curr' = 2 ELSE curr' = 1
/\ board' = <<row1, row2, row3>>

\* p1: 1, p2: 2
Next == \E row \in  1..3 : \E col \in 1..3:
    Move(row,col,1) \/ Move(row,col,2)
   
\* P1 or P2 victory invariants 
P1NotWinning == 
\/ \neg (\E i \in 1..3 : 
    \/ (board[1][i] = 1 /\ board[2][i] = 1 /\ board[3][i] = 1)
    \/ (board[i][1] = 1 /\ board[i][2] = 1 /\ board[i][3] = 1)
    )
\/ \neg (board[1][1] = 1 /\ board[2][2] = 1 /\ board[3][3] = 1) 
\/ \neg (board[1][3] = 1 /\ board[2][2] = 1 /\ board[3][3] = 1)
    
P2NotWinning ==
\/ \neg (\E i \in 1..3 : 
    \/ (board[1][i] = 2 /\ board[2][i] = 2 /\ board[3][i] = 2)
    \/ (board[i][1] = 2 /\ board[i][2] = 2 /\ board[i][3] = 2)
    )
\/ \neg (board[1][1] = 2 /\ board[2][2] = 2 /\ board[3][3] = 2) 
\/ \neg (board[1][3] = 2 /\ board[2][2] = 2 /\ board[3][3] = 2)
 

=============================================================================
\* Modification History
\* Last modified Fri Dec 08 19:10:45 EST 2017 by aditya
\* Created Thu Dec 07 21:45:57 EST 2017 by aditya
