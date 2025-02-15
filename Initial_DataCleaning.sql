﻿/*
DATA CLEANING
SHOWCASE: JOIN'S, STRING FUNCTIONS, SUBQUERIES, TABLE ALTERATIONS
*/





---------------------------------------------------------------------------
------ 2018
---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title, Movie_Adaptation_Seen      
FROM		booklists.books_2018
WHERE		Book_Author = 'John Green' AND Movie_Adaptation_Seen IS NOT NULL


----- «The Fault In Our Stars» | ‹In› SHOULD BE WRITTEN IN LOWERCASE.

SELECT		CHARINDEX(Movie_Adaptation_Seen, ' (2014)') AS Position       
FROM		booklists.books_2018
WHERE		Book_Author = 'John Green'


----- ALTERNATIVE: INSTR().

UPDATE		booklists.books_2018
SET		Book_Title = SUBSTRING(Movie_Adaptation_Seen, 1, 23), Original_Title = Book_Title
WHERE		Book_Author = 'John Green' AND Movie_Adaptation_Seen IS NOT NULL 





---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, STRING_SPLIT(Book_Genre, ', ') AS Genre_Spectrum, Book_Theme
FROM		booklists.books_2018


UPDATE		booklists.books_2018 
SET		Book_Genre = CONCAT_WS(', ', Book_Genre, 'Psychological')
WHERE		Book_Title = 'Der Zahir'


/*
UPDATE		booklists.books_2018`
SET		Book_Genre = CONCAT(Book_Genre, ', Psychological')
WHERE		Book_Title = 'Der Zahir'
*/





---------------------------------------------------------------------------


SELECT		Book_Title, Alternative_Title    
FROM		booklists.books_2018
WHERE		Book_Title IN ('A Christmas Carol', 'Peter Pan') 


----- [Alternative_Title] OF «Peter Pan» IS IN AN INCORRECT ROW.

UPDATE		booklists.books_2018
SET		Alternative_Title = (SELECT Alternative_Title FROM booklists.books_2018 WHERE Book_Title LIKE '%Carol')
WHERE		Book_Title LIKE '%Pan'





---------------------------------------------------------------------------
----- 2019
---------------------------------------------------------------------------


SELECT		Book_Title, Book_Author, Author_From, Author_Ethnicity
FROM		booklists.books_2019
WHERE		Author_From LIKE 'United%' AND Author_From NOT LIKE '%Kingdom'
ORDER BY	Author_From


UPDATE		booklists.books_2019
SET		Author_From = 'United States'
WHERE		Book_Author IN ('Alice Walker', 'Tiffany Haddish')





---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title     
FROM		booklists.books_2019
WHERE		Book_Author = 'Haruki Murakami'


----- «After The Quake» | ‹The› SHOULD BE WRITTEN IN LOWERCASE.

UPDATE		booklists.books_2019
SET		Book_Title = CONCAT('After ', LOWER(SUBSTRING(Book_Title, 7, 3)), ' Quake'),
		Alternative_Title = CONCAT(Book_Title, ': Stories')
WHERE		Book_Author = 'Haruki Murakami'





---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title
FROM		booklists.books_2019
WHERE		Book_Author = 'J. K. Rowling'
ORDER BY	Book_Title


----- «The Tales of Beedle The Bard» | ‹The› SHOULD BE WRITTEN IN LOWERCASE.

SELECT		Book_Author, Book_Title
FROM		booklists.books_2019	
WHERE		Book_Author = 'J. K. Rowling' AND Book_Title NOT LIKE 'Harry Potter%'


UPDATE		booklists.books_2019
SET		Book_Title = REPLACE(Book_Title, SUBSTRING(Book_Title, -8, 5))
WHERE		Book_Author ='J. K. Rowling' AND Book_Title NOT LIKE 'Harry Potter%'





---------------------------------------------------------------------------


