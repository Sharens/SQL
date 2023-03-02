CREATE DATABASE University

USE University

------------------------------
--Creating tables 
------------------------------

CREATE TABLE Students (
  Id INT PRIMARY KEY,
  Name VARCHAR(255),
  Email VARCHAR(255),
  Phone VARCHAR(20),
  Address VARCHAR(255)
);

CREATE TABLE Lecturers (
  Id INT PRIMARY KEY,
  Name VARCHAR(255),
  Email VARCHAR(255),
  Phone VARCHAR(20),
  Department VARCHAR(255)
);

CREATE TABLE Courses (
  Id INT PRIMARY KEY,
  Name VARCHAR(255),
  Description TEXT,
  Credits INT,
  LecturerId INT,
  FOREIGN KEY (LecturerId) REFERENCES Lecturers(Id)
);

CREATE TABLE Enrollments (
  Id INT PRIMARY KEY,
  StudentId INT,
  CourseId INT,
  Semester VARCHAR(20),
  Grade FLOAT,
  FOREIGN KEY (StudentId) REFERENCES Students(Id),
  FOREIGN KEY (CourseId) REFERENCES Courses(Id)
);

CREATE TABLE Majors (
  Id INT PRIMARY KEY,
  Name VARCHAR(255),
  Description TEXT
);

CREATE TABLE CourseAssignments (
  Id INT PRIMARY KEY,
  CourseId INT,
  MajorId INT,
  Year INT,
  Semester VARCHAR(20),
  FOREIGN KEY (CourseId) REFERENCES Courses(Id),
  FOREIGN KEY (MajorId) REFERENCES Majors(Id)
);

CREATE TABLE Schedule (
  Id INT PRIMARY KEY,
  CourseId INT,
  LecturerId INT,
  DayOfWeek VARCHAR(20),
  StartTime TIME,
  EndTime TIME,
  Room VARCHAR(255),
  Semester VARCHAR(20),
  FOREIGN KEY (CourseId) REFERENCES Courses(Id),
  FOREIGN KEY (LecturerId) REFERENCES Lecturers(Id)
);

CREATE TABLE Exams (
  Id INT PRIMARY KEY,
  CourseId INT,
  LecturerId INT,
  Date DATETIME,
  Room VARCHAR(255),
  FOREIGN KEY (CourseId) REFERENCES Courses(Id),
  FOREIGN KEY (LecturerId) REFERENCES Lecturers(Id)
);
