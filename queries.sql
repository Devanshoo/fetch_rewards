-- What are the top 5 brands by receipts scanned for most recent month?

-- I Identified that the most latest month in the dataset is March 2021 and assumed it to be the latest month

SELECT createDate, ItemList_brandCode FROM receipts
ORDER BY createDate DESC
-- For getting most recent month from a timestamp
SELECT EXTRACT(MONTH FROM TIMESTAMP '2021-03-01 18:17:34'); 

--Sol1:

SELECT ItemList_brandCode, COUNT(ItemList_brandCode) FROM receipts
WHERE dateScanned >= '2021-03-01 00:00:00.000' AND dateScanned < '2021-04-01 00:00:00.000'
GROUP BY ItemList_brandCode
ORDER BY count(ItemList_brandCode) DESC
LIMIT 5

-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

--Most recent month
SELECT ItemList_brandCode, COUNT(ItemList_brandCode) FROM receipts
WHERE dateScanned >= '2021-03-01 00:00:00.000' AND dateScanned < '2021-04-01 00:00:00.000'
GROUP BY ItemList_brandCode
ORDER BY count(ItemList_brandCode) DESC
LIMIT 5

--Second most recent month
SELECT ItemList_brandCode, count(ItemList_brandCode) FROM receipts
WHERE dateScanned >= '2021-02-01 00:00:00.000' AND dateScanned < '2021-03-01 00:00:00.000'
GROUP BY ItemList_brandCode
ORDER BY count(ItemList_brandCode) DESC
LIMIT 5

-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- Assuming Finished and Accepted are same:

SELECT rewardsReceiptStatus,AVG(totalSpent) FROM receipts
WHERE rewardsReceiptStatus = 'FINISHED' or rewardsReceiptStatus = 'REJECTED'
GROUP BY rewardsReceiptStatus

-- The average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ is greater than 'Rejected'

-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

SELECT rewardsReceiptStatus, SUM(purchasedItemCount) FROM receipts
WHERE rewardsReceiptStatus = 'FINISHED' or rewardsReceiptStatus = 'REJECTED'
GROUP BY rewardsReceiptStatus

--The total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ is greater than 'Rejected'

-- Which brand has the most spend among users who were created within the past 6 months?

SELECT ItemList_brandCode, SUM(totalSpent) AS total FROM users u
INNER JOIN receipts r
ON r.userid = u._id
WHERE createddate >= '2020-10-01 00:00:00.000' AND createddate < '2021-03-01 00:00:00.000' AND ItemList_brandCode IS NOT NULL
GROUP BY ItemList_brandCode
LIMIT 1;

-- The brand 'BRAND' had the most no of spendings in the past 6 months

-- Which brand has the most transactions among users who were created within the past 6 months?

SELECT ItemList_brandCode, COUNT(r.userid) AS total FROM users u
INNER JOIN receipts r
ON r.userid = u._id
WHERE createddate >= '2020-10-01 00:00:00.000' AND createddate < '2021-03-01 00:00:00.000'
GROUP BY ItemList_brandCode
LIMIT 1;

-- The brand 'BRAND' had the most no of transactions among users who were created within the past 6 months