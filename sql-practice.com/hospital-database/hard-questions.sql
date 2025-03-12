-- 1: Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending.For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

SELECT COUNT(*) as patients_in_group, 
FLOOR(weight / 10) * 10 as weight_group
FROM patients
GROUP BY  weight_group
ORDER BY weight_group DESC



-- 2: Show patient_id, weight, height, isObese FROM the patients table. 
-- Display isObese as a boolean 0 or 1.
-- Obese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg.
-- height is in units cm.


SELECT patient_id, weight, height, 
  CASE 
      WHEN weight / (POWER(height/100.0,2)) >= 30 THEN 1
      ELSE 0
      END AS isObese
FROM patients;


-- If you divide an int by an int you will get an int. Dividing an int by a float will return a float.
-- That's why you have to divide by 100.0 and not 100.
-- Use CAST(variable_name AS FLOAT) function if you are dividing by two variables.



-- 3: Show patient_id, first_name, last_name, and attending doctor's specialty.Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. Check patients, admissions, and doctors tables for required information.



SELECT p.patient_id, p.first_name as patient_first_name, p.last_name as patient_last_name, 
d.specialty as attending_doctor_specialty
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id
JOIN doctors d 
ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = "Epilepsy" and d.first_name = "Lisa";




-- 4: All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date



SELECT p.patient_id, CONCAT(p.patient_id, LENGTH(p.last_name), 
YEAR(birth_date)) AS temp_password
FROM patients p 
JOIN admissions a 
ON p.patient_id = a.patient_id
GROUP BY p.patient_id;



-- 5: Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.

-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT 
CASE
	WHEN patient_id % 2 = 0 THEN "Yes"
    Else "NO"
END AS has_insurance,
CASE 
	WHEN patient_id % 2 = 0 THEN COUNT(*) * 10
    Else COUNT(*) * 50
END AS cost_after_insurance
FROM admissions
GROUP BY has_insurance;




-- OR


SELECT 'No' AS has_insurance, count(*) * 50 AS cost
FROM admissions 
WHERE patient_id % 2 = 1 
GROUP BY has_insurance
UNION
SELECT 'Yes' AS has_insurance, count(*) * 10 AS cost
FROM admissions 
WHERE patient_id % 2 = 0 
GROUP BY has_insurance;



-- 4: Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name


SELECT pn.province_name
FROM province_names pn
JOIN patients p ON pn.province_id = p.province_id
GROUP BY pn.province_name
HAVING SUM(CASE WHEN p.gender = 'M' THEN 1 ELSE 0 END) > 
SUM(CASE WHEN p.gender = 'F' THEN 1 ELSE 0 END);


-- 5: We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:

-- First_name contains an 'r' after the first two letters.
-- Identifies their gender as 'F'
-- Born in February, May, or December
-- Their weight would be between 60kg and 80kg
-- Their patient_id is an odd number
-- They are FROM the city 'Kingston'


SELECT * 
FROM patients
WHERE first_name LIKE "__r%" 
AND 
gender = "F" 
AND 
MONTH(birth_date) IN (02, 05, 12) 
AND 
weight BETWEEN 60 AND 80 
AND 
patient_id % 2 != 0
AND 
city = "Kingston";



-- 6: Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT distinct
    CONCAT(ROUND(((SELECT COUNT(*) FROM patients WHERE gender = 'M') * 1.0 /
    (SELECT COUNT(*) FROM patients)) * 100, 2), "%")
FROM patients;


-- 7: For each day display the total amount of admissions on that day. Display the amount changed FROM the previous date.


SELECT
 admission_date,
 count(admission_date) as admission_day,
 count(admission_date) - LAG(count(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change 
FROM admissions
GROUP BY admission_date



 -- 8: Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.


SELECT province_name
FROM province_names
ORDER BY (case WHEN province_name = 'Ontario' THEN 0 ELSE 1 END), province_name;


SELECT province_name
FROM province_names
ORDER BY (NOT province_name = 'Ontario'), province_name;


SELECT province_name
FROM province_names
ORDER BY province_name = 'Ontario' DESC, province_name;


SELECT province_name
FROM province_names
ORDER BY
  CASE
    WHEN province_name = 'Ontario' THEN 1
    ELSE province_name
  END;


-- 9: We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.


SELECT d.doctor_id, concat(d.first_name, " ", d.last_name) AS doctor_name, d.specialty, 
YEAR(a.admission_date) AS selected_year, COUNT(*) AS total_admissions
FROM admissions a 
JOIN doctors d 
ON a.attending_doctor_id = d.doctor_id
GROUP BY d.doctor_id, selected_year;

