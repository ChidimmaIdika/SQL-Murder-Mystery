# SQL-Murder-Mystery

Interactive exercise leveraging SQL concepts to solve a murder mystery. 

![image](https://github.com/ChidimmaIdika/SQL-Murder-Mystery/assets/137975543/8c8b29d1-4253-4975-ab69-abf95bd36e5d)


# Solving a Murder Mystery with SQL

## Table of Contents
- [Introduction](#introduction)
- [Retrieving Crime Scene Report](#retrieving-crime-scene-report)
- [Identifying Witnesses](#identifying-witnesses)
- [Interviewing Witnesses](#interviewing-witnesses)
- [Narrowing Down Suspects](#narrowing-down-suspects)
- [Identifying the Killer](#identifying-the-killer)
- [Investigating the Mastermind](#investigating-the-mastermind)
- [Conclusion](#conclusion)


## Introduction
**Problem statement:** A crime has occurred, and the detective needs your help to solve the case. The only information available is that the crime was a murder that happened on Jan. 15, 2018, in SQL City. Let's use SQL to uncover the details of this mysterious murder.

## Retrieving Crime Scene Report
My investigation starts by retrieving the crime scene report. I remember the date, type, and location of the crime.    
The SQL query below helps me find the corresponding report:

```sql
SELECT Date, Type, description, City
FROM crime_scene_report
WHERE date = 20180115 AND type = "murder" AND City = "SQL City";
```

## Identifying Witnesses 
The crime scene report mentions two witnesses, one living on Northwestern Dr and the other named Annabel residing on Franklin Ave.    
I identify these witnesses using SQL:
```sql
-- Identify Annabel
SELECT *
FROM person
WHERE Name LIKE "Annabel%" AND address_street_name = "Franklin Ave";

-- Identify the other witness on Northwestern Dr
SELECT *
FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 1;
```

## Interviewing Witnesses
To gather more information, I access interview transcripts from the witnesses. The transcripts reveal crucial details:

**Witness #14887:** Describes the murderer, "Get Fit Now Gym" bag, and a car with a plate starting with "H42W."   
**Witness #16371:** Claims to have seen the murder and recognizes the killer from the gym.

## Narrowing Down Suspects 
I proceed to narrow down the list of suspects. First, I identify the *"Get Fit Now Gym"* gold members with bags starting with *"48Z"*:   
```sql
SELECT *
FROM get_fit_now_member
JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE get_fit_now_member.membership_status = "gold" AND get_fit_now_member.id LIKE "48Z%";
```

Next, I cross-reference the suspects' names with the car plate *"H42W"*:
```sql
SELECT person.name, drivers_license.plate_number
FROM person
INNER JOIN drivers_license
ON person.license_id = drivers_license.id
WHERE person.name = "Joe Germuska" OR person.name = "Jeremy Bowers";
```
I find that the car belongs to Jeremy Bowers.

## Identifying the Killer
With Jeremy Bowers identified, I investigate further by checking his gym activity:
```sql
SELECT *
FROM get_fit_now_check_in
JOIN get_fit_now_member
ON get_fit_now_check_in.membership_id = get_fit_now_member.id
WHERE get_fit_now_check_in.check_in_date = 20180109
AND get_fit_now_check_in.membership_id = '48Z55';
```
Jeremy Bowers was at the gym during the same time Annabel was there.

## Investigating the Mastermind
An interview transcript reveals information about the person who hired the murderer:   

- Described as a woman with red hair, driving a Tesla Model S, and attending the SQL Symphony Concert three times in December 2017.
  
I identify the potential mastermind:
```sql
SELECT person_id, event_name, date
FROM facebook_event_checkin
WHERE person_id in (78881, 99716)
AND event_name LIKE 'SQL Symphony%'
AND date LIKE '201712%';
```
Miranda Priestly attended the SQL Symphony Concert three times in December 2017.

## Conclusion 
My investigation has led me to the conclusion that the killer is **MIRANDA PRIESTLY**, the person who hired the murderer. 
>**The case is now solved!**
>
>**Note Received:**   
>*"Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time.   
>Time to break out the champagne!"*


**Stay tuned for more intriguing SQL mysteries!**
![image](https://github.com/ChidimmaIdika/SQL-Murder-Mystery/assets/137975543/83361105-5b96-427a-95b0-6a8d6cc1ee6d)
