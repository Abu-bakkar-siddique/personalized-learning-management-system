
-- STUDENTS

INSERT INTO Students (name, email, date_of_birth)
VALUES
('John Doe', 'john.doe@example.com', '2000-01-01'),
('Jane Smith', 'jane.smith@example.com', '2001-02-02'),
('Robert Brown', 'robert.brown@example.com', '2002-03-03'),
('Emily Davis', 'emily.davis@example.com', '2000-04-04'),
('Michael Johnson', 'michael.johnson@example.com', '2001-05-05'),
('Jessica Wilson', 'jessica.wilson@example.com', '2002-06-06'),
('David Lee', 'david.lee@example.com', '2000-07-07'),
('Sarah Walker', 'sarah.walker@example.com', '2001-08-08'),
('Daniel Hall', 'daniel.hall@example.com', '2002-09-09'),
('Laura Allen', 'laura.allen@example.com', '2000-10-10');


-- DEPARTMENTS
INSERT INTO Departments (name)
VALUES
('Computer Science'),
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('English'),
('History'),
('Geography'),
('Economics'),
('Psychology');

-- STUDENT DEPARTMENTSS

INSERT INTO Student_department (student_id, department_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);




-- Random teachers inserted
INSERT INTO Teachers (name, email, category) VALUES
    ('Muhammad Ali', 'muhammad.ali@example.com', 'Associate Professor'),
    ('Fatima Khan', 'fatima.khan@example.com', 'Assistant Professor'),
    ('Ahmed Hassan', 'ahmed.hassan@example.com', 'Professor'),
    ('Aisha Rahman', 'aisha.rahman@example.com', 'Professor'),
    ('Omar Ibrahim', 'omar.ibrahim@example.com', 'Associate Professor'),
    ('Zainab Ahmed', 'zainab.ahmed@example.com', 'Assistant Professor'),
    ('Yusuf Khan', 'yusuf.khan@example.com', 'Professor'),
    ('Safiya Ali', 'safiya.ali@example.com', 'Assistant Professor'),
    ('Ibrahim Khan', 'ibrahim.khan@example.com', 'Professor'),
    ('Mariam Hassan', 'mariam.hassan@example.com', 'Associate Professor');


-- Insert 15 subjects with randomly assigned teachers
INSERT INTO Subjects (subject, subject_description, teacher_id) VALUES
    ('Linguistics', 'Study of language structure and meaning', 1),
    ('Mathematics', 'Study of numbers, quantity, and space', 2),
    ('Computer Science', 'Study of algorithms, data structures, and computation', 3),
    ('Psychology', 'Study of behavior and mind', 4),
    ('Biology', 'Study of living organisms', 5),
    ('Physics', 'Study of matter and energy', 6),
    ('Chemistry', 'Study of substances and their properties', 7),
    ('Sociology', 'Study of society and social behavior', 8),
    ('Anthropology', 'Study of human societies and cultures', 9),
    ('History', 'Study of past events and societies', 10),
    ('Engineering Design', 'Application of engineering principles to design', 1),
    ('Environmental Science', 'Study of the environment and ecosystems', 2),
    ('Literature', 'Study of written works and literary techniques', 3),
    ('Economics', 'Study of production, distribution, and consumption of goods and services', 4),
    ('Political Science', 'Study of government systems and political behavior', 5);


-- Insert data into Courses table
INSERT INTO Courses (course_name, course_description, department_id)
VALUES
('Intro to CS', 'Introduction to Computer Science', 1),
('Advanced Mathematics', 'Advanced concepts in mathematics', 2),
('Modern Physics', 'Contemporary physics topics', 3),
('Chemical Reactions', 'Study of chemical reactions', 4),
('Cell Biology', 'Study of cellular functions', 5),
('English Literature', 'Study of literature in English', 6),
('Ancient Civilizations', 'Study of ancient civilizations', 7),
('Physical Geography', 'Study of physical geography', 8),
('Macroeconomics', 'Study of the economy as a whole', 9),
('Behavioral Psychology', 'Study of human behavior', 10);


-- Insert data into Learning_styles table
INSERT INTO Learning_styles (student_id, style)
VALUES
(1, 'Visual'),
(2, 'Auditory'),
(3, 'Read/Write'),
(4, 'Kinaesthetic'),
(5, 'Visual'),
(6, 'Auditory'),
(7, 'Read/Write'),
(8, 'Kinaesthetic'),    
(9, 'Visual'),
(10, 'Auditory');


