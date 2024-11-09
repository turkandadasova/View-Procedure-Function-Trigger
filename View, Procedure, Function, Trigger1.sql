CREATE DATABASE BlogDB

CREATE TABLE Tags(
Id INT primary key identity,
[Name] nvarchar(50) not null unique
)

CREATE  TABLE Comments(
Id INT primary key identity,
Content nvarchar(250) not null
)

CREATE TABLE Blogs(
Id INT primary key identity,
Title nvarchar(50) not null,
Description nvarchar(50) not null,
CommentsId INT FOREIGN KEY REFERENCES Comments(Id)
)

CREATE TABLE Categories(
Id INT primary key identity,
[Name] nvarchar(50) not null unique,
BlogsId INT FOREIGN KEY REFERENCES Blogs(Id),
)

CREATE TABLE Users(
Id INT primary key identity,
UserName nvarchar(50) not null unique,
FullName nvarchar(50) not null ,
Age INT,
check ( age >0 and age <150),
CommentsId INT FOREIGN KEY REFERENCES Comments(Id),
BlogsId INT FOREIGN KEY REFERENCES Blogs(Id),
)

CREATE TABLE BlogsTags(
Id INT primary key identity,
BlogsId INT FOREIGN KEY REFERENCES Blogs(Id),
TagsId INT FOREIGN KEY REFERENCES Tags(Id),
)

INSERT INTO Comments
values (
'mehsulun qiymeti?'),
(
'hesabivi sil'),
(
'koyneyin linki pls'),
(
'Nice armenian boy'),
(
'dm e baxarsiz da'),
(
'cox qozalsiz (gul emojisi)')

INSERT INTO Blogs
values (
'Elgizle izle','qohumlarini itirmek ucun gel',2),
(
'Turkan olma kursu','taklidler aslini yuceltir :)',3),
(
'200 takibcili fake bloger','yediyim makaronu paylasiram',6),
(
'Nigga ticareti','qiymet ucun dm yazin',5),
(
'2ci el esya','zibillikden tapmisam',1),
(
'Qaqalarla mubarize cemiyeti','Qaqalari ermenilere siriyiriq',4)

INSERT INTO Tags
values (
'realityshow'),
(
'self improvement'),
(
'travel'),
(
'shopping'),
(
'sports')

INSERT INTO Categories
values (
'entertainment',1),
(
'education',2),
(
'life style',3),
(
'fashion',4),
(
'shopping',5),
(
'health',6)

INSERT INTO Users
values (
'Bomuj Akif','Akif Filankesov',63,1,5),
(
'Sefiqe xanim','Sefiqe Nagiyeva',70,2,1),
(
'Qetiyyen Turkanin fake hesabi deyil','Gunel Aliyev',18,3,2),
(
'Cool Tural','Tural Eleskerov',16,4,6),
(
'Insan alvercisi Resad','Resad Pasayev',43,5,4),
(
'Ebulfez dayi','Ebulfez Qeniyev',95,6,3)

CREATE VIEW BlogsUserInfo AS
SELECT UserName,FullName,Title FROM Users
join Blogs
on Users.BlogsId=Blogs.Id

SELECT * FROM BlogsUserInfo

CREATE VIEW BlogsCategoriesInfo AS
SELECT b.Title as [basliq],c.Name as [kateqoriya adi] FROM Categories as c
join Blogs as b
on c.BlogsId=b.Id

SELECT * FROM BlogsCategoriesInfo

CREATE PROCEDURE usp_Get_Comments @userId int
as
SELECT Users.UserName,Comments.Content FROM Users
join Comments
on Users.CommentsId=Comments.Id
where Comments.ID = @userId

EXEC usp_Get_Comments 5


CREATE PROCEDURE usp_Get_Blogs @userId int
as
SELECT Users.UserName,Blogs.Title,Blogs.Description FROM Users
join Blogs
on Users.BlogsId=Blogs.Id
where Blogs.ID = @userId

EXEC usp_Get_Blogs 3

CREATE FUNCTION GetBlogCategoryCount(@categoryId int)
returns int
as
begin
declare @count INT;
select @count = COUNT(*)
from Categories 
where Categories.BlogsId = @categoryId;
return @count;
end;

SELECT dbo.GetBlogCategoryCount(2) as [Blog sayi]

