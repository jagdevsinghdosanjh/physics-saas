USE physics_saas;

-- ============================
-- FOREIGN KEYS: api_keys
-- ============================
ALTER TABLE `api_keys`
  ADD CONSTRAINT `fk_apikeys_user`
    FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT;


-- ============================
-- FOREIGN KEYS: audit_logs
-- ============================
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;


-- ============================
-- FOREIGN KEYS: courses
-- ============================
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_courses_created_by`
    FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT;


-- ============================
-- FOREIGN KEYS: enrollments
-- ============================
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_enrollments_course`
    FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_enrollments_subscription`
    FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_enrollments_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: lessons
-- ============================
ALTER TABLE `lessons`
  ADD CONSTRAINT `fk_lessons_module`
    FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: lesson_progress
-- ============================
ALTER TABLE `lesson_progress`
  ADD CONSTRAINT `fk_progress_lesson`
    FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_progress_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: modules
-- ============================
ALTER TABLE `modules`
  ADD CONSTRAINT `fk_modules_course`
    FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: password_resets
-- ============================
ALTER TABLE `password_resets`
  ADD CONSTRAINT `fk_pwreset_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: payments
-- ============================
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_subscription`
    FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payments_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: questions
-- ============================
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_questions_quiz`
    FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: question_options
-- ============================
ALTER TABLE `question_options`
  ADD CONSTRAINT `fk_options_question`
    FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: quizzes
-- ============================
ALTER TABLE `quizzes`
  ADD CONSTRAINT `fk_quizzes_lesson`
    FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: quiz_answers
-- ============================
ALTER TABLE `quiz_answers`
  ADD CONSTRAINT `fk_answers_attempt`
    FOREIGN KEY (`attempt_id`) REFERENCES `quiz_attempts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_answers_option`
    FOREIGN KEY (`selected_option_id`) REFERENCES `question_options` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_answers_question`
    FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: quiz_attempts
-- ============================
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `fk_attempts_quiz`
    FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_attempts_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: sessions
-- ============================
ALTER TABLE `sessions`
  ADD CONSTRAINT `fk_sessions_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: subscriptions
-- ============================
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `fk_subscriptions_plan`
    FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_subscriptions_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


-- ============================
-- FOREIGN KEYS: user_roles
-- ============================
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_role`
    FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
