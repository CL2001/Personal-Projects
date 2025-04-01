--SELECT * FROM sailors S, reserves R, boats B;

/*
SELECT * FROM sailors S, reserves R, boats B
WHERE S.sid = R.sid AND R.bid = B.bid;


SELECT S.sname FROM Sailors S, Reserves R, Boats B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red' AND S.sid IN
(SELECT S2.sid FROM Sailors S2,Boats B2, Reserves R2 WHERE S2.sid
= R2.sid AND R2.bid = B2.bid AND B2.color = 'green' );
*/


SELECT S.rating, AVG(S.age) AS avgage, COUNT(*) numsailors
FROM Sailors S WHERE S.age >= 18 GROUP BY S.rating 