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