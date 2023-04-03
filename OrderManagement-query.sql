-- Truy vấn thông tin khách hàng
SELECT 
    customerNumber,
    contactLastName,
    contactFirstName,
    addressLine1,
    city,
    state,
    country
FROM
    customers
WHERE
    phone = '+49 69 66 90 2555';

-- Truy vấn ra thông tin đơn hàng, từ câu truy vấn trước ta biết được mã số khách hàng là 128
SELECT 
    *
FROM
    orders
WHERE
    customerNumber = '128'
        AND orderDate = '2003-01-09';

-- Truy vấn thông tin nhân viên chăm sóc khách hàng của đơn hàng này
SELECT 
    e.employeeNumber,
    e.lastName,
    e.lastName,
    e.reportsTo,
    e.officeCode
FROM
    employees AS e
        JOIN
    customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE
    c.customerNumber = 128;

-- Tuy vấn thông tin sản phẩm bị phàn nàn
SELECT 
    productCode, productName, productLine, MSRP
FROM
    products
WHERE
    productName LIKE '%1928 Mercedes-Ben%';

-- Kiểm tra kho hàng còn sản phẩm đó không
SELECT 
    quantityInStock
FROM
    products
WHERE
    productCode = 'S18_2795';

-- Dựa vào những dòng sản phẩm có cùng mức giá, chênh lệnh giá nhỏ để tư vấn
SELECT 
    productName, productLine, MSRP
FROM
    products
WHERE
    productCode != 'S18_2795'
        AND ABS(MSRP - 168.75) < 5;

-- Đưa ra những dòng sản phẩm có cùng một só đặc điểm với xe trước
SELECT 
    productName, productVendor, productDescription
FROM
    products
WHERE
    productLine = 'Vintage Cars'
        AND productScale = '1:18';

-- Truy vấn sản phẩm mới mà khách hàng yêu cầu theo đặc điểm
-- (sản phẩm có màu trắng đen và có thể mở mui xe)
SELECT 
    *
FROM
    products
WHERE
    productDescription LIKE '%opening hood%'
        AND productDescription REGEXP 'white|black';

-- Tìm 1 nhân viên đã có kinh nghiệm để tư vấn cho khách hàng
SELECT 
    COUNT(salesRepEmployeeNumber) AS Count,
    salesRepEmployeeNumber
FROM
    customers
GROUP BY salesRepEmployeeNumber
ORDER BY COUNT(salesRepEmployeeNumber) DESC
LIMIT 1;

-- Hiển thị những khách hàng đã mua sản phẩm này để tiến hành khảo sát
SELECT 
    *
FROM
    customers
WHERE
    customerNumber IN (SELECT 
            customerNumber
        FROM
            orders
        WHERE
            orderNumber IN (SELECT 
                    orderNumber
                FROM
                    orderdetails
                WHERE
                    productCode = 'S18_2795'));

-- Hiển thị top 5 khách hàng có tổng giá trị đơn hàng lớn nhất
SELECT 
    C.customerName,
    SUM(OD.quantityOrdered * OD.priceEach) AS Total
FROM
    customers C
        INNER JOIN
    orders O ON c.customerNumber = O.customerNumber
        INNER JOIN
    orderdetails OD ON O.orderNumber - OD.orderNumber
GROUP BY C.customerName
ORDER BY Total DESC
LIMIT 5;

-- Hiển thị top 5 sản phẩm có tỷ lệ doanh số cao nhất
select productCode, sum(priceEach * quantityOrdered)*100/ sum(sum(priceEach* quantityOrdered)) over() percentage
from orderdetails
group by productCode
order by percentage desc
limit 5;

-- Kiểm tra giao vận đã đứng gian yêu cầu chưa, hiện thị đơn hàng giao trễ
SELECT 
    orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    DATEDIFF(shippedDate, requiredDate) AS LateShipmentDate
FROM
    orders
WHERE
    DATEDIFF(requiredDate, shippedDate) < 0;

-- Đưa ra các sản phẩm không có mặt trong bất kỳ đơn hàng nào 
SELECT 
    *
FROM
    products
WHERE
    productCode NOT IN (SELECT 
            productCode
        FROM
            orderdetails);

-- 15.	Đưa ra các sản phẩm có số lượng trong kho lớn hơn trung bình số lượng tron kho của các sản phẩm cùng loại
SELECT 
    *
FROM
    products p
WHERE
    quantityInStock > (SELECT 
            AVG(quantityInStock)
        FROM
            products
        WHERE
            productLine = p.productLine); 
     
-- Thống kê tổng số lượng sản phẩm trong kho theo từng dòng sản phẩm của từng nhà cung ứng
SELECT 
    productVendor, productLine, SUM(quantityInStock)
FROM
    products
GROUP BY productVendor , productLine WITH ROLLUP;

-- Thống kê ra mỗi sản phẩm được đặt hàng lần cuối vào thời gian nào và khách hàng đã đặt
Select * From
	(Select 
    customerNumber, orderDate, max(orderDate)
    Over(partition by productCode) as max_Date, productCode
    from
		(Select *
         from orderdetails inner join orders
         using (orderNumber)
         ) t
	) t2
Where orderDate = max_Date;



