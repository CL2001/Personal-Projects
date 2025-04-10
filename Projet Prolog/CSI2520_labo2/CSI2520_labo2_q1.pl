flight(montreal, chicoutimi, 15:30, 16:15).
flight(montreal, sherbrooke, 17:10, 17:50).
flight(montreal, sudbury, 16:40, 18:45).
flight(northbay, kenora, 13:10, 14:40).
flight(ottawa, montreal, 12:20, 13:10).
flight(ottawa, northbay, 11:25, 12:20).
flight(ottawa, thunderbay, 19:00, 20:30).
flight(ottawa, toronto, 10:30, 11:30).
flight(sherbrooke, baiecomeau, 18:40, 20:05).
flight(sudbury, kenora, 20:15, 21:55).
flight(thunderbay, kenora, 20:00, 21:55).
flight(toronto, london, 13:15, 14:05).
flight(toronto, montreal, 12:45, 14:40).
flight(windsor, toronto, 8:50, 10:10).

on_time(H1 : _M1, D, A) :- flight(D, A, H2 : _M2, _H3 : _M3), H2 - H1 > 2.
on_time(H1 : M1, D, A) :- flight(D, A, H2 : M2, _H3 : _M3), H2 - H1 =:= 1, MM is 60 - M1, MM + M2 >= 60.

% ?- on_time(16:00, ottawa, thunderbay).
% ?- on_time(11:45, toronto, montreal).
% ?- on_time(12:20, toronto, london).
% ?- on_time(11:50, ottawa, montreal).

/*
1 ?- on_time(16:00, ottawa, thunderbay).   
true ;
false.

2 ?- on_time(11:45, toronto, montreal).
true ;
false.

3 ?- on_time(12:20, toronto, london).
false.

4 ?- on_time(11:50, ottawa, montreal).
false.
*/
