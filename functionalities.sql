-- GUYS THIS FILE HAS ALL THE QUERIES FOR THE FUNCTIONALITIES THAT WILL BE PERFORMED BY THE STUDENTS , TEACHERS AND ADMINS WHEN THEY'LL ENGAGE WITH THE APPLICATION

-- ####### FOR THE STUDENTS #######

-- Student Functionalities

-- View Student Profile
SELECT * FROM Students WHERE id = ?;

-- View Enrolled Courses
SELECT Courses.course_name, Courses.course_description, Enrollments.enrollment_date, Enrollments.current_status 
FROM Enrollments 
JOIN Courses ON Enrollments.course_id = Courses.id 
WHERE Enrollments.student_id = ?;

-- View Assignments
SELECT Assignments.description, Assignments.due_date, Subjects.subject, Courses.course_name 
FROM Assignments 
JOIN Subjects ON Assignments.subject_id = Subjects.id 
JOIN Courses ON Assignments.course_id = Courses.id 
WHERE Assignments.student_id = ?;

-- View Placement Test Scores
SELECT Subjects.subject, Placement_tests.score 
FROM Placement_tests 
JOIN Subjects ON Placement_tests.subject_id = Subjects.id 
WHERE Placement_tests.student_id = ?;

-- View Recommendations
SELECT Recommendations.report 
FROM Recommendations 
WHERE Recommendations.student_id = ?;

-- View Upcoming Exams
SELECT Subjects.subject, Exams.exam_date
FROM Exams
JOIN Subjects ON Exams.subject_id = Subjects.id
WHERE Subjects.id IN (
   SELECT subject_id FROM Placement_tests WHERE student_id = ?
)
ORDER BY Exams.exam_date ASC;

-- Submit an Assignment
INSERT INTO Submissions (assignment_id, student_id, submission_datetime, grade, feedback)
VALUES (?, ?, NOW(), NULL, '');

-- View Exam Results
SELECT Subjects.subject, Exams.score
FROM Exams
JOIN Subjects ON Exams.subject_id = Subjects.id
WHERE Exams.subject_id IN (
   SELECT subject_id FROM Placement_tests WHERE student_id = ?
)
ORDER BY Exams.exam_date DESC;

-- View Learning Style
SELECT style
FROM Learning_styles
WHERE student_id = ?;

-- View Detailed Assignment Feedback
SELECT Assignments.description, Submissions.grade, Submissions.feedback
FROM Submissions
JOIN Assignments ON Submissions.assignment_id = Assignments.id
WHERE Submissions.student_id = ?;

-- ########### FOR TEACHER ########################

-- View All Students in a Subject
SELECT Students.id, Students.name, Students.email 
FROM Students 
JOIN Enrollments ON Students.id = Enrollments.student_id 
JOIN Course_Subjects ON Enrollments.course_id = Course_Subjects.course_id 
WHERE Course_Subjects.subject_id = ?;

-- Add Assignment
INSERT INTO Assignments (student_id, subject_id, course_id, description, due_date) 
VALUES (?, ?, ?, ?, ?);

-- Update Assignment Grade
UPDATE Submissions 
SET grade = ? 
WHERE assignment_id = ? AND student_id = ?;

-- View Student Assignments and Submissions
SELECT Assignments.description, Assignments.due_date, Submissions.submission_datetime, Submissions.grade, Submissions.feedback 
FROM Assignments 
JOIN Submissions ON Assignments.id = Submissions.assignment_id 
WHERE Assignments.student_id = ? AND Assignments.subject_id = ?;

-- View All Assignments for a Course
SELECT Assignments.description, Assignments.due_date, Students.name AS student_name, Submissions.grade, Submissions.feedback
FROM Assignments
JOIN Submissions ON Assignments.id = Submissions.assignment_id
JOIN Students ON Assignments.student_id = Students.id
WHERE Assignments.course_id = ?;

-- Add Exam for a Subject
INSERT INTO Exams (subject_id, exam_date, score)
VALUES (?, ?, NULL);

-- View Exam Results for a Subject
SELECT Students.name AS student_name, Exams.score
FROM Exams
JOIN Students ON Exams.subject_id = (SELECT subject_id FROM Subjects WHERE id = ?)
WHERE Exams.subject_id = ?;

-- Update Exam Score
UPDATE Exams
SET score = ?
WHERE subject_id = ? AND exam_date = ?;

-- View All Students in a Course
SELECT Students.id, Students.name, Students.email
FROM Students
JOIN Enrollments ON Students.id = Enrollments.student_id
WHERE Enrollments.course_id = ?;

--################ FOR ADMIN ############################

CALL AddNewStudent('Student Name', 'student@example.com', 'YYYY-MM-DD');

-- Add New Teacher
INSERT INTO Teachers (name, email, category) 
VALUES ('Teacher Name', 'teacher@example.com', 'Professor');

-- Assign Student to Department
INSERT INTO Student_department (student_id, department_id) 
VALUES (?, ?);

-- Create Course
INSERT INTO Courses (course_name, course_description, department_id) 
VALUES ('Course Name', 'Course Description', ?);

-- Assign Subject to Course
INSERT INTO Course_Subjects (course_id, subject_id) 
VALUES (?, ?);

-- Generate Recommendations
CALL GetStudentRecommendations(?);

-- View All Students
SELECT * FROM Students;

-- View All Teachers
SELECT * FROM Teachers;


-- Add New Department
INSERT INTO Departments (name)
VALUES ('New Department Name');

-- Assign Teacher to Subject
INSERT INTO Subjects (subject, subject_description, teacher_id)
VALUES ('New Subject', 'Description of the subject', ?);

-- Update Student's Learning Style
UPDATE Learning_styles
SET style = ?
WHERE student_id = ?;

-- Enroll Student in a Course
INSERT INTO Enrollments (student_id, course_id, enrollment_date, completion_date, current_status)
VALUES (?, ?, NOW(), 'YYYY-MM-DD', 'enrolled');

-- Generate Academic Report for a Student
SELECT * FROM student_academic_info WHERE `Student Name` = ?;

-- View All Courses
SELECT * FROM Courses;

-- View Detailed Exam Results for a Student
SELECT * FROM student_exam_results WHERE `Student Name` = ?;

-- Update Student's Department
UPDATE Student_department
SET department_id = ?
WHERE student_id = ?;