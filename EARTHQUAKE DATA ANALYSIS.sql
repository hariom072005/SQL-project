create database enviroment;
use enviroment;

#Handle missing values
SELECT * FROM earthquake_data_tsunami
WHERE magnitude IS NULL OR depth IS NULL;



#Count earthquakes
SELECT COUNT(*) FROM earthquake_data_tsunami ;

#Count tsunamis
SELECT COUNT(*) AS total_tsunamis
FROM earthquake_data_tsunami
WHERE tsunami = 1;

#AVG MAGNITUDE
SELECT AVG(magnitude) AS avg_magnitude FROM earthquake_data_tsunami;



#Categorize Earthquakes by Severity
SELECT *,
CASE
    WHEN magnitude >= 8 THEN 'Great'
    WHEN magnitude >= 7 THEN 'Major'
    WHEN magnitude >= 6 THEN 'Strong'
    ELSE 'Moderate or Below'
END AS magnitude_category
FROM earthquake_data_tsunami;

#TIME BASED ANAYLIS
SELECT Month, COUNT(*) AS total
FROM earthquake_data_tsunami
GROUP BY Month
ORDER BY Month;

#Tsunamis per month
SELECT Month, COUNT(*) AS tsunami_count
FROM earthquake_data_tsunami
WHERE tsunami = 1
GROUP BY Month;



#Average magnitude for tsunami vs non-tsunami
SELECT tsunami, AVG(magnitude) AS avg_magnitude
FROM earthquake_data_tsunami
GROUP BY tsunami;


#Probability of tsunami with high magnitude
SELECT 
    CASE WHEN magnitude >= 7 THEN 'High Mag' ELSE 'Low/Medium Mag' END AS mag_group,
    COUNT(*) AS total,
    SUM(tsunami) AS tsunami_count,
    (SUM(tsunami) * 100.0 / COUNT(*)) AS tsunami_percentage
FROM earthquake_data_tsunami
GROUP BY mag_group;




#Identify high-risk locations
SELECT latitude, longitude, COUNT(*) AS total_events
FROM earthquake_data_tsunami
GROUP BY latitude, longitude
ORDER BY total_events DESC
LIMIT 10;

#Top 5 strongest earthquakes
SELECT *
FROM earthquake_data_tsunami
ORDER BY magnitude DESC
LIMIT 5;

#Rank by significance
SELECT *,
RANK() OVER (ORDER BY sig DESC) AS rank_significance
FROM earthquake_data_tsunami;



