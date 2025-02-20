-- 1 (REPEAT) Show unique birth years from patients and order them by ascending.


SELECT DISTINCT YEAR(birth_date) as birth_year 
FROM patients
ORDER BY birth_date ASC;


-- 2 (REPEAT): Show unique first names from the patients table which only occurs once in the list. For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.


SELECT first_name 
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;


-- 3: Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.


SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE "S%s" and LENGTH(first_name) >= 6;


-- 4: Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.


SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
WHERE a.diagnosis = "Dementia";


-- 5: Display every patient's first_name. Order the list by the length of each name and then by alphabetically.


SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name ASC;


-- 6 (REPEAT): Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.


SELECT DISTINCT
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count
FROM patients;


-- OR 

SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients;


-- You can use SUM(gender = 'M') in this way, and it is a valid and efficient approach in SQL. This works because SQL treats boolean expressions (like gender = 'M') as 1 for TRUE and 0 for FALSE. The SUM function then adds up these 1s and 0s, effectively counting the number of rows where the condition is true.



-- OR


SELECT 
  sum(CASE WHEN gender = 'M' THEN 1 END) as male_count,
  sum(CASE WHEN gender = 'F' THEN 1 END) as female_count 
FROM patients;



-- 7: Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.



SELECT first_name, last_name, allergies
FROM patients
WHERE allergies IN ("Penicillin", "Morphine")
ORDER BY allergies, first_name, last_name;



-- OR


SELECT first_name, last_name, allergies
FROM patients
WHERE allergies = 'Penicillin' OR allergies = 'Morphine'
ORDER BY allergies ASC, first_name ASC, last_name ASC;


-- 8 (REPEAT): Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;


-- 9: Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.


SELECT city, COUNT(patient_id)
FROM patients
GROUP BY city
ORDER BY COUNT(patient_id) DESC, city ASC;


-- 10: Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"


SELECT first_name, last_name, "Patient" as role
FROM patients
UNION ALL
SELECT first_name, last_name, "Doctor" as role 
FROM doctors;


-- 11: Show all allergies ordered by popularity. Remove NULL values from query.


SELECT allergies, COUNT(allergies) as total_diagnosis 
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY COUNT(allergies) DESC;


-- 12 (REPEAT): Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.


SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date between "1970-01-01" and "1970-12-31"
ORDER BY birth_date ASC;



-- OR 


SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;


-- OR 


SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date >= '1970-01-01' AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;


-- OR


SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) LIKE '197%'
ORDER BY birth_date ASC;


-- 13: We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order. EX: SMITH,jane


SELECT CONCAT(UPPER(last_name), ",", LOWER(first_name)) AS new_name_format
FROM patients
ORDER BY first_name DESC;



-- OR 


SELECT UPPER(last_name) || ',' || LOWER(first_name) AS new_name_format
FROM patients
ORDER BY first_name DESC;



-- 14: Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.



SELECT province_id, SUM(height)
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;


-- OR


SELECT * 
FROM (SELECT province_id, SUM(height) AS sum_height FROM patients GROUP BY province_id) 
WHERE sum_height >= 7000;


-- 15: Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'



SELECT (MAX(weight) - MIN(weight)) as weight_delta
FROM patients
WHERE last_name = "Maroni";


-- 16: Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.


SELECT DAY(admission_date) as day_number, COUNT(*) as number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC;


-- 17: Show all columns for patient_id 542's most recent admission_date.


SELECT *
FROM admissions
WHERE patient_id = 542 
AND
admission_date = (SELECT MAX(admission_date) FROM admissions WHERE patient_id = 542);


-- 18: Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:


-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.


SELECT patient_id, attending_doctor_id, diagnosis
FROM admissions
WHERE 
(patient_id % 2 != 0 and attending_doctor_id IN (1, 5, 19))
OR 
(attending_doctor_id LIKE "%2%" and LENGTH(patient_id) = 3);


-- 19: Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.


SELECT d.first_name, d.last_name, COUNT(*) as admissions_total
FROM admissions a
JOIN doctors d
ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id;



-- 20: For each doctor, display their id, full name, and the first and last admission date they attended.


SELECT d.doctor_id, CONCAT(d.first_name, " ", d.last_name) AS full_name,
MIN(a.admission_date) AS first_admission_date, 
Max(a.admission_date) AS last_admission_date
FROM doctors d
JOIN admissions a
ON d.doctor_id = a.attending_doctor_id
GROUP BY d.doctor_id;



-- 21: Display the total amount of patients for each province. Order by descending.


SELECT pn.province_name, COUNT(*) as patient_count
FROM patients p
JOIN province_names pn
ON p.province_id = pn.province_id
GROUP BY pn.province_name
ORDER BY patient_count DESC;


-- 22: For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.


SELECT CONCAT(p.first_name, " ", p.last_name) as patient_name,
a.diagnosis, CONCAT(d.first_name, " ", d.last_name) as doctor_name
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
JOIN doctors d
ON a.attending_doctor_id = d.doctor_id;


-- 23 (REPEAT): display the first name, last name and number of duplicate patients based on their first name and last name.
-- Ex: A patient with an identical name can be considered a duplicate.


SELECT first_name, last_name, COUNT(*) AS num_of_duplicates
FROM patients
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;



-- 24: Display patient's full name, height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated. Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205.


SELECT CONCAT(first_name, " ", last_name) AS patient_name,
ROUND(height / 30.48, 1) as 'height "Feet"',
ROUND(weight * 2.205, 0) as 'weight "Pounds"',
birth_date,
CASE
	When gender = "M" Then "MALE"
  ELSE "FEMALE"
END as gender_type
FROM patients;


-- 25: Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)


SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
LEFT JOIN admissions a
ON p.patient_id = a.patient_id
WHERE a.patient_id IS NULL;


-- OR


SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
WHERE p.patient_id NOT IN (
    SELECT a.patient_id
    FROM admissions a
  )



-- 26 (REPEAT): Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places.


SELECT MAX(number_of_visits) AS max_visits, 
	MIN(number_of_visits) AS min_visits, 
  ROUND(AVG(number_of_visits), 2) AS average_visits 
FROM (
  SELECT admission_date, COUNT(*) AS number_of_visits
  FROM admissions 
  GROUP BY admission_date
)