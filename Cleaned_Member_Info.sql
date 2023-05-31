-- Examine data in original form
SELECT *
FROM Club_Member_Info
LIMIT 20;

-- Add a Primary Key
ALTER TABLE Club_Member_Info
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

--  Identify duplicate entries
SELECT email, phone, COUNT(*) AS count
FROM Club_Member_Info
GROUP BY email, phone
HAVING COUNT(*) > 1;

-- Delete duplicate records and keep one copy
DELETE FROM Club_Member_Info
WHERE (email, phone) IN (
    SELECT * FROM (
        SELECT email, phone
        FROM Club_Member_Info
        GROUP BY email, phone
        HAVING COUNT(*) > 1
    ) AS duplicates
) AND id NOT IN (
    SELECT id FROM (
        SELECT MIN(id) AS id
        FROM Club_Member_Info
        GROUP BY email, phone
        HAVING COUNT(*) > 1
    ) AS minimum_ids);

-- Remove extra spaces and invalid characters from full_name
UPDATE Club_Member_Info
SET full_name = LOWER(REGEXP_REPLACE(TRIM(full_name), '[^a-zA-Z0-9 ]', ''))
WHERE 1;

UPDATE Club_Member_Info
SET full_name = REGEXP_REPLACE(full_name, '[^a-zA-Z ]', '');

-- Trim whitespace from the 'martial_status' column and convert empty values to NULL
UPDATE Club_Member_Info
SET martial_status = CASE
    WHEN TRIM(martial_status) = '' THEN NULL
    ELSE TRIM(martial_status)
  END;

-- Trim whitespace from the 'phone' column, and convert empty or incomplete to NULL  
UPDATE Club_Member_Info
SET phone = CASE
    WHEN TRIM(phone) = '' OR LENGTH(TRIM(phone)) < 10 THEN NULL
    ELSE TRIM(phone)
  END;
  
-- Update column name from "martial_status" to "marital_status"
ALTER TABLE Club_Member_Info
CHANGE martial_status marital_status VARCHAR(255);


