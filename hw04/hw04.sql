--REQ

--    Natural join, generic inner join, as well as outer join
--    Grouping and aggregation (both GROUP BY and HAVING clauses)
--    One set operation: UNION, INTERSECT or EXCEPT
--    Sorting (ORDER BY clause)
--    Sub-query expression

-- I need natural join
-- 


--Inner join completed
--find city for customer who has id 1
SELECT city
FROM CustAdress
JOIN Customer ON Customer.id = CustAdress.customer
WHERE id = 1

--ORDER BY completed, GROUP BY, HAVING, EXCEPT completed
--find all employyes names that have higher salary than 30 000CZK in descending order
SELECT E.wage, E.name
FROM Employee as E
GROUP BY (E.wage)
HAVING (E.wage >= 30000)
ORDER BY E.wage DESC

--Name of customers, who did not bought any membership from 2018
--Sub-query completed - probably
SELECT Customer.name
FROM Customer
WHERE Customer.id NOT IN
(SELECT Membership.customer
FROM Membership
WHERE startDate > "2018-1-1");

--Name of customers who never bought any membership
--left join
SELECT Customer.name
FROM Customer
LEFT JOIN Membership
ON Customer.id = Membership.customer
WHERE startDate IS NULL

--Except used
--Vyberu zakazniky co použivaji nějaký equipment ale nemají členství
SELECT equipment
FROM usingNow
EXCEPT
SELECT equipment
FROM usingNow
WHERE length < 30