UPDATE		booklists.books_2019	
SET		Book_Genre = CONCAT_WS(', ', Book_Genre, 'Fantasy', 'Mythology'), 
		Book_Theme = CONCAT_WS('; ',Book_Theme, '"Metamorphoses"'),
		Original_Title = Alternative_Title
WHERE		Book_Title LIKE '%Psyche'




---------------------------------------------------------------------------
------ 2020
---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title
FROM		booklists.books_2020
WHERE		Reading_Order IN (23, 25)
ORDER BY	Reading_Order


----- «The Seven Spiritual Law of Success», «One Hundred Year of Solitude»‹Year› AND ‹Law› SHOULD BE WRITTEN IN PLURAL.

UPDATE		booklists.books_2020
SET		Book_Title = REPLACE(Book_Title, 'Law', 'Laws'), Original_Title = Book_Title
WHERE		Book_Title LIKE '%Law%'


UPDATE		booklists.books_2020 
SET		Book_Title = 'One Hundred Years of Solitude'
WHERE		Reading_Order = 25





---------------------------------------------------------------------------


SELECT		Book_Title, Original_Title
FROM		booklists.books_2020
WHERE		Original_Title LIKE 'Call Me%' OR Book_Title LIKE '%Deathly%'


----- «Call Me By Your Name», «(…) and the Deathly Hollows» | ‹By› SHOULD BE WRITTEN IN LOWERCASE. ‹Hallows› IS SPELLED INCORRECTLY.

UPDATE		booklists.books_2020
SET		Original_Title = REPLACE(Original_Title, 'By', 'by'), Book_Title = Original_Title 
WHERE		Original_Title LIKE 'Call Me%'


UPDATE		booklists.books_2020
SET		Book_Title = REPLACE(Book_Title, 'Ho', 'Ha'), Original_Title = Book_Title
WHERE		Book_Title LIKE '%Deathly%'





---------------------------------------------------------------------------


SELECT		LENGTH('Crime') AS First_Half, LENGTH(', Thriller') AS Second_Half 


UPDATE		booklists.books_2020
SET		Book_Genre = CONCAT(SUBSTRING(Book_Genre, 1, 5), ', ', Book_Theme, SUBSTRING(Book_Genre, 6, 10))
WHERE		Book_Title = 'Inferno'





---------------------------------------------------------------------------
----- 2021
--------------------------------------------------------------------------- 


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title
FROM		booklists.books_2021
WHERE		Book_Title LIKE 'Stillness%' OR Book_Title LIKE '%Crawdads%' OR Book_Title LIKE 'Turtles%'


----- «Stillness Is The Key», «Where The Crawdads Sing», «Turtles All The Way Down» | ‹The› SHOULD BE WRITTEN IN LOWERCASE.

SELECT		REPLACE(Book_Title, 'The', 'the') AS Corrected_Titles
FROM		booklists.books_2021
WHERE		Book_Title LIKE 'Stillness%' OR Book_Title LIKE '%Crawdads%' OR Book_Title LIKE 'Turtles%'


UPDATE		booklists.books_2021
SET		Book_Title = 'Stillness Is the Key', Original_Title = 'Stillness Is the Key'
WHERE		Book_Title LIKE 'Stillness%' 


UPDATE		booklists.books_2021
SET		Book_Title = 'Where the Crawdads Sing', Original_Title = 'Where the Crawdads Sing'
WHERE		Book_Title LIKE '%Crawdads%'


UPDATE		booklists.books_2021
SET		Book_Title = 'Turtles All the Way Down', Original_Title = 'Turtles All the Way Down'
WHERE		Book_Title LIKE 'Turtles%' 





---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title
FROM		booklists.books_2021
WHERE		Book_Title LIKE '%Duke%' OR Book_Title LIKE '%Zombies' 


----- «Pride And Prejudice And Zombies», «The Duke And I» | ‹And› SHOULD BE WRITTEN IN LOWERCASE.

UPDATE		booklists.books_2021 
SET		Book_Title = Original_Title   
WHERE		Book_Title LIKE '%Duke%'


