USE physics_saas;

-- FOREIGN KEYS FOR api_keys
ALTER TABLE `api_keys`
  ADD CONSTRAINT `fk_apikeys_user`
    FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT;

-- FOREIGN KEYS FOR audit_logs
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

-- FOREIGN KEYS FOR password_resets
ALTER TABLE `password_resets`
  ADD CONSTRAINT `fk_pwreset_user`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
