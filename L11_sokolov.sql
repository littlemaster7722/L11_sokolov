--
-- ���� ������������ � ������� SQLiteStudio v3.4.17 � �� ��� 25 03:27:10 2025
--
-- �������������� ��������� ������: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- �������: achievements
CREATE TABLE IF NOT EXISTS achievements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    points_required INTEGER DEFAULT 0
);
INSERT INTO achievements (id, title, description, points_required) VALUES (1, '������ ���', '������� ������ ���������������������', 1);
INSERT INTO achievements (id, title, description, points_required) VALUES (2, '��������������', '������� 10 ������ ����', 10);
INSERT INTO achievements (id, title, description, points_required) VALUES (3, '�������', '������� 50 ������ ����', 50);
INSERT INTO achievements (id, title, description, points_required) VALUES (4, '�������� ������', '������� 5 ������', 5);
INSERT INTO achievements (id, title, description, points_required) VALUES (5, '�������', '������� 10 ������������ ����', 10);

-- �������: location_tag
CREATE TABLE IF NOT EXISTS location_tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);
INSERT INTO location_tag (id, name) VALUES (1, '��������');
INSERT INTO location_tag (id, name) VALUES (2, '�����');
INSERT INTO location_tag (id, name) VALUES (3, '����');
INSERT INTO location_tag (id, name) VALUES (4, '�����������');
INSERT INTO location_tag (id, name) VALUES (5, '������������ �����');

-- �������: location_to_tag
CREATE TABLE IF NOT EXISTS location_to_tag (
    location_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (location_id, tag_id),
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (tag_id) REFERENCES location_tag(id)
);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (1, 4);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (1, 5);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (2, 2);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (2, 5);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (3, 3);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (3, 4);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (3, 5);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (4, 5);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (5, 3);
INSERT INTO location_to_tag (location_id, tag_id) VALUES (5, 5);

-- �������: locations
CREATE TABLE IF NOT EXISTS locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    latitude REAL,
    longitude REAL
);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (1, '������', '������������ ����� ������', 55.751244, 37.618423);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (2, '�������', '���������� ����� ������', 59.939095, 30.315868);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (3, '��������', '��������-�������� ��������', 59.885147, 29.907562);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (4, '������� �������', '������� ������� ������', 55.75393, 37.620795);
INSERT INTO locations (id, name, description, latitude, longitude) VALUES (5, '����� ������', '����� �������� ����� � ����', 53.506456, 108.014375);

-- �������: notification_frequencies
CREATE TABLE IF NOT EXISTS notification_frequencies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    frequency TEXT NOT NULL CHECK(frequency IN ('daily', 'weekly', 'monthly', 'never'))
);
INSERT INTO notification_frequencies (id, frequency) VALUES (1, 'daily');
INSERT INTO notification_frequencies (id, frequency) VALUES (2, 'weekly');
INSERT INTO notification_frequencies (id, frequency) VALUES (3, 'monthly');
INSERT INTO notification_frequencies (id, frequency) VALUES (4, 'never');

-- �������: roles
CREATE TABLE IF NOT EXISTS roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);
INSERT INTO roles (id, name) VALUES (1, 'user');
INSERT INTO roles (id, name) VALUES (2, 'moderator');
INSERT INTO roles (id, name) VALUES (3, 'admin');

-- �������: user_achievements
CREATE TABLE IF NOT EXISTS user_achievements (
    user_id INTEGER NOT NULL,
    achievement_id INTEGER NOT NULL,
    achieved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(id)
);
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (1, 1, '2025-06-20 15:24:46');
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (1, 4, '2025-06-20 15:24:46');
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (2, 1, '2025-06-20 15:24:46');
INSERT INTO user_achievements (user_id, achievement_id, achieved_at) VALUES (2, 2, '2025-06-20 15:24:46');

-- �������: users
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    telegram_id INTEGER UNIQUE NOT NULL,
    username TEXT,
    gender TEXT CHECK(gender IN ('male', 'female', 'other')),
    notification_frequency_id INTEGER,
    notification_time TEXT,
    role_id INTEGER NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (notification_frequency_id) REFERENCES notification_frequencies(id)
);
INSERT INTO users (id, telegram_id, username, gender, notification_frequency_id, notification_time, role_id) VALUES (1, 123456789, 'ivan_petrov', 'male', 1, '09:00', 1);
INSERT INTO users (id, telegram_id, username, gender, notification_frequency_id, notification_time, role_id) VALUES (2, 987654321, 'anna_smith', 'female', 2, '18:30', 1);
INSERT INTO users (id, telegram_id, username, gender, notification_frequency_id, notification_time, role_id) VALUES (3, 555555555, 'admin_bot', 'other', 4, NULL, 3);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
