--CREATE DATABASE
CREATE DATABASE Podcast_Analysis 


--CREATE TABLE
CREATE TABLE podcast_analysis
(
episode_id INT PRIMARY KEY,
episode_title VARCHAR(50),
guest_name VARCHAR(50),
guest_profession VARCHAR(50),	
category VARCHAR(50),	
release_date DATE,
duration_minutes INT,
views INT,	
likes INT,
comments INT
);



--DATA EXPLORATION
SELECT * FROM podcast_analysis
LIMIT 10;

SELECT COUNT(*) FROM podcast_analysis;



--DATA  CLEANING 
SELECT * FROM podcast_analysis
WHERE episode_id IS NULL 
OR
episode_title IS NULL 
OR
guest_name IS NULL 
OR
guest_profession IS NULL 
OR
category IS NULL 
OR
release_date IS NULL 
OR
duration_minutes IS NULL 
OR
views IS NULL 
OR
likes IS NULL 
OR
comments IS NULL;



DELETE  FROM podcast_analysis
WHERE episode_id IS NULL 
OR
episode_title IS NULL 
OR
guest_name IS NULL 
OR
guest_profession IS NULL 
OR
category IS NULL 
OR
release_date IS NULL 
OR
duration_minutes IS NULL 
OR
views IS NULL 
OR
likes IS NULL 
OR
comments IS NULL;




-- QUESTIONS & ANSWERS

-----------------------Episode Analysis-------------------------------
--1. How many podcast episodes are there?
SELECT COUNT(*) AS total_episodes
FROM podcast_analysis;


--2. How many unique guests have appeared?
SELECT COUNT(DISTINCT(guest_name)) AS unique_guests 
FROM podcast_analysis;


--3. List all episodes with their release dates.
SELECT episode_id, episode_title, release_date
FROM podcast_analysis
ORDER BY release_date DESC;


--4. Find the longest podcast episode.
SELECT * FROM podcast_analysis
WHERE duration_minutes = (SELECT MAX(duration_minutes) FROM podcast_analysis)
LIMIT 1;


--5. Find the shortest podcast episode.
SELECT * FROM podcast_analysis 
WHERE duration_minutes = (SELECT MIN(duration_minutes) FROM podcast_analysis)
LIMIT 1;


--6. Show the top 10 most-viewed episodes.
SELECT * FROM podcast_analysis
ORDER BY views DESC
LIMIT 10;


--7. Show the bottom 10 least-viewed episodes.
SELECT * FROM podcast_analysis
ORDER BY views
LIMIT 10;


--8. Find episodes longer than 120 minutes.
SELECT * FROM podcast_analysis
WHERE duration_minutes > 120;


--9. Count the number of episodes released each year.
SELECT EXTRACT(YEAR FROM release_date) AS YEAR, COUNT(*) as total_episodes
FROM podcast_analysis
GROUP BY YEAR
ORDER BY YEAR;


--10. Count the number of episodes released each month.
SELECT TO_CHAR (release_date, 'MONTH') AS month_name, COUNT(*) AS total_episodes
FROM podcast_analysis
GROUP BY month_name
ORDER BY MIN(EXTRACT(MONTH FROM release_date));





-------------------------Guest Analysis-----------------------------
--11. List all unique guests.
SELECT DISTINCT(guest_name) AS unique_guest
FROM podcast_analysis


--12. Count how many times each guest appeared.
SELECT guest_name, COUNT(*) AS appearence_time
FROM podcast_analysis
GROUP BY guest_name;


--13. Find guests who appeared more than once.
SELECT guest_name, COUNT(*) AS appearence_time
FROM podcast_analysis
GROUP BY guest_name
HAVING COUNT(*) > 1;


--14. Show the top 10 guests by total views.
SELECT guest_name, SUM(views) AS total_views
FROM podcast_analysis
GROUP BY guest_name
ORDER BY total_views DESC
LIMIT 10;


--15. Find the guest with the highest average views.
SELECT guest_name,
AVG(views) AS average_views
FROM podcast_analysis
GROUP BY guest_name 
ORDER BY average_views DESC
LIMIT 1;






