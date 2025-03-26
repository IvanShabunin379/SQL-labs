-- 1. Логическое копирование таблицы. Команда COPY. Восстановление данных.

COPY participations_in_tournaments TO 'D:\backups\participations_in_tournaments.csv' WITH (FORMAT CSV, HEADER, 
														    ENCODING 'UTF8');
DELETE FROM participations_in_tournaments;

COPY participations_in_tournaments FROM 'D:\backups\participations_in_tournaments.csv' WITH (FORMAT CSV, HEADER,
																ENCODING 'UTF8');
SELECT * FROM participations_in_tournaments;



-- 2. Логическое копирование БД. Утилита pg_dump. Восстановление базы данных и отдельных объектов

pg_dump -U postgres -t participations_in_tournaments -f D:\backups\participations_in_tournaments.sql bookmaker

DROP TABLE participations_in_tournaments;

psql -U postgres -d bookmaker -f D:\backups\participations_in_tournaments.sql

SELECT * FROM participations_in_tournaments;

--

pg_dump -U postgres --create -F c -f D:\backups\backup_bookmaker.dump bookmaker

psql -U postgres -d postgres -c "DROP DATABASE bookmaker;"

pg_restore -U postgres -d postgres --create D:\backups\backup_bookmaker.dump

psql -U postgres -d bookmaker -c "SELECT * FROM participations_in_tournaments;"




-- 3. Логическое копирование кластера. Утилита pg_dumpall. Восстановление кластера.

pg_dumpall -U postgres -f D:\backups\all_databases_backup.dump

initDb -D "D:/PostgreSQL/16/data" --username=postgres

pg_ctl start -D "D:/PostgreSQL/16/data"

psql -U postgres -f D:\backups\all_databases_backup.dump

psql -U postgres -d bookmaker -c "SELECT * FROM users;"



-- 4. "Холодное" резервное копирование.

pg_ctl stop -D "D:/PostgreSQL/16/data"

xcopy "D:/PostgreSQL/16/data" "D:/full_cluster_backup/data" /E /I

pg_ctl start -D "D:/full_cluster_backup/data"

psql -U postgres -d bookmaker -c "SELECT * FROM users;"