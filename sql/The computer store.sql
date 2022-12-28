SELECT Name FROM Products;

SELECT Name, Price FROM Products;

SELECT Name FROM Products WHERE Price <= 200;

SELECT * FROM Products
WHERE Price BETWEEN 60 AND 120;

SELECT Name, Price * 100 FROM Products;

SELECT AVG(Price) FROM Products;

SELECT AVG(Price) FROM Products WHERE Manufacturer=2;

SELECT COUNT(*) FROM Products WHERE Price >= 180;

SELECT Name, Price 
FROM Products
WHERE Price >= 180
ORDER BY Price DESC, Name;

SELECT *
FROM Products LEFT JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code;
   
SELECT Products.Name, Price, Manufacturers.Name
FROM Products INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code;
   
SELECT AVG(Price), Manufacturer
FROM Products
GROUP BY Manufacturer;

SELECT AVG(Price), Manufacturers.Name
FROM Products, Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name;
   
SELECT AVG(Price), Manufacturers.Name
FROM Products, Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Price) >= 150;

SELECT Name, Price
FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);

SELECT A.Name, A.Price, F.Name
FROM Products A INNER JOIN Manufacturers F
ON A.Manufacturer = F.Code
AND A.Price =
     (
       SELECT MAX(A.Price)
         FROM Products A
         WHERE A.Manufacturer = F.Code
     );
     
Select m.Name, Avg(p.price) as p_price, COUNT(p.Manufacturer) as m_count
FROM Manufacturers m, Products p
WHERE p.Manufacturer = m.code
GROUP BY m.Name , p.Manufacturer
HAVING Avg(p.price) >= 150 and COUNT(p.Manufacturer) >= 2;
