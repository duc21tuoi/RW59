#1 Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
	
   DROP PROCEDURE IF EXISTS  get_account_name;
   DELIMITER $$
   CREATE PROCEDURE get_account_name (IN in_dep_name NVARCHAR(50))
		BEGIN
			SELECT A.AccountID, A.Fullname, D.DepartmentName
            FROM 	`Department` AS D
            JOIN  	`Account` AS A
            ON  D.DepartmentID = A.DepartmentID 
           WHERE D.DepartmentName = in_dep_name;
        END $$
   DELIMITER ;
 CALL get_account_name ('San Xuat');	
 CALL get_account_name  ('Thu Mua');
        
        
#2 Tạo store để in ra số lượng account trong mỗi group
   
DROP PROCEDURE IF EXISTS get_count_account;
DELIMITER $$
CREATE PROCEDURE get_count_account( IN TEN_GROUP NVARCHAR(50))
	BEGIN 
		SELECT G.GroupName, COUNT(GroupName) AS SO_LUONG
        FROM  `Group` G
        JOIN  `Account` A
        ON  G.CreatorID = A.AccountID
		WHERE G.GroupName = TEN_GROUP
        GROUP BY GroupName
        ORDER BY GroupName;
	END $$
 DELIMITER ; 
CALL get_count_account('GroupName5');
CALL get_count_account('GroupName7');


#3 Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại 

DROP PROCEDURE IF EXISTS count_question;
DELIMITER $$
CREATE PROCEDURE count_question()
	BEGIN
		SELECT T.TypeName , COUNT(T.TypeName) AS COUNT 
        FROM `TypeQuestion` T
		JOIN  `Question` Q
        ON T.TypeID = Q.TypeID
        WHERE Month(Q.CreateDate) = month(now()) AND YEAR(Q.CreateDate) = YEAR(NOW())
        
        GROUP BY Q.TypeID;
        
	END $$
DELIMITER ; 
CALL count_question();


#4 Tạo store để trả ra id của type question có nhiều câu hỏi nhất 
DROP PROCEDURE IF EXISTS max_type_question;
DELIMITER $$
CREATE PROCEDURE max_type_question()
	BEGIN
		SELECT T.TypeID, COUNT(T.TypeID) AS COUNT
        FROM `TypeQuestion` T
		JOIN `Question` Q
        ON T.TypeID = Q.TypeID        
        GROUP BY T.TypeName
        HAVING COUNT(T.TypeID) = (SELECT MAX(COUNTTYPE) FROM  
        (SELECT COUNT(QUES.TypeID) AS COUNTTYPE FROM `Question` AS QUES
        GROUP BY QUES.TypeID) AS COUNT_MAX)        
        ORDER BY T.TypeName ;                
	END $$
DELIMITER ;
CALL max_type_question();

		
#5 Sử dụng store ở question 4 để tìm ra tên của type question CHUA XONG 
  
DROP PROCEDURE IF EXISTS type_question_name;
DELIMITER $$
CREATE PROCEDURE type_question_name()
	BEGIN
    SELECT MTQ.TypeID, TY.TypeName
    FROM max_type_question AS TMQ
    JOIN `TypeQuestion` AS TY
    ON TMQ.TypeID = TY.TypeID
    ;
    END $$
DELIMITER ;
CALL type_question_name();



 /* #6 Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
chuỗi của người dùng nhập vào*/



/* #7 Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
trong store sẽ tự động gán:
	- username sẽ giống email nhưng bỏ phần @..mail đi
	- positionID: sẽ có default là developer
	- departmentID: sẽ được cho vào 1 phòng chờ
Sau đó in ra kết quả tạo thành công   CHUA XONG */


DROP PROCEDURE IF  EXISTS FULLNAME_MAIL ;
DELIMITER $$
CREATE PROCEDURE FULLNAME_MAIL (IN NHAP_FULLNAME NVARCHAR(50)
 IN NHAP_EMAIL NVARCHAR(50))
	BEGIN
		SELECT A. Fullname, A. Username , A.PositionID , A.DepartmentID
        FROM `Account` A ;
        WHERE A. Fullname = NHAP_FULLNAME
        
	END;
DELIMITER ;
CALL FULLNAME_MAIL('Fullname1','Email1@gmail.com');
        


/* #8 Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất CHUA XONG*/

DROP PROCEDURE IF EXISTS THONG_KE ;
DELIMITER $$
CREATE PROCEDURE THONG_KE(IN TYPE_NAME NVARCHAR(50))
	BEGIN 
		SELECT T.TypeName , LENGTH(Q.Content) AS MAX_LENGHT
        FROM `TypeQuestion` T
        JOIN `Question` Q
        ON T.TypeID = Q.TypeID
        WHERE T.TypeName = TYPE_NAME 
        GROUP BY T.TypeName
        HAVING LENGTH(Q.Content) = (SELECT MAX(LENGTH(Content)) FROM `Question`)
       ;
	END $$
DELIMITER ;
CALL THONG_KE('Essay');
                

#9 Viết 1 store cho phép người dùng xóa exam dựa vào ID

DROP PROCEDURE IF EXISTS DELETE_EXAM ;
DELIMITER $$
CREATE PROCEDURE DELETE_EXAM( IN EXAM_ID  TINYINT UNSIGNED)
	BEGIN
    	DELETE FROM `Exam`
        WHERE ExamID = EXAM_ID ;
        
	END $$
DELIMITER ;
CALL DELETE_EXAM ('1');