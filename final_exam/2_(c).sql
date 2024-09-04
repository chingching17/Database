SELECT S1.name, S1.grade
FROM Student S1
WHERE ID NOT IN (
  SELECT ID1
  FROM Friend, Student H2
  WHERE S1.ID = Friend.ID1 AND H2.ID = Friend.ID2 AND S1.grade <> H2.grade
)
ORDER BY S1.grade, S1.name;