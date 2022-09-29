USE Ducdata1;

#1 Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE VIEW W_DEPARTMENT_NAME AS
    SELECT 
        A.EMAIL, A.USERNAME, A.FULLNAME
    FROM
        `ACCOUNT` A
            JOIN
        DEPARTMENT D ON D.DEPARTMENTID = A.DEPARTMENTID
    WHERE
        D.DEPARTMENTNAME = ' SALE ';
 SELECT 
    *
FROM
    W_DEPARTMENTNAME;
 
#2 Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
 CREATE VIEW W_GROUP_ACCOUNT_DSVN AS
    SELECT 
        A.EMAIL,
        A.USERNAME,
        A.FULLNAME,
        A.ACCOUNTID,
        COUNT(GA.ACCOUNTID)
    FROM
        `ACCOUNT` A
            JOIN
        GROUPACCOUNT GA ON A.ACCOUNTID = GA.ACCOUNTID
    GROUP BY A.ACCOUNTID
    HAVING COUNT(GA.ACCOUNTID) = (SELECT 
            MAX(TABLEA)
        FROM
            (SELECT 
                COUNT(ACCOUNTID) AS TABLEA
            FROM
                `ACCOUNT`
            GROUP BY ACCOUNTID) AS TABLEB);
  
  SELECT 
    *
FROM
    W_GROUP_ACCOUNT_DSVN;
  
#3 Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
  
  CREATE VIEW W_QUESTION_MAXCONTENT AS
    SELECT 
        *
    FROM
        QUESTION
    WHERE
        LENGTH(CONTENT) >= 300;
  DELETE FROM W_QUESTION_MAXCONTENT;
     
 
#4 Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
  CREATE OR REPLACE VIEW W_ACCOUNT_MAXNV AS
    SELECT 
        COUNT(A.DEPARTMENTID),
        D.DEPARTMENTNAME,
        A.EMAIL,
        A.USERNAME,
        A.FULLNAME
    FROM
        DEPARTMENT D
            JOIN
        `ACCOUNT` A ON A.DEPARTMENTID = D.DEPARTMENTID
    GROUP BY A.DEPARTMENTID
    HAVING COUNT(A.DEPARTMENTID) = (SELECT 
            MAX(TABLEA)
        FROM
            (SELECT 
                COUNT(ACCOUNTID) AS TABLEA
            FROM
                `ACCOUNT`
            GROUP BY ACCOUNTID) AS TABLEB);

 SELECT 
    *
FROM
    W_ACCOUNT_MAXNV; 

#5 Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo		
CREATE OR REPLACE VIEW W_CREATOR_BY_NGUYEN AS
    SELECT 
        A.FULLNAME, A.USERNAME
    FROM
        QUESTION Q
            RIGHT JOIN
        `ACCOUNT` A ON Q.CREATORID = A.ACCOUNTID
    WHERE
        A.FULLNAME LIKE 'NGUYỄN%';

 SELECT 
    *
FROM
    W_CREATOR_BY_NGUYEN;