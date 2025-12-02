CREATE DATABASE Edu_CourseDB

USE Edu_CourseDB

--trainer
CREATE TABLE Trainers
(
    ID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN(Name)>=2),
    Surname NVARCHAR(30) NOT NULL 
    CHECK (LEN(Surname)>=2),
    [Fathers Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN([Fathers Name])>=2),
    Fin VARCHAR(7) NOT NULL UNIQUE 
    CHECK(LEN(Fin) = 7), 
    Phone VARCHAR(50) NOT NULL UNIQUE,
    BirthDate DATE NOT NULL --YYYY-MM-DD
    CHECK 
         (
          BirthDate <= CAST(GETDATE() AS DATE) -- gələcək zaman daxil edilməsin
          AND BirthDate <= DATEADD(YEAR, -18, CAST(GETDATE() AS DATE)) --18-dən balaca olmasın
         ),
    Profession NVARCHAR(100) NOT NULL,
    Experience NVARCHAR(100) NOT NULL,
    [Status] VARCHAR(30) NOT NULL
);

--package
CREATE TABLE Packages
(
    ID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN(Name)>=2),
    [Period] DATE NOT NULL --YYYY-MM-DD
);

--section
CREATE TABLE Sections
(
    ID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN(Name)>=2)
);

--subject
CREATE TABLE Subjects
(
    ID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN(Name)>=2)
);

--student
CREATE TABLE Students
(
    ID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN(Name)>=2),
    Surname NVARCHAR(30) NOT NULL 
    CHECK (LEN(Surname)>=2),
    [Fathers Name] NVARCHAR(30) NOT NULL 
    CHECK (LEN([Fathers Name])>=2),
    Fin VARCHAR(7) NOT NULL UNIQUE 
    CHECK(LEN(Fin) = 7), 
    University VARCHAR(100) NOT NULL,
    Profession NVARCHAR(100) NOT NULL,
    Course VARCHAR(10) NOT NULL,
    Phone VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE
);

--Registration
CREATE TABLE Registrations
(
    ID INT PRIMARY KEY IDENTITY,
    StudentID INT FOREIGN KEY REFERENCES Students(ID),
    PackageID INT FOREIGN KEY REFERENCES Packages(ID),
    [Contract Date] DATE NOT NULL,
    Discount DECIMAL(5,2),
    [Status] VARCHAR(30) NOT NULL,
    TrainerID INT FOREIGN KEY REFERENCES Trainers(ID)
);

--payment

CREATE TABLE Payments
(
    ID INT PRIMARY KEY IDENTITY,
    RegistrationID INT FOREIGN KEY REFERENCES Registrations(ID),
    [Payment Time] DATE NOT NULL,
    Amount DECIMAL(5,2) NOT NULL
);

------------------------------------------------------------------------------------
INSERT INTO Trainers ([Name], Surname, [Fathers Name], Fin, Phone, BirthDate, Profession, Experience, [Status])
VALUES
('Elvin', 'Qasımov', 'Vaqif oğlu', 'AQD4521', '050-555-12-34',
 '1988-03-15', 'Full Stack Təlimçisi', '8 il', 'Aktiv'),

('Aysel', 'Məmmədova', 'Rövşən qızı', 'KLP9023', '051-777-99-00',
 '1990-11-22', 'Dizayn Təlimçisi', '6 il', 'Aktiv'),

('Ramil', 'Əliyev', 'Sahib oğlu', 'TGH7124', '070-444-55-66',
 '1985-07-09', 'Marketinq Təlimçisi', '10 il', 'Aktiv');

------------------------------------------------------------------------------------
INSERT INTO Packages ([Name], [Period])
VALUES
('Full Stack', '2025-01-01'),
('Dizayn', '2025-02-01'),
('Marketinq', '2025-03-01');

------------------------------------------------------------------------------------
INSERT INTO Sections ([Name])
VALUES
('Backend Bölməsi'),
('Frontend Bölməsi'),
('Dizayn Bölməsi');

------------------------------------------------------------------------------------
INSERT INTO Subjects ([Name])
VALUES
('C# dərsləri'),
('SQL əsasları'),
('UI/UX əsasları');

------------------------------------------------------------------------------------
INSERT INTO Students ([Name], Surname, [Fathers Name], Fin, University, Profession, Course, Phone, Email)
VALUES
('Nərmin', 'Əlizadə', 'Qədir qızı', 'PLM7821',
 'BDU', 'İT', 'III', '055-222-33-44', 'nermin@edu.az'),

('Murad', 'İsmayılov', 'Eldar oğlu', 'XCV9812',
 'ADA', 'Dizayn', 'II', '070-323-45-67', 'murad@edu.az'),

('Gülay', 'Rzayeva', 'Camal qızı', 'FDS5521',
 'AzTU', 'Kompüter Elmləri', 'IV', '051-898-12-45', 'gulay@edu.az'),

('Eljan', 'Quliyev', 'İlqar oğlu', 'ZXC1122',
 'Qərbi Kaspi', 'Marketing', 'I', '050-900-11-22', 'eljan@edu.az');

------------------------------------------------------------------------------------
INSERT INTO Registrations (StudentID, PackageID, [Contract Date], Discount, [Status], TrainerID)
VALUES
(1, 1, '2025-01-10', 10.00, 'Aktiv', 1),  -- Nərmin – Full Stack
(2, 2, '2025-01-15', 0.00, 'Aktiv', 2),   -- Murad – Dizayn
(3, 1, '2025-01-20', 5.00, 'Aktiv', 1),   -- Gülay – Full Stack
(4, 3, '2025-01-25', 0.00, 'Aktiv', 3);   -- Eljan – Marketinq

