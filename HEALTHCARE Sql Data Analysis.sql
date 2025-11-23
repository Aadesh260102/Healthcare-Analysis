create database healthcare;
use healthcare;
show  tables;
select * from doctor;
select * from `lab result`;
select * from treatments;
Select * from visit;
select * from patients;

-- *************************************************************************************
--                         " 1. TOTAL NUMBERS OF DOCTOR"
-- ************************************************************************************* 
select * from  doctor;
SELECT COUNT(*) AS total_doctors
FROM doctor;
-- ********************************************************************************
--                          "2.TOTAL PATIENTS"
-- *********************************************************************************
select * from  patients;
SELECT COUNT(*) AS TOTAL_PATIENTS
FROM patients;
-- *************************************************************************************
--                          "3.TOTAL VISIT AND VISIT TYPE "
-- *************************************************************************************
SELECT COUNT(*) AS Total_Visits
FROM `visit`;
SELECT `Visit type`, COUNT(*) AS Total_Visits
FROM `visit`
GROUP BY `Visit type`;
-- ****************************************************************************************
--                            "4.AVERAGE AGE OS PATIENTS"
-- ****************************************************************************************
SELECT ROUND(AVG(`Age`), 2) AS Average_Age
FROM patients;
-- ****************************************************************************************
--                            "5.TOP 5 DIAGNOSED CONDITION"
-- ****************************************************************************************
 SELECT Diagnosis, COUNT(*) AS Total_Patients
FROM visit
WHERE Diagnosis IS NOT NULL
  AND Diagnosis<> 'None'
GROUP BY Diagnosis
ORDER BY Total_Patients DESC
limit 5;
-- *****************************************************************************************
--                            "6.FOLLOW UP RATE" 
-- *****************************************************************************************
SELECT
    ROUND(SUM(CASE WHEN `Follow Up Required` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Yes_Percentage,
    ROUND(SUM(CASE WHEN `Follow Up Required` = 'No' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS No_Percentage
FROM `visit`;
-- *******************************************************************************************
--                           "7.TREATEMENT COST PER VISIT"
-- *******************************************************************************************
SELECT 
    ROUND(AVG(total_cost), 2) AS Avg_Treatment_Cost_Per_Visit
FROM (
    SELECT 
        `Visit ID` AS visit_id,
        SUM( COALESCE(`Treatment Cost`, `Cost`, 0) ) AS total_cost
    FROM `treatments`
    GROUP BY `Visit ID`
) AS visit_costs;
-- **********************************************************************************
--                       "8.TOTAL LAB CONDUCTED"
-- **********************************************************************************
select * from `lab result`;
SELECT 
    `Test name`,
    COUNT(*) AS total_tests_conducted
FROM `lab result`
GROUP BY `Test name`
ORDER BY total_tests_conducted asc;

-- *******************************************************************************************
--                "9.PERCENTAGE OF ABNORMAL LAB RESULT"
-- *******************************************************************************************
SELECT 
    (COUNT(CASE WHEN `Test Result` = 'Abnormal' THEN 1 END) * 100.0 / COUNT(*)) AS Abnormal_Result_Percentage
FROM `lab result`;
-- *********************************************************************************************
--                           "10.DOCTOR WORKLOAD"
-- *********************************************************************************************
SELECT 
    AVG(Patient_Count) AS Avg_Patients_Per_Doctor
FROM (
    SELECT 
        `doctor id`,
        COUNT(DISTINCT `patient id`) AS Patient_Count
    FROM visit
    GROUP BY `doctor id`
) AS DoctorWorkload;

-- **********************************************************************************************
--                                "11.TOP 5 CHRONIC CONDITIONS"
-- **********************************************************************************************
 SELECT ChronicConditions, COUNT(*) AS Total_Patients
FROM patients
WHERE ChronicConditions IS NOT NULL
  AND ChronicConditions <> 'None'
GROUP BY ChronicConditions
ORDER BY Total_Patients DESC
limit 5;
-- **********************************************************************************************
--                     "12.STATEWISE NUMBER OF PATIENTS"
-- ***********************************************************************************************
SELECT State, COUNT(PatientID) AS Number_Patients
FROM patients
GROUP BY State;
-- ************************************************************************************************
--                      "13.GENDER WISE TOTAL PPATIENTS"
-- ************************************************************************************************
select gender, count(patientid) as Total_Patient from patients
group by gender;
-- ************************************************************************************************
--                          "14.TOP MEDICATION PRESCRIBED"
-- ************************************************************************************************
select `medication Prescribed`, count(`medication Prescribed`) as "Number of Medicine" from treatments
group by `medication Prescribed`;

