# Order_Management

## Dữ liệu
Dự liệu của một cửa hàng bán xe gồm các bảng: productlines, products, orderdetails, orders, customers, employees, offices, payment
Bộ dữ liệu sẽ có diagram như sau: ![image](https://user-images.githubusercontent.com/128727624/229410965-2f41d172-64fa-4190-9c87-3aabd224c8a5.png)

## Các câu hỏi truy vấn
### Tinh huống: Khách hàng muốn hỏi về đơn hàng đã đặt hôm 9/1/2003, dòng xe Mercedes-Benz 1928 có lỗi và muốn đổi trả
Thông tin đã biết: 
+ Khách hàng có số điện thoại: +496966902555
+ Đơn hàng đã đặt vào ngày 9/1/2003
+ Dòng mô hinh xe cổ Mercedes-Benz 1928
1. Truy vấn thông tin khách hàng 
2. Truy vấn nhân viên đã chăm sóc khách hàng của đơn hàng này
3. Truy vấn thông tin sản phẩm bị phàn nàn
5. Kiểm tra kho hàng còn snar phẩm đó không
6. Dựa vào những dòng sản phẩm có cùng mức giá, chênh lêch giá nhỏ để tư vấn
7. Đưa ra những dòng xe có một số dặc điểm với xe trước
8. Truy vấn sản phẩm mới của khách hàng yêu cầu theo đặc điểm (sản phẩm có màu trắng và thể mở mui xe)
9. Tim 1 nhân viên đã có kinh nghiệm để tư vấn cho khách hàng
### Tình huống: Sau sự cố vừa rồi, công ty tiến hành rà soát lại chất lượng, quản lý yêu cầu nhân viên tổng hợp một số thông tin cần thiết
10. Hiển thị những khách hàng đã mua sản phẩm này để tiến hành khảo sát
11. Hiển thị top 5 khách hàng có tổng giá trị đơn hàng lớn nhất
12. Hiển thị top 5 sản phẩn có tỷ lệ doanh số cao nhất
13. Kiểm tra giao vận đã đúng thời gian yêu cầu chưa, hiển thị đơn hàng giao trễ 
14. Đưa ra các snar phẩm không có mặt trong bất kỳ đơn hàng nào 
15. Đưa ra các sản phâm rcos số lượng trong kho lớn hơn trung bình số lượng trong kho của các sản phẩm cùng loại
16. Thống kê số lượng sản phẩm tỏng kho theo từng dòng sản phẩm của từng nhà cung ứng 
17. Thống kê ra mỗi sản phẩm được đặt hàng lần cuối vào thời gian nào và khách hàng đã đặt 

## Dashboard
![image](https://user-images.githubusercontent.com/128727624/229413899-d4f3120d-b82e-4ac5-8955-0500efc94eaf.png)

## Phân tích
![image](https://user-images.githubusercontent.com/128727624/229413975-2db5119e-5ce8-40f2-933a-7f52ccfff063.png)
Hoạt động kinh doanh diễn ra sôi nổi nhất vào Quý 4 của từng năng do thười điểm này dịp nghỉ giáng Sinh, lễ Tết nên khách hàng có nhu cầu sắm sửa đồ dùng mới
Hai mặt hàng có doanh thu cao nhất là Classics Cars và Vintage Carsm số lượng bán ra của Trains và Ships là rất ít do đây là mặt hàng có nhu cầu không nhiều

![image](https://user-images.githubusercontent.com/128727624/229414021-f4cc184f-816a-4929-9bc1-bccb2ae3cea4.png)
Lượng khahcs hàng được chăm sóc bởi 3 nhân viên Gerard Hernandez, Leslie Jennings, Pamela Castillo là cao hơn so với cac snhaan viên khác
→ Đưa ra cách mức khen thưởng để duy trì động lực làm việc cho nhân viên cũng như khuyến khách những nhân viên khác cố gắng hơn

![image](https://user-images.githubusercontent.com/128727624/229414062-1f4d9198-fa8a-4ff6-85fe-835cb0d9ffe9.png)
Số lượng khách hàng của chi nhanh 4 vượt trội hơn hẳn so với các chi nhanh khác, trong khi đó chi nhánh 5 lại rất thấp → Khen thưởng đới với chi nhánh thu hút được lượng kahchs hàng và thực hiện các điều chỉnh cho các chi nhánh còn lại, đặc biệt là chi nhanh 5

![image](https://user-images.githubusercontent.com/128727624/229414086-c97f73af-18e2-4b67-9866-577a08d6b293.png)
Nhin chung các sản phẩm đều có lượng bán ra rất thấp so với lượng tồn kho → Thực hiện các chương trình khuyến mãi để gia tăng só lượng bán ra, tránh tồn kho quá nhiều 
