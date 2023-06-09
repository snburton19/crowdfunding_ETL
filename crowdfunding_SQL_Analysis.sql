-- DELIVERABLE 4: SQL ANALYSIS
-- 1. (2.5 pts)
-- Write an SQL query that retrieves the number of backer_counts in descending order for each “cf_id” for all the "live" campaigns.

SELECT cp.backers_count, cp.cf_id
FROM campaign AS cp
WHERE (cp.outcome = 'live')
ORDER BY cp.backers_count DESC;

-- 2. (2.5 pts)
-- Write an SQL query that uses the backers table to confirm the results from Step 1.

SELECT COUNT(b.cf_id), b.cf_id
FROM backers AS b
GROUP BY b.cf_id
ORDER BY COUNT(b.cf_id) DESC;

-- 3. (5 pts)
-- Write an SQL query that creates a new table named email_contacts_remaining_goal_amount that contains the first name of each contact, the last name, the email address, and the remaining goal amount (as "Remaining Goal Amount") in descending order for each live campaign.

SELECT co.first_name, co.last_name, co.email, (cp.goal - cp.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign as cp
INNER JOIN contacts as co
ON (cp.contact_id = co.contact_id)
WHERE (cp.outcome = 'live')
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Write an SQL query that creates a new table named email_backers_remaining_goal_amount that contains the email addresses of the backers, the first and the last name of each backer, the cf_id, the company name, the description, the end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". Sort the table by the last name of each backer, in ascending order (NOTE: altered to ascending from descending order to match module solution image).

SELECT b.email, b.first_name, b.last_name, cp.cf_id, cp.company_name, cp.description, cp.end_date, (cp.goal - cp.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM campaign as cp
INNER JOIN backers as b
ON (cp.cf_id = b.cf_id)
WHERE (cp.outcome = 'live')
ORDER BY b.last_name;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;