It looks like some of the information in our Movies database might be incorrect, so go ahead and fix them through the exercises below.

id | title               | director        | year | length_minutes
---|---------------------|-----------------|------|---------------
1  | Toy Story           | John Lasseter   | 1995 | 81
2  | A Bug's Life        | John Lasseter   | 1998 | 95
3  | Toy Story 2         | John Lasseter   | 1899 | 93  
4  | Monsters, Inc.     | Pete Docter     | 2001 | 92
5  | Finding Nemo        | Andrew Stanton  | 2003 | 107
6  | The Incredibles     | Brad Bird       | 2004 | 116
7  | Cars                | John Lasseter   | 2006 | 117
8  | Ratatouille         | Brad Bird       | 2007 | 115
9  | WALL-E              | Andrew Stanton  | 2008 | 104
10 | Up                  | Pete Docter     | 2009 | 101
11 | Toy Story 8         | El Directore    | 2010 | 103
12 | Cars 2              | John Lasseter   | 2011 | 120
13 | Brave               | Brenda Chapman  | 2012 | 102
14 | Monsters University | Dan Scanlon     | 2013 | 110

1. The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
```sql
UPDATE movies
SET director = "John Lasseter"
WHERE title = "A Bug's Life"
```
2. The year that Toy Story 2 was released is incorrect, it was actually released in 1999
```sql
UPDATE movies
SET year = 1999
WHERE title = "Toy Story 2"
```
3. Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
```sql
UPDATE movies
SET title = "Toy Story 3", director = "Lee Unkrich"
WHERE id = 11;
```
or
```sql
UPDATE movies
SET title = "Toy Story 3", director = "Lee Unkrich"
WHERE title = "Toy Story 8" OR director = "El Directore";
```
4. This database is getting too big, lets remove all movies that were released before 2005.
```sql
DELETE FROM movies
WHERE year < 2005
```
5. Andrew Stanton has also left the studio, so please remove all movies directed by him.
```sql
DELETE FROM movies
WHERE director = "Andrew Stanton"
```
6. Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
```sql
ALTER TABLE movies
ADD Aspect_ratio FLOAT 
```
7. Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
```sql
ALTER TABLE movies
ADD Language TEXT 
    DEFAULT English
```
