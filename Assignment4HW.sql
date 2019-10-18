-- 6.12 
USE [Assignment4]

-- A
Select s.StudentName
From Student s
Where s.Class = 4 AND s.Major = 1

-- B
-- Note: Without the distinct it returns intro to computer science twice because knuth
-- taught it twice in different semesters
Select Distinct c.CourseName
From Course c
Join Section s ON s.CourseId = c.CourseNumber
Where s.InstructorId = 4

-- C
-- Note: This query does not include the second section of intro to cs because
-- there are no students in it so the GradeReport join loses that class cause there
-- is no matching section id in grade report
Select c.CourseNumber, sem.SemesterName, s.Year, Count(*) as 'Number of Students'
From Course c
Join Section s ON s.CourseId = c.CourseNumber
Join Semester sem ON sem.SemesterId = s.SemesterId
Join GradeReport g ON  g.SectionId = s.SectionId
Where s.InstructorId = 4
Group by c.CourseNumber, sem.SemesterName, s.Year

-- D
Select stud.StudentName, c.CourseName, c.CourseNumber, c.CreditHours, sem.SemesterName, s.Year, g.Grade
From Student stud
Join GradeReport g ON g.StudentId = stud.StudentId
Join Section s ON s.SectionId = g.SectionId
Join Course c ON c.CourseNumber = s.CourseId
Join Semester sem ON sem.SemesterId = s.SemesterId
Where stud.Class = 4 AND stud.Major = 1

-- E
Select s.StudentName, m.Major
From Student s
Join Majors m On m.MajorId = s.Major
Where NOT EXISTS (
    Select *
    From GradeReport g 
    Where g.StudentId = s.StudentId AND NOT (Grade='A')
)

-- F
Select s.StudentName, m.Major
From Student s
Join Majors m On m.MajorId = s.Major
Where NOT EXISTS (
    Select *
    From GradeReport g 
    Where g.StudentId = s.StudentId AND (Grade='A')
)

-- 7.5
USE[YaroshCompany]

-- A
Select d.Dname, COUNT(*) as 'Number of Employees'
From Department d
Join Employee e ON e.Dno = d.Dnumber
Group By d.Dname
Having AVG(e.Salary) > 30000