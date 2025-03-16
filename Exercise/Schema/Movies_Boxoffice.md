In this exercise, we are going to play studio executive and add a few movies to the Movies to our portfolio. In this table, the Id is an auto-incrementing integer, so you can try inserting a row with only the other columns defined.

Table: Movies
id | title        | director      | year | length_minutes
---|--------------|---------------|------|---------------
1  | Toy Story    | John Lasseter | 1995 | 81
2  | A Bug's Life | John Lasseter | 1998 | 95
3  | Toy Story 2  | John Lasseter | 1999 | 93

Table: Boxoffice
movie_id | rating | domestic_sales | international_sales
---------|--------|----------------|--------------------
3        | 7.92   | 45852179       | 239163000          
11       | 8.31   | 19179623       | 317016250          
2        | 7.21   | 62798565       | 200600000          

1. Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
```sql
INSERT INTO movies 
VALUES (4, "Toy Story 4", "El Directore", 2015, 90);
```
2. Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
```sql
INSERT INTO boxoffice 
VALUES(4, 8.7, 340000000, 270000000);
```
