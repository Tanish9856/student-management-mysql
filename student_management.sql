CREATE DATABASE student_management;
USE student_management;

CREATE TABLE courses (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  duration_months INT,
  fees DECIMAL(10,2)
);

CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(15),
  course_id INT,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE attendance (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT,
  date DATE,
  status ENUM('Present','Absent'),
  FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE marks (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT,
  subject VARCHAR(100),
  score INT,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO courses VALUES 
(1, 'Computer Science', 48, 80000),
(2, 'Data Science', 24, 60000),
(3, 'Web Development', 12, 40000);

INSERT INTO students VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210', 1),
(2, 'Priya Singh', 'priya@gmail.com', '9123456780', 2),
(3, 'Amit Kumar', 'amit@gmail.com', '9988776655', 1),
(4, 'Sneha Gupta', 'sneha@gmail.com', '9876512345', 3),
(5, 'Rohan Verma', 'rohan@gmail.com', '9812345678', 2);

INSERT INTO marks VALUES
(1, 1, 'Math', 85),
(2, 1, 'Science', 90),
(3, 2, 'Math', 78),
(4, 2, 'Science', 82),
(5, 3, 'Math', 60),
(6, 3, 'Science', 55),
(7, 4, 'Math', 92),
(8, 4, 'Science', 88),
(9, 5, 'Math', 70),
(10, 5, 'Science', 75);

INSERT INTO attendance VALUES
(1, 1, '2024-01-01', 'Present'),
(2, 1, '2024-01-02', 'Present'),
(3, 1, '2024-01-03', 'Absent'),
(4, 2, '2024-01-01', 'Present'),
(5, 2, '2024-01-02', 'Absent'),
(6, 2, '2024-01-03', 'Absent'),
(7, 3, '2024-01-01', 'Present'),
(8, 3, '2024-01-02', 'Present'),
(9, 3, '2024-01-03', 'Present'),
(10, 4, '2024-01-01', 'Present'),
(11, 4, '2024-01-02', 'Present'),
(12, 4, '2024-01-03', 'Absent'),
(13, 5, '2024-01-01', 'Absent'),
(14, 5, '2024-01-02', 'Present'),
(15, 5, '2024-01-03', 'Present');

SELECT s.name, c.name as course
FROM students s
JOIN courses c ON s.course_id = c.id;

SELECT s.name, AVG(m.score) as average_marks
FROM students s
JOIN marks m ON s.id = m.student_id
GROUP BY s.name;

SELECT s.name, AVG(m.score) as average_marks
FROM students s
JOIN marks m ON s.id = m.student_id
GROUP BY s.name
ORDER BY average_marks DESC
LIMIT 1;

SELECT s.name,
COUNT(CASE WHEN a.status='Present' THEN 1 END) * 100 / COUNT(*) as attendance_pct
FROM students s
JOIN attendance a ON s.id = a.student_id
GROUP BY s.name;

SELECT s.name,
COUNT(CASE WHEN a.status='Present' THEN 1 END) * 100 / COUNT(*) as attendance_pct
FROM students s
JOIN attendance a ON s.id = a.student_id
GROUP BY s.name
HAVING attendance_pct < 75;

SELECT s.name, AVG(m.score) as avg_marks
FROM students s
JOIN marks m ON s.id = m.student_id
GROUP BY s.name
HAVING avg_marks > (SELECT AVG(score) FROM marks);

SELECT c.name, COUNT(s.id) as total_students
FROM courses c
JOIN students s ON c.id = s.course_id
GROUP BY c.name;

