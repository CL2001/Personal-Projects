% player(ID, Name, Rating).
player(1, magnus_carlsen, 2853).
player(2, hikaru_nakamura, 2789).
player(3, fabiano_caruana, 2803).
player(4, ian_nepomniachtchi, 2775).
player(5, ding_liren, 2816).
player(6, alireza_firouzja, 2761).
player(7, wesley_so, 2757).

% game(GameID, PlayerID, OpponentID, Result, Date).
game(101, 1, 2, win, date(2024, 2, 10)).  % Magnus Carlsen vs Hikaru Nakamura
game(102, 2, 1, loss, date(2024, 2, 10)). % Hikaru Nakamura vs Magnus Carlsen

game(103, 3, 4, win, date(2024, 2, 15)).  % Fabiano Caruana vs Ian Nepomniachtchi
game(104, 4, 3, loss, date(2024, 2, 15)). % Ian Nepomniachtchi vs Fabiano Caruana

game(105, 5, 1, loss, date(2024, 3, 1)).  % Ding Liren vs Magnus Carlsen
game(106, 1, 5, win, date(2024, 3, 1)).   % Magnus Carlsen vs Ding Liren

game(107, 2, 3, win, date(2024, 3, 5)).  % Hikaru Nakamura vs Fabiano Caruana
game(108, 3, 2, loss, date(2024, 3, 5)). % Fabiano Caruana vs Hikaru Nakamura

game(109, 4, 5, win, date(2024, 3, 12)).  % Ian Nepomniachtchi vs Ding Liren
game(110, 5, 4, loss, date(2024, 3, 12)). % Ding Liren vs Ian Nepomniachtchi

game(111, 1, 3, draw, date(2024, 3, 20)). % Magnus Carlsen vs Fabiano Caruana
game(112, 3, 1, draw, date(2024, 3, 20)). % Fabiano Caruana vs Magnus Carlsen

game(113, 6, 7, win, date(2024, 3, 25)).  % Alireza Firouzja vs Wesley So
game(114, 7, 6, loss, date(2024, 3, 25)). % Wesley So vs Alireza Firouzja

game(115, 6, 1, loss, date(2024, 3, 28)). % Alireza Firouzja vs Magnus Carlsen
game(116, 1, 6, win, date(2024, 3, 28)).  % Magnus Carlsen vs Alireza Firouzja

game(117, 2, 4, win, date(2024, 4, 1)).  % Hikaru Nakamura vs Ian Nepomniachtchi
game(118, 4, 2, loss, date(2024, 4, 1)). % Ian Nepomniachtchi vs Hikaru Nakamura

game(119, 5, 7, win, date(2024, 4, 5)).  % Ding Liren vs Wesley So
game(120, 7, 5, loss, date(2024, 4, 5)). % Wesley So vs Ding Liren

game(121, 3, 6, win, date(2024, 4, 10)).  % Fabiano Caruana vs Alireza Firouzja
game(122, 6, 3, loss, date(2024, 4, 10)). % Alireza Firouzja vs Fabiano Caruana

game(123, 7, 1, draw, date(2024, 4, 15)). % Wesley So vs Magnus Carlsen
game(124, 1, 7, draw, date(2024, 4, 15)). % Magnus Carlsen vs Wesley So


%Q2 a)
games(Name, Wins, Draws, Losses) :-
    player(PlayerID, Name, _),  
    findall(GameID, (game(GameID, PlayerID, _, win, _)), Wins),
    findall(GameID, (game(GameID, PlayerID, _, draw, _)), Draws),
    findall(GameID, (game(GameID, PlayerID, _, loss, _)), Losses).

%Q2 b)
surprise-victory(Year, List) :- 
    findall(GameID, (
        game(GameID, Player1ID, Player2ID, win, date(Year, _, _)),
        player(Player1ID, _, Player1Rating), 
        player(Player2ID, _, Player2Rating),
        Player1Rating < Player2Rating), 
    List).



%Q2 c)
before(date(Year, _, _), date(RefYear, _, _)) :- Year < RefYear.
before(date(Year, Month, _), date(RefYear, RefMonth, _)) :- Year == RefYear, Month < RefMonth. 
before(date(Year, Month, Day), date(RefYear, RefMonth, RefDay)) :- Year == RefYear, Month == RefMonth, Day < RefDay. 

after(date(Year, _, _), date(RefYear, _, _)) :- Year > RefYear.
after(date(Year, Month, _), date(RefYear, RefMonth, _)) :- Year == RefYear, Month > RefMonth. 
after(date(Year, Month, Day), date(RefYear, RefMonth, RefDay)) :- Year == RefYear, Month == RefMonth, Day > RefDay.

gamesc(DateFirst, DateLast, List) :- 
    findall(game(GameID, PlayerID, OpponentID, Result, Date), 
        (game(GameID, PlayerID, OpponentID, Result, Date), 
        before(Date, DateLast),
        after(Date, DateFirst)),
    List).

/*
1 ?- games(magnus_carlsen, Win, Draw, Lost).
Win = [101, 106, 116],
Draw = [111, 124],
Lost = [].

2 ?- surprise-victory(2024,L).
L = [107, 109].

3 ?- gamesc(date(2024,3,20),date(2024,4,10),L).
L = [game(113, 6, 7, win, date(2024, 3, 25)), game(114, 7, 6, loss, date(2024, 3, 25)), game(115, 6, 1, loss, date(2024, 3, 28)), game(116, 1, 6, win, date(2024, 3, 28)), game(117, 2, 4, win, date(2024, 4, 1)), game(118, 4, 2, loss, date(2024, 4, 1)), game(119, 5, 7, win, date(2024, 4, 5)), game(120, 7, 5, loss, date(..., ..., ...))].
*/