UPDATE		booklists.books_2021 
SET		Original_Title = REPLACE(Original_Title, 'And', 'and'), Book_Title = Original_Title 
WHERE		Original_Title LIKE '%Zombies' 


UPDATE		booklists.books_2021
SET		Book_Type = CONCAT_WS(', ', SUBSTRING(Book_Type, 1, 7), 'Parody Novel', 'Retelling'),
		Book_Theme = 'English Family, Romance, Zombies; "Pride and Prejudice"'
WHERE		Book_Title LIKE '%Zombies'





---------------------------------------------------------------------------


UPDATE		booklists.books_2021
SET		Book_Genre = CONCAT_WS(', ', Book_Type, 'Murder Mystery'),
		Book_Theme = 'American Family, Coming-of-Age, Nature; North Carolina (1952-1970)'
WHERE		Book_Title = 'Where the Crawdads Sing'


UPDATE		booklists.books_2021
SET		Book_Genre = CONCAT_WS(', ', 'Historical', Book_Type),
		Book_Theme = 'Biology, Botany, Family Dynamic, Spirituality, Womanhood; Amsterdam, Philadelphia, Tahiti (1800-1880)'
WHERE		Book_Title = 'The Signature of All Things'


UPDATE		booklists.books_2021
SET		Book_Genre = CONCAT_WS(', ', Book_Genre, 'Fantasy', 'Speculative Fiction'),
		Book_Theme = 'Suppression of Women''s Reproductive Rights, Totalitarian Society'
WHERE		Book_Title = 'The Handmaid''s Tale'


UPDATE		booklists.books_2021
SET		Book_Theme = CONCAT('Asian Americans, ', Book_Theme, ', Identity, Social Class; Atlanta (1800s)')
WHERE		Book_Title LIKE '%Downstairs%'


UPDATE		booklists.books_2021
SET		Book_Genre = SUBSTRING(Book_Genre, 1, 12), Book_Theme = CONCAT_WS(', ', Book_Theme, 'Survivalist Mormon Family')
WHERE		Book_Title = 'Educated'


UPDATE		booklists.books_2021
SET		Book_Type = 'Novel, Retelling', Book_Genre = 'Fantasy, Historical, Mythology'
WHERE		Book_Author = 'Madeline Miller'


UPDATE		booklists.books_2021
SET		Book_Theme = 'Greek Mythology; "Iliad"'
WHERE		Book_Title LIKE '%Achilles'


UPDATE		booklists.books_2021
SET		Book_Theme = 'Greek Mythology; "Odyssey"'
WHERE		Book_Title = 'Circe'





---------------------------------------------------------------------------
----- 2022
---------------------------------------------------------------------------


INSERT INTO booklists.books_2022
		(Reading_Year, Reading_Order, Book_Author, Book_Title,
		 Page_Counts, Author_Gender, Author_From, Author_Ethnicity,  
		 Alternative_Title, Original_Title, Fiction, Non_Fiction,
		 Book_Type, Book_Genre, Book_Theme, 
		 Reading_Language, Original_Language, Reading_Book_Format)
VALUES		(2022, 18, 'Kate Northrup', 'Money, A Love Story',
		 237, 'F', 'United States', 'Caucasian, North American, White',
		 'Money, A Love Story: Untangle Your Financial Woes and Create the Life You Really Want',
		 'Money, A Love Story', FALSE, TRUE,
		 'Esoteric Book', 'Personal Growth, Self-Help', 'Finance Management',
		 'English', 'English', 'Kindle Book')





---------------------------------------------------------------------------


SELECT		CHARINDEX(Author_Ethnicity, 'S')
FROM		booklists.books_2022
WHERE		Book_Title LIKE '%Tiger%' OR Book_Title LIKE '%Ghost%'


----- LEADING SPACE.

UPDATE		booklists.books_2022
SET		Author_Ethnicity = TRIM(Author_Ethnicity)
WHERE		Book_Title LIKE '%Tiger%' OR Book_Title LIKE '%Ghost%'