------------------------------------------------------------------------------------
INSERT INTO Payments (RegistrationID, [Payment Time], Amount)
VALUES
-- 1) Nərmin – ödəniş etmişdir
(1, '2025-01-12', 150.00),

-- 2) Murad – 20 gündür gecikib (Task 4)
(2, '2025-01-01', 200.00),

-- 3) Gülay – 3 gün sonra deadline gələcək kimi qəbul edilir
(3, '2025-02-10', 180.00),

-- 4) Eljan – son ödəniş tarixindən 1 ay keçib (Task 6)
(4, '2024-12-20', 120.00);

------------------------------------------------------------------------------------
--Tasklar
--1.Full stack paketi üçün qeydiyyatdan keçən tələbələrin ümumi sayını tapın
--2.Kursun aylıq dövriyyəsini hesablayın
--3.Ödəniş vaxtına 3 gün qalan tələbələrin siyahısını tapın
--4.Ödəniş vaxtından keçən tələbələrin siyahısını tapın
--5. Təlimçilərin kursdan aldığı maaş hər tələbənin 
--aylıq ödənişinin 50%-i olduğunu bilərək onların maaşlarını hesablayın
--6. Son 1 aylıq ödənişi qalan tələbələrin siyahısı
--7.  Hal-hazırda kursun neçə tələbəsi var
--8. Hər paket üzrə hər təlimçinin dərs keçdiyi tələbə sayını tapın

------------------------------------------------------------------------------------

--1.Full stack paketi üçün qeydiyyatdan keçən tələbələrin ümumi sayını tapın
SELECT
    COUNT(S.ID) AS [FullStack Tələbə Sayi]
FROM Students AS S
JOIN Registrations AS R
    ON S.ID = R.StudentID
JOIN Packages AS P
    ON R.PackageID = P.ID
WHERE P.Name = 'Full Stack';

--2.Kursun aylıq dövriyyəsini hesablayın
SELECT
     SUM(P.Amount) AS [Kursun aylıq dövriyyəsi]
FROM Payments AS P
WHERE P.[Payment Time] BETWEEN '2025-01-01' AND '2025-01-31';

--3.Ödəniş vaxtına 3 gün qalan tələbələrin siyahısını tapın
SELECT 
    S.ID,
    S.[Name],
    S.Surname,
    S.[Fathers Name],
    P.[Payment Time],
    DATEDIFF(DAY, '2025-01-09', P.[Payment Time]) AS [Days Left]
FROM Students AS S
JOIN Registrations AS R ON R.StudentID = S.ID
JOIN Payments AS P ON P.RegistrationID = R.ID
WHERE DATEDIFF(DAY, '2025-01-09', P.[Payment Time]) = 3;

--4.Ödəniş vaxtından keçən tələbələrin siyahısını tapın
SELECT 
    S.ID,
    S.[Name],
    S.Surname,
    S.[Fathers Name],
    P.[Payment Time]
FROM Students AS S
JOIN Registrations AS R ON R.StudentID = S.ID
JOIN Payments AS P ON P.RegistrationID = R.ID
WHERE P.[Payment Time] < '2025-01-10'

--5. Təlimçilərin kursdan aldığı maaş hər tələbənin 
--aylıq ödənişinin 50%-i olduğunu bilərək onların maaşlarını hesablayın
--Trainers → Registrations → Payments
SELECT 
    T.ID,
    T.[Name],
    T.Surname,
    SUM(P.Amount * 0.5) AS [Teacher Salary]
FROM Trainers AS T
JOIN Registrations AS R
    ON T.ID = R.TrainerID
JOIN Payments AS P
    ON R.ID = P.RegistrationID
GROUP BY T.ID, T.[Name], T.Surname;

--6. Son 1 aylıq ödənişi qalan tələbələrin siyahısı

DECLARE @Today DATE = '2025-01-20';

SELECT 
    S.ID,
    S.[Name],
    S.Surname,
    S.[Fathers Name],
    P.[Payment Time]
FROM Students AS S
JOIN Registrations AS R ON R.StudentID = S.ID
LEFT JOIN Payments AS P ON P.RegistrationID = R.ID
WHERE P.[Payment Time] IS NULL
   OR DATEDIFF(DAY, P.[Payment Time], @Today) > 30;

--7.  Hal-hazırda kursun neçə tələbəsi var
--DISTİNCT - təkrarları sayır
SELECT COUNT(DISTINCT R.StudentID) AS [Tələbə sayı]
FROM Registrations AS R;


--8. Hər paket üzrə hər təlimçinin dərs keçdiyi tələbə sayını tapın
  
SELECT
    T.ID AS TrainerID,
    T.[Name] AS TrainerName,
    T.Surname AS TrainerSurname,
    P.Name AS PackageName,
    COUNT(DISTINCT R.StudentID) AS [Tələbə sayı]
FROM Trainers AS T
JOIN Registrations AS R ON R.TrainerID = T.ID
JOIN Packages AS P ON P.ID = R.PackageID
GROUP BY 
    T.ID, 
    T.[Name], 
    T.Surname,
    P.Name
ORDER BY 
    T.ID, 
    P.Name;



