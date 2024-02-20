CREATE DATABASE Kitabxana

USE Kitabxana

Create Table Books 
(
 Id INT PRIMARY KEY,
    Name VARCHAR(100) CHECK (LEN(Name) >= 2),
    AuthorId INT,
    PageCount INT CHECK (PageCount >= 10),
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
)


CREATE TABLE Authors
(
Id Int PRIMARY KEY,
Name nvarchar,
Surname nvarchar
)

CREATE VIEW BookAuthorView AS
SELECT
    b.Id AS BookId,
    b.Name AS BookName,
    b.PageCount,
    CONCAT(a.Name, ' ', a.Surname) AS AuthorFullName
FROM
    Books b
JOIN
    Authors a ON b.AuthorId = a.Id;


CREATE PROCEDURE AxtarishDeyeri
    @SEARCHVALUE NVARCHAR(100)
AS 
BEGIN 
    SELECT 
        Books.Id,
        Books.Name,
        Books.PageCount,
        CONCAT(Authors.Name, ' ', Authors.Surname) AS AuthorFullName
    FROM 
        Books 
    JOIN 
        Authors ON Authors.Id = Books.AuthorId
    WHERE 
        Books.Name LIKE '%' + @SEARCHVALUE + '%' OR
        CONCAT(Authors.Name, ' ', Authors.Surname) LIKE '%' + @SEARCHVALUE + '%';
END


EXEC AxtarishDeyeri'asdf';



CREATE PROCEDURE kitabiUpdateEle 
    @BookId Int,
    @NewName VARCHAR(100),
    @NewPageCount Int
AS
Begin
    UPDATE Books
    SET 
        Name = @NewName,
        PageCount = @NewPageCount
    where 
        Id = @BookId;
END;

EXEC KitabiUpdateEle @BookId = 123, @NewName = 'New Book Name', @NewPageCount = 200;
