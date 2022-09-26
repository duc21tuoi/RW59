#2 Lấy ra tất cả phòng ban
SELECT 
    *
FROM
    Department;

#3 Lấy ra id của phòng ban Sale(Account)
SELECT 
    AccountID
FROM
    `Account`;

#6 Lấy ra tên Group đã tham gia trước ngày 20/12/2020
SELECT 
    GroupName
FROM
    `Group`
WHERE
    CreateDate < '2020/12/20';

#8 Lấy ra các mã đề thi có thời gian thi >=60 phút và được tạo trước ngày 20/12/2020
SELECT 
    `Code`
FROM
    Exam
WHERE
    Duration >= 60
        AND CreateDate < '2020/12/20';
        
#11 Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thức bằng chữ "C"
SELECT 
    FullName
FROM
    `Account`
WHERE
    FullName LIKE 'D%c'; 
    
#4 lấy ra thông tin account có full name dài nhất
SELECT 
    MAX(LENGTH(FullName))
FROM
    `Account`;
SELECT 
    *
FROM
    `Account`
WHERE
    LENGTH(FullName) = 11;
    
#10 Đếm số nhân viên thuộc department có id = 2
SELECT 
    COUNT(*)
FROM
    `Account`
WHERE
    DepartmentID = 2;
    
#9 Lấy ra 5 group được tạo gần đây nhất    
SELECT 
    *
FROM
    `Group`
ORDER BY CreateDate;
SELECT 
    *
FROM
    `Group`
WHERE
    CreateDate >= '2020/04/06';
-- Cách khác
SELECT 
    *
FROM
    `Group`
ORDER BY CreateDate DESC
LIMIT 5;

SELECT 
    MAX(LENGTH(FullName))
FROM
    `Account`
    Group by MAX(LENGTH(FullName)) Having departmentID = 3 ;

#7 Lấy ra ID của question có >= 4 câu trả lời
SELECT 
    QuestionID
FROM
    Answer
GROUP BY QuestionID
HAVING COUNT(QuestionID) >= 4;

#12 Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM Exam 
WHERE
    CreateDate < '2019-12-20';
    
#13 Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"

#14 Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `Account` 
SET 
    Fullname = 'Nguyễn Bá Lộc',
    Email = 'loc.nguyenba@vti.com.vn'
WHERE
    AccountID = 5;
    
#15 update account có id = 5 sẽ thuộc group có id = 4
UPDATE `GroupAccount` 
SET 
    AccountID = 5
WHERE
    GroupID = 4;
    

    
