We've added a new table to the Pixar database so that you can try practicing some joins. The BoxOffice table stores information about the ratings and sales of each particular Pixar movie, and the Movie_id column in that table corresponds with the Id column in the Movies table 1-to-1. Try and solve the tasks below using the INNER JOIN introduced above.
```
| id  | title               | director        | year | length_minutes |
|-----|---------------------|-----------------|------|----------------|
| 1   | Toy Story           | John Lasseter   | 1995 | 81             |
| 2   | A Bug's Life        | John Lasseter   | 1998 | 95             |
| 3   | Toy Story 2         | John Lasseter   | 1999 | 93             |
| 4   | Monsters, Inc.     | Pete Docter     | 2001 | 92             |
| 5   | Finding Nemo        | Andrew Stanton  | 2003 | 107            |
| 6   | The Incredibles     | Brad Bird       | 2004 | 116            |
| 7   | Cars                | John Lasseter   | 2006 | 117            |
| 8   | Ratatouille         | Brad Bird       | 2007 | 115            |
| 9   | WALL-E              | Andrew Stanton  | 2008 | 104            |
| 10  | Up                  | Pete Docter     | 2009 | 101            |
| 11  | Toy Story 3         | Lee Unkrich     | 2010 | 103            |
| 12  | Cars 2              | John Lasseter   | 2011 | 120            |
| 13  | Brave               | Brenda Chapman  | 2012 | 102            |
| 14  | Monsters University | Dan Scanlon     | 2013 | 110            |
```
```
movie_id | rating | domestic_sales | international_sales
---------|--------|----------------|--------------------
5        | 8.23   | 80843261       | 155590000          
14       | 7.42   | 68492764       | 475066843          
8        | 8.82   | 64456544       | 172771641          
2        | 6.41   | 91452396       | 368400000          
3        | 7.92   | 45852179       | 239163000          
6        | 8.26   | 14410923       | 70001000           
9        | 8.52   | 23808164       | 297503696          
11       | 8.44   | 15004880       | 648167031          
11       | 8.31   | 19179623       | 317016250          
3        | 7.22   | 44082982       | 217900167          
10       | 8.32   | 93004164       | 443833858          
4        | 8.12   | 89916256       | 272900000          
2        | 7.21   | 62798565       | 200600000          
13       | 7.22   | 37283207       | 301700000          
```

1. Find the domestic and international sales for each movie 
```sql
SELECT title, domestic_sales, international_sales 
FROM movies
    INNER JOIN boxoffice 
    ON id = movie_id
```
2. Show the sales numbers for each movie that did better internationally rather than domestically
```sql
SELECT title, domestic_sales, international_sales 
FROM movies
    INNER JOIN boxoffice 
    ON id = movie_id
WHERE international_sales > domestic_sales
```
3. List all the movies by their ratings in descending order
```sql
SELECT title, rating 
FROM movies
    INNER JOIN boxoffice 
    ON id = movie_id
ORDER BY rating DESC
```
4. List all movies and their combined sales in millions of dollars
```sql
SELECT title, (domestic_sales + international_sales)/ 1000000 
FROM movies
    INNER JOIN boxoffice
    ON id = movie_id
```
5. List all movies and their ratings in percent
```sql
SELECT title, rating * 10 AS rating_percent
FROM movies
    JOIN boxoffice
    ON movies.id = boxoffice.movie_id;
```
6. List all movies that were released on even number years
```sql
SELECT title, year
FROM movies
    JOIN boxoffice
    ON movies.id = boxoffice.movie_id
WHERE year % 2 = 0
```