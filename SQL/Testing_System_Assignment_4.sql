USE Ducdata1;
#1 Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 
    A.Email, A.Username, A.FullName, D.DepartmentName
FROM
    Department AS D
        JOIN
    `Account` AS A ON A.DepartmentID = D.DepartmentID;

#2 Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT 
    *
FROM
    `Account`
WHERE
    CreateDate > '2010/12/20';

#3 Viết lệnh để lấy ra tất cả các developer
SELECT 
    A.Email, A.Username, A.FullName, P.PositionName
FROM
    `Account` AS A
        JOIN
    Position AS P ON A.PositionID = P.PositionID;
   
#4 Viết lệnh để lấy ra danh sách các phòng ban có >=3 nhân viên
   SELECT 
    COUNT(A.DepartmentID), D.DepartmentName
FROM
    Department AS D
        JOIN
    `Account` AS A ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.DepartmentID) >= 3;
    
#5 Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT 
    EQ.QuestionID, Q.Content, Q.CreateDate
FROM
    ExamQuestion EQ
        JOIN
    Question Q ON EQ.QuestionID = Q.QuestionID
GROUP BY EQ.QuestionID
HAVING MAX(EQ.QuestionID) = (SELECT 
        MAX(TableA)
    FROM
        (SELECT 
            COUNT(QuestionID) AS TableA
        FROM
            ExamQuestion
        GROUP BY QuestionID) AS TableB);

#6 Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
 SELECT 
    CQ.CategoryID, CQ.CategoryName, COUNT(Q.CategoryID)
FROM
    CategoryQuestion CQ
        JOIN
    Question Q ON CQ.CategoryID = Q.CategoryID
GROUP BY Q.CategoryID;
 
#7 Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT 
    COUNT(Q.QuestionID), Q.QuestionID
FROM
    Question Q
        JOIN
    ExamQuestion EQ ON Q.QuestionID = EQ.QuestionID
GROUP BY Q.QuestionID;

#8 Lấy ra Question có nhiều câu trả lời nhất
 SELECT 
    COUNT(A.QuestionID), Q.*
FROM
    Answer A
        JOIN
    Question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING COUNT(Q.QuestionID) = (SELECT 
        MAX(TableA)
    FROM
        (SELECT 
            COUNT(QuestionID) AS TableA
        FROM
            Answer
        GROUP BY QuestionID) AS TableB);
    
    
    -- Question 9: Thống kê số lượng account trong mỗi group
    SELECT 
    COUNT(GR.GroupID), G.GroupName
FROM
    `Groups` G
        JOIN
    GroupAccount GR ON G.GroupID = GR.GroupID
GROUP BY G.GroupID;
    
    -- Question 10: Tìm chức vụ có ít người nhất
SELECT 
    P.PositionID, P.PositionName, A.*
FROM
    Position P
        JOIN
    `Account` A ON P.PositionID = A.PositionID
GROUP BY A.PositionID
HAVING COUNT(A.PositionID) = (SELECT 
        MIN(countP)
    FROM
        (SELECT 
            COUNT(PositionID) countP, PositionID AS TableA
        FROM
            `Account`
        GROUP BY PositionID) AS TableB);
            
            
    -- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
    SELECT 
    COUNT(D.DepartmentID), COUNT(P.PositionID), A.*
FROM
    `Account` A
        JOIN
    Department D ON D.DepartmentID = A.DepartmentID
        JOIN
    Position P ON P.PositionID = A.PositionID
GROUP BY A.PositionID;