------------------------Category Analysis----------------------------
--16. Count episodes in each category.
SELECT category, COUNT(*) AS total_episodes
FROM podcast_analysis
GROUP BY category;


--17. Find the category with the most episodes.
SELECT category, COUNT(*) AS total_episodes
FROM podcast_analysis
GROUP BY category
ORDER BY total_episodes DESC
LIMIT 1;


--18. Calculate the average views for each category.
SELECT category, ROUND(AVG(views), 2) AS average_views
FROM podcast_analysis
GROUP BY category
ORDER BY average_views DESC;


--19. Calculate the average episode duration by category.
SELECT category, AVG(duration_minutes) AS average_duration
FROM podcast_analysis
GROUP BY category
ORDER BY average_duration DESC;


--20. Find the category with the highest total likes.
SELECT category, SUM(likes) AS total_likes
FROM podcast_analysis
GROUP BY category
ORDER BY total_likes DESC
LIMIT 1;






---------------------Engagement Analysis----------------------------
--21. Find the total views of all episodes.
SELECT SUM(views) AS total_views 
FROM podcast_analysis;


--22. Find the average views per episode.
SELECT  AVG(views) AS average_views
FROM podcast_analysis;


--23. Find the average likes per episode.
SELECT AVG(likes) AS average_likes
FROM podcast_analysis;


--24. Find the average comments per episode.
SELECT AVG(comments) AS average_comments
FROM podcast_analysis;


--25. Show episodes with more than 1 million views.
SELECT * FROM podcast_analysis
WHERE views > 1000000;


--26. Show episodes with fewer than 100,000 views.
SELECT * FROM podcast_analysis
WHERE views < 100000;


--27. Find the episode with the highest number of likes.
SELECT * FROM podcast_analysis
WHERE likes = (SELECT MAX(likes) FROM podcast_analysis);

OR

SELECT * FROM podcast_analysis
ORDER BY likes DESC
LIMIT 1;


--28. Find the episode with the highest number of comments.
SELECT * FROM podcast_analysis
ORDER BY comments DESC
LIMIT 1;

OR

SELECT * FROM podcast_analysis
WHERE comments = (SELECT MAX(comments) FROM podcast_analysis);






--------------------DATE & Time Based Analysis---------------------
--29. How many episodes were released in 2020?
SELECT COUNT(*) AS total_episodes
FROM podcast_analysis
WHERE EXTRACT(YEAR FROM release_date) = '2020';

OR

SELECT COUNT(*) AS total_episodes
FROM podcast_analysis
WHERE release_date BETWEEN '2020-01-01' AND '2020-12-31';


--30. How many episodes were released in 2021?
SELECT COUNT (*) AS total_episodes
FROM podcast_analysis
WHERE EXTRACT(YEAR FROM release_date) = '2021';


--31. Which year had the highest number of episodes?
SELECT EXTRACT(YEAR FROM release_date) AS YEAR, COUNT(*) AS total_episodes
FROM podcast_analysis
GROUP BY EXTRACT(YEAR FROM release_date)
ORDER BY total_episodes DESC;


--32. Find the average views by year.
SELECT EXTRACT(YEAR FROM release_date) AS YEAR, ROUND(AVG(views), 2) AS average_views
FROM podcast_analysis
GROUP BY EXTRACT(YEAR FROM release_date)
ORDER BY YEAR;


--33. Find the total likes by year.
SELECT EXTRACT(YEAR FROM release_date) AS YEAR, SUM(likes) AS total_likes
FROM podcast_analysis
GROUP BY EXTRACT(YEAR FROM release_date)
ORDER BY total_likes DESC;


--34. Find the day of the week on which the most episodes were released.
SELECT TO_CHAR(release_date, 'Day') AS Day, COUNT(*) AS total_episodes 
FROM podcast_analysis
GROUP BY TO_CHAR(release_date, 'Day')
ORDER BY total_episodes DESC
LIMIT 1;


