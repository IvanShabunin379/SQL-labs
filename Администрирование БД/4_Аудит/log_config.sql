-- Сбросить все параметры.
RESET ALL;

-- Перезагрузить конфигурацию.
SELECT pg_reload_conf();

-- Посмотреть настройки.
SELECT name, setting
FROM pg_settings
WHERE name IN ('lc_messages',
               'logging_collector',
               'log_statement');

-- Установить локализацию на английский.
SET lc_messages = 'en_US.UTF-8';

-- Включить запись логов.
SET logging_collector = on;

-- Логировать команды, изменяющие данные.
SET log_statement = 'mod';