-- Insert data into Placement_tests table
INSERT INTO Placement_tests (student_id, subject_id, score)
VALUES
(1, 1, 0.900),
(2, 2, 0.800),
(3, 3, 0.700),
(4, 4, 0.850),
(5, 5, 0.600),
(6, 6, 0.750),
(7, 7, 0.650),
(8, 8, 0.900),
(9, 9, 0.780),
(10, 10, 0.670);


-- Insert data into Recommendations table
INSERT INTO Recommendations (student_id, recommended_department_id, report)
VALUES
(1, 1, 'Recommended for Computer Science'),
(2, 2, 'Recommended for Mathematics'),
(3, 3, 'Recommended for Physics'),
(4, 4, 'Recommended for Chemistry'),
(5, 5, 'Recommended for Biology'),
(6, 6, 'Recommended for English'),
(7, 7, 'Recommended for History'),
(8, 8, 'Recommended for Geography'),
(9, 9, 'Recommended for Economics'),
(10, 10, 'Recommended for Psychology');


-- Insert data into Subjects_good_at table
INSERT INTO Subjects_good_at (student_id, subject_id, current_level)
VALUES
(1, 1, 'Advanced'),
(2, 2, 'Intermediate'),
(3, 3, 'Beginner'),
(4, 4, 'Advanced'),
(5, 5, 'Intermediate'),
(6, 6, 'Beginner'),
(7, 7, 'Advanced'),
(8, 8, 'Intermediate'),
(9, 9, 'Beginner'),
(10, 10, 'Advanced');

-- Insert data into Course_Subjects table
INSERT INTO Course_Subjects (course_id, subject_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert data into Enrollments table
INSERT INTO Enrollments (student_id, course_id, completion_date, current_status)
VALUES
(1, 1, '2022-12-12', 'completed'),
(2, 2, '2023-01-15', 'completed'),
(3, 3, '2023-02-20', 'completed'),
(4, 4, '2023-03-18', 'completed'),
(5, 5, '2023-04-22', 'completed'),
(6, 6, '2023-05-25', 'completed'),
(7, 7, '2023-06-30', 'completed'),
(8, 8, '2023-07-20', 'completed'),
(9, 9, '2023-08-15', 'completed'),
(10, 10, '2023-09-25', 'completed');

-- Insert data into Assignments table
INSERT INTO Assignments (student_id, subject_id, course_id, description, due_date)
VALUES
(1, 1, 1, 'Assignment 1 for Data Structures', '2023-02-15 12:00:00'),
(2, 2, 2, 'Assignment 1 for Calculus', '2023-03-15 12:00:00'),
(3, 3, 3, 'Assignment 1 for Quantum Mechanics', '2023-04-15 12:00:00'),
(4, 4, 4, 'Assignment 1 for Organic Chemistry', '2023-05-15 12:00:00'),
(5, 5, 5, 'Assignment 1 for Genetics', '2023-06-15 12:00:00'),
(6, 6, 6, 'Assignment 1 for Shakespearean Literature', '2023-07-15 12:00:00'),
(7, 7, 7, 'Assignment 1 for World History', '2023-08-15 12:00:00'),
(8, 8, 8, 'Assignment 1 for Cartography', '2023-09-15 12:00:00'),
(9, 9, 9, 'Assignment 1 for Microeconomics', '2023-10-15 12:00:00'),
(10, 10, 10, 'Assignment 1 for Cognitive Psychology', '2023-11-15 12:00:00');


-- Insert data into Submissions table
INSERT INTO Submissions (assignment_id, student_id, grade, feedback)
VALUES
(1, 1, 'A+', 'Excellent work!'),
(2, 2, 'A-', 'Great job!'),
(3, 3, 'B+', 'Good effort!'),
(4, 4, 'B-', 'Nice try!'),
(5, 5, 'C', 'Needs improvement.'),
(6, 6, 'C-', 'Fair attempt.'),
(7, 7, 'D', 'Better luck next time.'),
(8, 8, 'D-', 'Keep trying.'),
(9, 9, 'F', 'Failed.'),
(10, 10, 'A+', 'Outstanding!');


-- Insert data into Exams table
INSERT INTO Exams (subject_id, exam_date, score)
VALUES
(1, '2023-02-20 10:00:00', 0.900),
(2, '2023-03-25 10:00:00', 0.850),
(3, '2023-04-30 10:00:00', 0.800),
(4, '2023-05-20 10:00:00', 0.750),
(5, '2023-06-25 10:00:00', 0.700),
(6, '2023-07-30 10:00:00', 0.950),
(7, '2023-08-20 10:00:00', 0.980),
(8, '2023-09-25 10:00:00', 0.920),
(9, '2023-10-30 10:00:00', 0.890),
(10, '2023-11-20 10:00:00', 0.960);

