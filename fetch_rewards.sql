DROP DATABASE IF EXISTS fetch_rewards;
CREATE DATABASE fetch_rewards;

DROP USER IF EXISTS fetch_user;
CREATE USER fetch_user WITH PASSWORD 'fetch_user';

GRANT ALL PRIVILEGES ON DATABASE fetch_rewards TO fetch_user;