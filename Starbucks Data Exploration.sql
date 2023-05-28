-- Select data we'll be using
SELECT * FROM Starbucks.Nutrition;

-- Retrieve ItemID, item, calories columns for all rows:
SELECT ItemID, item, calories 
FROM Starbucks.Nutrition;

-- Filter rows based on specific condition: calories less than 200
SELECT * 
FROM Starbucks.Nutrition 
WHERE calories < 200;

-- Calculate the average calories for all items:
SELECT AVG(calories) AS average_calories 
FROM Starbucks.Nutrition;

-- Group the items by type and calculate the average calories for each type:
SELECT type, AVG(calories) AS average_calories 
FROM Starbucks.Nutrition 
GROUP BY type;

-- Count the number of items in each type:
SELECT type, COUNT(*) AS item_count 
FROM Starbucks.Nutrition 
GROUP BY type;

-- Retrieve the items with the highest protein content:
SELECT item, protein 
FROM Starbucks.Nutrition 
WHERE protein = (SELECT MAX(protein) 
FROM Starbucks.Nutrition);

-- Pair items with the same calorie value:
SELECT n1.item AS item1, n2.item AS item2
FROM Starbucks.Nutrition n1
JOIN Starbucks.Nutrition n2 ON n1.calories = n2.calories
WHERE n1.item <> n2.item
ORDER BY n1.calories;