--35. Which month has the highest average views?
SELECT TO_CHAR(release_date, 'Month') AS Month,
AVG(views) AS average_views
FROM podcast_analysis 
GROUP BY TO_CHAR(release_date, 'Month')
ORDER BY average_views DESC
LIMIT 1;


--36. Which year had the highest engagement rate?
SELECT EXTRACT(YEAR FROM release_date) AS year, 
ROUND(AVG((likes + comments) * 100.0 / views), 3) AS engagement_rate
FROM podcast_analysis
GROUP BY YEAR 
ORDER BY engagement_rate DESC
LIMIT 1;


--37. Find the first and latest episode of each guest.
SELECT guest_name,
MAX(release_date) AS First_episode,
MIN(release_date) AS Latest_episode
FROM podcast_analysis
GROUP BY guest_name
ORDER BY guest_name;


--38. Calculate the gap in days between consecutive episodes.
WITH episode_gap AS (SELECT episode_id,
					 release_date,
					 LAG(release_date) OVER(ORDER BY release_date) AS privious_date
					 FROM podcast_analysis)

SELECT *, 
release_date - privious_date AS gap_days
FROM episode_gap;





------------------Business Intelligence & Reporting Analysis------------------------
--39. Which guest brings the most audience?
SELECT guest_name, SUM(views) AS total_views
FROM podcast_analysis
GROUP BY guest_name
ORDER BY total_views DESC
LIMIT 1;


--40. Which category performs the best?
SELECT category, SUM(views) AS total_views
FROM podcast_analysis
GROUP BY category
ORDER BY total_views DESC
LIMIT 1;


--41. Are longer podcasts getting more views?
SELECT 
	  CASE
	  	  WHEN duration_minutes < 60 THEN 'Short'
		  WHEN duration_minutes BETWEEN 60 AND 120 THEN 'Medium'
		  ELSE 'Long'
	  END AS podcast_length,
	  ROUND(AVG(views), 2) AS avg_views
FROM podcast_analysis
GROUP BY podcast_length;


--42. Which year had the highest audience engagement?
SELECT EXTRACT(YEAR FROM release_date) AS Year, SUM(likes + comments) AS total_engagement
FROM podcast_analysis
GROUP BY Year 
ORDER BY total_engagement DESC
LIMIT 1;


--43. Which guest should Raj invite again based on views?
SELECT guest_name, SUM(views) AS total_views
FROM podcast_analysis
GROUP BY guest_name
ORDER BY total_views DESC
LIMIT 1;

--Raj should invite 'Ankur Warikoo' sir again, because his podcast got the highest views.


--44. Which category should Raj focus on for future episodes?
SELECT category, SUM(views) AS total_views
FROM podcast_analysis
GROUP BY category
ORDER BY total_views DESC
LIMIT 1;

--Raj should focus on the 'Motivation' category for future episodes because it has the highest total views, 
--indicating the strongest audience interest.

--45. Which episodes performed poorly and might need better promotion?
SELECT * FROM podcast_analysis 
WHERE views < (SELECT (AVG(views)) FROM podcast_analysis);


--46. Display the latest 10 episodes.
SELECT * FROM podcast_analysis
ORDER BY release_date DESC
LIMIT 10;


--47. Find episodes where views are greater than the average.
SELECT * FROM podcast_analysis
WHERE views > (SELECT AVG(views) FROM podcast_analysis);

 
--48. Count the number of episodes in each profession.
SELECT guest_profession, COUNT(*) AS total_episodes
FROM podcast_analysis
GROUP BY guest_profession;


--49. Find episodes released between two dates.
--I'll assume the date range is from 2023-01-01 to 2023-12-31.
SELECT * FROM podcast_analysis
WHERE release_date BETWEEN '2023-01-01' AND '2023-12-31';


--50. Calculate the total engagement (likes + comments) for each episode.
SELECT episode_id, episode_title, likes, comments,  
(likes + comments) AS total_engagement
FROM podcast_analysis
ORDER BY total_engagement DESC;



-------------------------End of Project-------------------------