---------------------------------------------------------------------------


UPDATE		booklists.books_2022
SET		Book_Type = CONCAT_WS(', ', Book_Type, 'Retelling'), 
		Book_Genre = CONCAT_WS(', ', 'Fantasy', Book_Genre),
		Book_Theme = CONCAT_WS(', ', Book_Theme, ' War Story; "Iliad"')
WHERE		Book_Title = 'The Silence of the Girls'


UPDATE		booklists.books_2022
SET		Book_Genre = CONCAT_WS(', ', Book_Genre, 'Mystery', 'Young Adult')
WHERE		Book_Title IN ('The Night Tiger', 'The Ghost Bride')


UPDATE		booklists.books_2022
SET		Book_Theme = CONCAT_WS(', ', 'Colonialism', Book_Theme, 'Superstition; British Malaya (1931)')
WHERE		Book_Title = 'The Night Tiger'


UPDATE		booklists.books_2022
SET		Book_Theme = CONCAT('Afterlife, Colonialism, ', Book_Theme, '; British Malaya (1890s)')
WHERE		Book_Title = 'The Ghost Bride'





---------------------------------------------------------------------------


SELECT		Reading_Order, Book_Author, Book_Title, Alternative_Title, Original_Title
FROM		booklists.books_2022
WHERE		Book_Author = 'Julia Quinn'
ORDER BY	Reading_Order


---- {Alternative_Title} IS MISSING THE WORD ‹Book›. «(…) Book 5» AND «(…) Book 6» NEED TO BE SWAPPED.

UPDATE		booklists.books_2022
SET		Alternative_Title = 'Bridgerton, Book 5'
WHERE		Book_Author = 'Julia Quinn' AND Reading_Order = 2


UPDATE		booklists.books_2022
SET		Alternative_Title = 'Bridgerton, Book 6'
WHERE		Book_Author = 'Julia Quinn' AND Reading_Order = 5


UPDATE		booklists.books_2022
SET		Alternative_Title = 'Bridgerton, Book 7'
WHERE		Book_Author = 'Julia Quinn' AND Alternative_Title LIKE '%7'





---------------------------------------------------------------------------
---- YEARS UNKNOWN
---------------------------------------------------------------------------


SELECT		Book_Author, Book_Title, Alternative_Title, Original_Title
FROM		booklists.books_years_unknown
WHERE		Book_Author = 'Jane Austen'


----- «Pride And Prejudice», «Sense And Sensibility» | ‹And› SHOULD BE WRITTEN IN LOWERCASE.

UPDATE		booklists.books_years_unknown
SET		Book_Title = 'Sense and Sensibility', Original_Title = 'Sense and Sensibility'
WHERE		Book_Author = 'Jane Austen' AND Book_Title LIKE 'Sense%'


UPDATE		booklists.books_years_unknown
SET		Alternative_Title = 'Pride and Prejudice', Original_Title = 'Pride and Prejudice'
WHERE		Book_Author = 'Jane Austen' AND Book_Title LIKE 'Stolz%'





---------------------------------------------------------------------------


SELECT		Y19.Book_Series, Y19.Book_Genre Genre_Spectrum, YUK.Book_Genre YUK
FROM		booklists.books_2019 Y19
JOIN		booklists.books_years_unknown YUK
ON		Y19.Book_Series = YUK.Book_Series
WHERE		Y19.Book_Series = 'Robert Langdon' OR YUK.Book_Series = 'Robert Langdon'


----- [Book_Genre] OF THE SAME [Book_Series] ARE NOT IN SYNC.

UPDATE		booklists.books_years_unknown
SET		Book_Genre = (SELECT Book_Genre FROM booklists.books_2019 WHERE Book_Series = 'Robert Langdon'),
		Book_Theme = 'Holy Grail; Paris, France'  
WHERE		Book_Series = Robert Langdon





