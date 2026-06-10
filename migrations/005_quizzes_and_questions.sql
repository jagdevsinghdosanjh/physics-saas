USE physics_saas;

-- QUIZZES TABLE
DROP TABLE IF EXISTS `quizzes`;
CREATE TABLE `quizzes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `lesson_id` bigint UNSIGNED NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_marks` int UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_quizzes_lesson` (`lesson_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- QUESTIONS TABLE
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `quiz_id` bigint UNSIGNED NOT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_type` enum('mcq_single','mcq_multi','integer','subjective') COLLATE utf8mb4_unicode_ci NOT NULL,
  `marks` int UNSIGNED NOT NULL DEFAULT '1',
  `sort_order` int UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_questions_quiz` (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- QUESTION OPTIONS TABLE
DROP TABLE IF EXISTS `question_options`;
CREATE TABLE `question_options` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `question_id` bigint UNSIGNED NOT NULL,
  `option_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_options_question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- QUIZ ATTEMPTS TABLE
DROP TABLE IF EXISTS `quiz_attempts`;
CREATE TABLE `quiz_attempts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `quiz_id` bigint UNSIGNED NOT NULL,
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `submitted_at` datetime DEFAULT NULL,
  `score` int DEFAULT NULL,
  `status` enum('in_progress','submitted','evaluated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in_progress',
  PRIMARY KEY (`id`),
  KEY `fk_attempts_user` (`user_id`),
  KEY `fk_attempts_quiz` (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- QUIZ ANSWERS TABLE
DROP TABLE IF EXISTS `quiz_answers`;
CREATE TABLE `quiz_answers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `attempt_id` bigint UNSIGNED NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `selected_option_id` bigint UNSIGNED DEFAULT NULL,
  `answer_text` text COLLATE utf8mb4_unicode_ci,
  `is_correct` tinyint(1) DEFAULT NULL,
  `marks_awarded` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_answers_attempt` (`attempt_id`),
  KEY `fk_answers_question` (`question_id`),
  KEY `fk_answers_option` (`selected_option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
