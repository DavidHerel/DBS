
--find all employyes names that have higher salary than 30 000CZK in descending order
SELECT E.wage, E.name
FROM Employee as E
GROUP BY E.wage, E.name
HAVING (E.wage >= 30000)
ORDER BY E.wage DESC;

--Name of customers, who did not bought any membership from 2018
SELECT Customer.name
FROM Customer
WHERE Customer.id NOT IN
(SELECT Membership.customer
FROM Membership
WHERE startDate > '2018-1-1');

--Name of customers who never bought any membership
SELECT Customer.name
FROM Customer
LEFT JOIN Membership
ON Customer.id = Membership.customer
WHERE startDate IS NULL;

--Choosing equipment which is used more than 30 minutes
SELECT equipment
FROM usingNow
EXCEPT
SELECT equipment
FROM usingNow
NATURAL JOIN Customer
WHERE length < 30;

--find city for customer who has id 1
SELECT city
FROM CustAdress
JOIN Customer ON Customer.id = CustAdress.customer
WHERE id = 1;
