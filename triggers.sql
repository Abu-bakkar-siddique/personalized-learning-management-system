DELIMITER //

CREATE TRIGGER `add_subjects_good_at`
AFTER INSERT ON Placement_tests
FOR EACH ROW
BEGIN
    DECLARE total_subjects SMALLINT UNSIGNED;
    DECLARE total_subjects_recorded_in_placement_tests SMALLINT UNSIGNED;
    DECLARE highest_score_sub SMALLINT UNSIGNED;
    DECLARE highest_score FLOAT(3,3);
    DECLARE v_current_level VARCHAR(15);

    -- Reading total number of subjects
    SELECT COUNT(*) INTO total_subjects FROM Subjects;

    -- Reading the number of subjects tests
    SELECT COUNT(*) INTO total_subjects_recorded_in_placement_tests
    FROM Placement_tests WHERE student_id = NEW.student_id;

    IF total_subjects = total_subjects_recorded_in_placement_tests THEN
    
        -- Reading highest score
        SELECT score INTO highest_score 
        FROM Placement_tests 
        WHERE student_id = NEW.student_id
        ORDER BY score DESC 
        LIMIT 1;

        -- Checking for student's proficiency level
        IF highest_score >= 90 AND highest_score <= 100 THEN
            SET v_current_level = 'Advanced';
        ELSEIF highest_score >= 65 AND highest_score < 90 THEN
            SET v_current_level = 'Intermediate';
        ELSEIF highest_score < 65 THEN
            SET v_current_level = 'Beginner';
        END IF;
        
        -- Reading the student's best subject once all the tests have been conducted
        SELECT subject_id INTO highest_score_sub 
        FROM Placement_tests 
        WHERE student_id = NEW.student_id
        ORDER BY score DESC 
        LIMIT 1;

        -- Now insert into best subjects table
        INSERT INTO Subjects_good_at (student_id, subject_id, current_level) 
        VALUES (NEW.student_id, highest_score_sub, v_current_level);
    
    END IF;
END//
DELIMITER ;



-- SAAD COMMITTING TO THE PROJECT FROM HERE ----> 
-- UPDATING TRIGGER FOR FOR PROVIDING A MORE DETAILED REPORT AND ALSO CHNGING THE LEVEL MARKING RULES
DELIMITER //
CREATE TRIGGER `add_student_recommendations`
AFTER INSERT ON Placement_tests
FOR EACH ROW
BEGIN
    DECLARE average_score FLOAT(3,3);  
    DECLARE best_subject VARCHAR(64);
    DECLARE recommended_departments TEXT;
    DECLARE highest_score FLOAT(3,3);
    DECLARE v_current_level VARCHAR(15);
    DECLARE report_text TEXT;
    DECLARE student_name VARCHAR(32);
    DECLARE total_students INT;
    DECLARE student_rank INT;
    DECLARE percentile FLOAT;

    -- Calculate average score
    SELECT AVG(score) INTO average_score
    FROM Placement_tests
    WHERE student_id = NEW.student_id;

    -- Identify best subject
    SELECT subject INTO best_subject
    FROM Subjects
    WHERE id = (SELECT subject_id 
                FROM Placement_tests 
                WHERE student_id = NEW.student_id
                ORDER BY score DESC LIMIT 1);

    -- Determine highest score and proficiency level
    SELECT MAX(score) INTO highest_score
    FROM Placement_tests 
    WHERE student_id = NEW.student_id;

    IF highest_score >= 0.85 AND highest_score <= 0.99 THEN
        SET v_current_level = 'Advanced';
    ELSEIF highest_score >= 0.50 AND highest_score < 0.85 THEN
        SET v_current_level = 'Intermediate';
    ELSEIF highest_score < 0.50 THEN
        SET v_current_level = 'Beginner';
    END IF;

    -- Recommend departments based on subjects
    SELECT GROUP_CONCAT(name SEPARATOR ', ') INTO recommended_departments
    FROM Departments
    WHERE id IN (
        SELECT DISTINCT department_id
        FROM Courses
        JOIN Course_Subjects ON Courses.id = Course_Subjects.course_id
        WHERE subject_id IN (
            SELECT subject_id
            FROM Placement_tests
            WHERE student_id = NEW.student_id
            ORDER BY score DESC LIMIT 3
        )
    );

    -- Get student name
    SELECT name INTO student_name 
    FROM Students 
    WHERE id = NEW.student_id;

    -- Calculate total students and student's rank
    SELECT COUNT(*) INTO total_students 
    FROM Students;

    SELECT COUNT(DISTINCT student_id) + 1 INTO student_rank
    FROM Placement_tests 
    WHERE AVG(score) > (SELECT AVG(score) FROM Placement_tests WHERE student_id = NEW.student_id);

    -- Calculate percentile
    SET percentile = (total_students - student_rank + 1) / total_students * 100;

    -- Create report text with percentile message
    IF percentile > 50 THEN
        SET report_text = CONCAT(
            student_name, ', here is your test report: ',
            'Your average score is ', average_score, '. ',
            'Your best subject is ', best_subject, '. ',
            'Based on your scores, we recommend the following departments: ', recommended_departments, '. ',
            'You rank ', student_rank, ' out of ', total_students, ' students. ',
            'Proficiency Level: ', v_current_level, '. ',
            'Keep up the good work! Your score beats more than ', ROUND(percentile, 2), '% of other students. ',
            'For improvements, focus on the subjects where you scored lower.'
        );
    ELSE
        SET report_text = CONCAT(
            student_name, ', here is your test report: ',
            'Your average score is ', average_score, '. ',
            'Your best subject is ', best_subject, '. ',
            'Based on your scores, we recommend the following departments: ', recommended_departments, '. ',
            'You rank ', student_rank, ' out of ', total_students, ' students. ',
            'Proficiency Level: ', v_current_level, '. ',
            'Keep working hard and improving your scores! You have great potential. Focus on the subjects where you scored lower to see better results.'
        );
    END IF;

    -- Insert into recommendations table
    INSERT INTO Recommendations (student_id, recommended_department_id, report) 
    VALUES (NEW.student_id, (SELECT id FROM Departments WHERE name = best_subject LIMIT 1), report_text);
END//
DELIMITER ;


--#############     COMMIT LOGS     ########################## 

-- Added a trigger 'add_student_recommendations' to automatically generate and insert a detailed report into the 'Recommendations' table after each new placement test.
-- The report includes the student's average score, best subject, recommended departments, proficiency level, and a percentile message comparing the student's score with others.
-- If the student's average score is higher than 50% of other students, the report states "Your score beats more than XX% of other students."
-- If the score is lower than 50%, the report includes a motivational message encouraging the student to keep working hard and improve their scores.

