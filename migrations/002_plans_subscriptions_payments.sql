USE physics_saas;

-- PLANS TABLE
DROP TABLE IF EXISTS `plans`;
CREATE TABLE `plans` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price_in_paise` int UNSIGNED NOT NULL,
  `billing_period` enum('monthly','quarterly','yearly','lifetime') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- SUBSCRIPTIONS TABLE
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `status` enum('active','expired','cancelled','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `razorpay_sub_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_subscriptions_user` (`user_id`),
  KEY `fk_subscriptions_plan` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- PAYMENTS TABLE
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `subscription_id` bigint UNSIGNED DEFAULT NULL,
  `razorpay_order_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razorpay_payment_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razorpay_signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_in_paise` int UNSIGNED NOT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INR',
  `status` enum('created','authorized','captured','failed','refunded') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_payments_user` (`user_id`),
  KEY `fk_payments_subscription` (`subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
