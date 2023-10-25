/* A crime has taken place and the detective needs your help. 
The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ 
and that it took place in ​SQL City​. 
Start by retrieving the corresponding crime scene report from the police department’s database. */

SELECT Date, Type, description, City
FROM crime_scene_report
WHERE date = 20180115 AND type = "murder" AND City = "SQL City";

/* I queried the crime_scene_report table using the hint given (information remembered); date, city, and type of crime.
The narration of the description is as seen below:
“Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave".” */

-- I queried the Person table to get full details/identifiers of the witnesses, using the code below:
SELECT *
FROM person
WHERE Name LIKE "Annabel%" AND address_street_name = "Franklin Ave";
SELECT *
FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 1;

 /* With this information, I queried the interview table for the transcripts from the interview of the witnesses 
 to get more information that could lead to a break in the case using the code below:  */
SELECT person_id, transcript
FROM interview
WHERE person_id IN (16371, 14887);

/* Information retrieved were as follows:
"14887"	"I heard a gunshot and then saw a man run out. He had a ""Get Fit Now Gym"" bag. 
The membership number on the bag started with ""48Z"". Only gold members have those bags. 
The man got into a car with a plate that included ""H42W""." */

/* "16371"	"I saw the murder happen, and I recognized the killer from my gym when I was 
working out last week on January the 9th." */

/* Armed with the information above, I proceeded to narrow down the suspects till I found the killer. 
I joined the get_fit_now_member table and the get_fit_now_check_in table to gather all information using the code below: */

SELECT *
FROM get_fit_now_member
JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE get_fit_now_member. membership_status = "gold" AND get_fit_now_member. id LIKE "48Z%";

/* Again, I joined the person and drivers_license tables together to cross reference the names of the suspects 
against the plate number that includes “H42W” as seen in the witness’ transcript, using the code below: */

SELECT person.name, drivers_license.plate_number
FROM person
INNER JOIN drivers_license
ON person.license_id = drivers_license.id
WHERE person.name = "Joe Germuska" or person.name = "Jeremy Bowers";

/* It was found that the car was registered to Jeremy Bowers (0H42W2, Chevrolet, Spark LS), 
license id 423327, person id 67318, membership id 20160101. */

Select * 
from get_fit_now_check_in
join get_fit_now_member
on get_fit_now_check_in.membership_id = get_fit_now_member.id
where get_fit_now_check_in.check_in_date = 20180109
and get_fit_now_check_in.membership_id = '48Z55';

/* Get fit gym member with membership id 48Z55 was also at the gym on 20180109 from 1530 t0 1700, 
the same period Annabel was in the gym */

insert into solution (user, value)
values  (1, 'Jeremy Bowers')

Select *
from solution;

-- check murder interview transcript
select *
from interview
where person_id = 67318;

/* Transcript of the murderer: I was hired by a woman with a lot of money. 
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017. */

select *
from drivers_license
join person 
on drivers_license.id = person.license_id
join income 
on income.ssn = person.ssn
where drivers_license.hair_color = 'red'
and drivers_license.gender = 'female'
and drivers_license.car_make = 'Tesla'
and drivers_license.car_model = 'Model S'
order by income.annual_income Desc ;

-- there are 2 women who match this description, they both earn 
-- Red Korb with person id 78881, license id 918773, plate number 917UU3, salary 310,000
-- Miranda Priestly with person id 99716, license id 202298, plate number 500123, salary 278,000

--Next, I investigate which of these women watched the SQL Symphony 3 times in december 2017

select person_id, event_name, date
from facebook_event_checkin
where person_id in (78881,99716)
and event_name Like 'SQL SYmphony%' 
and date like '201712%';

--only the person with id 99716 attended the SQL Symphony Concert 3 times in Dec 2017.
-- the person who hired the murderer is Miranda Priestly

insert into solution (user, value)
values  (2, 'Miranda Priestly');

Select *
from solution;


-- Query output: "2"	"Miranda Priestly"

-- Thus, our killer has been found to be Miranda Priestly