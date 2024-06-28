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
-- IMPLEMENTING TRIGGER FOR RECOMENDATIONS INSERITION BASED ON ANY UPDATE ON THE PLACEMENT_TEST TABLE


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

    -- Calculate average score
    SELECT AVG(score) INTO average_score  -- CALCULATES THE AVG SCORE IN ALL THE PLACEMENT TESTS TAKEN BY THE 
    FROM Placement_tests                  -- STUDENT AND THEN ASSIGNS IT TO average_score.
    WHERE student_id = NEW.student_id;

    -- Identify best subject
    SELECT subject INTO best_subject      -- IDENTIFIES THE BEST SUBJECT BY QUERYING ON THE SUBJECTS TABLE AND SELECTION THE SUBJECT WITH THE HIGHEST SCORE. 
    FROM Subjects 
    WHERE id = (SELECT subject_id 
                FROM Placement_tests 
                WHERE student_id = NEW.student_id
                ORDER BY score DESC LIMIT 1);

    -- Determine highest score and proficiency level
    SELECT MAX(score) INTO highest_score  -- FINDS THE HIGHEST SCORE FROM THE PLACEMENT TESTS TAKEN BY THE STUDENT AND THEN ASSIGNS THE APPROPRIATE PROFIECIENCY LEVEL
    FROM Placement_tests 
    WHERE student_id = NEW.student_id;

    IF highest_score >= 90 AND highest_score <= 100 THEN
        SET v_current_level = 'Advanced';
    ELSEIF highest_score >= 65 AND highest_score < 90 THEN
        SET v_current_level = 'Intermediate';
    ELSEIF highest_score < 65 THEN
        SET v_current_level = 'Beginner';
    END IF;

    -- Recommend departments based on subjects
    SELECT GROUP_CONCAT(name SEPARATOR ', ') INTO recommended_departments
    FROM Departments        -- THIS GETS THE DEPARTMENTS OF THE SUBECTS IN WHICH THE STUDENT SCORED GOOD AND CONCATENATES THEM INTO A STRING/TEXT
    WHERE id IN (
        SELECT DISTINCT department_id
        FROM Courses
        JOIN Course_Subjects ON Courses.id = Course_Subjects.course_id
        WHERE subject_id IN (
            SELECT subject_id
            FROM Placement_tests
            WHERE student_id = NEW.student_id
            ORDER BY score DESC LIMIT 3 -- LIMITING IT TO GIVE THE TOP 3 RECOMMENDED DEPARTMENTS
        )
    );

    -- Create report text
    SET report_text = CONCAT(  -- THIS MAKES THE REPORT
        'Average Score: ', average_score, 
        ', Best Subject: ', best_subject,
        ', Recommended Departments: ', recommended_departments
    );

    -- Insert into recommendations table
    INSERT INTO Recommendations (student_id, recommended_department_id, report) 
    VALUES (NEW.student_id, (SELECT id FROM Departments WHERE name = best_subject LIMIT 1), report_text);
END//
DELIMITER ;




-- TODO FOR SAAD

-- Create a trigger that would insert into recommendations table
-- understand the below conditional
-- IF highest_score >= 90 AND highest_score <= 100 THEN
        --     SET v_current_level = 'Advanced';
        -- ELSEIF highest_score >= 65 AND highest_score < 90 THEN
        --     SET v_current_level = 'Intermediate';
        -- ELSEIF highest_score < 65 THEN
        --     SET v_current_level = 'Beginner';
        -- END IF;
-- Now in report that is of type text consider the mention the following :
    -- student's average score (no of subjects/ sum of all score in all subjects)
    -- student's best subject
    -- recommended departments(check scores in different subjects) to do this.
        -- FOR example if the student scored best in subjects "Computer Science", "Matematics", "Engineering Design" ,
        -- "physics" than recommed departments like physics, computer science, mathematics
    
-- Lastly remember that this report is a column in recommendations table, and this is a TEXT type, you will need to
-- concatinate TEXT to from a report
-- you have free hand to add anything meaning full you'd like to the report.


  