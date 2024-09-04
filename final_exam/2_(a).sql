SELECT S1.name
FROM Student S1
INNER JOIN Friend ON S1.ID = Friend.ID1
INNER JOIN Student S2 ON S2.ID = Friend.ID2
WHERE S2.name = "Gabriel";
