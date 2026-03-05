
USE ocean_view_resort;
SHOW CREATE TABLE users;
UPDATE users
SET password_hash = '310000:UhokL9rAMlacUaH6flnFLQ==:jH4gxZdUTXyqu/tW9nWyATK4meF6ajJt0e9w3oiSAIY=',
    active = 1
WHERE username = 'admin';
SELECT COUNT(*) AS cnt FROM users WHERE username = 'admin';
SELECT username, active, LENGTH(password_hash) AS len FROM users WHERE username = 'admin';
SELECT password_hash FROM users WHERE username = 'admin';
SELECT username, active, password_hash FROM users WHERE username = 'admin';
SELECT password_hash FROM users WHERE username = 'admin';

CREATE TABLE IF NOT EXISTS staff (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL,
  gender VARCHAR(20),
  nic VARCHAR(20),
  employee_id VARCHAR(50) NOT NULL,
  role VARCHAR(60) NOT NULL,
  hours_start TIME NOT NULL,
  hours_end TIME NOT NULL,
  status VARCHAR(20) NOT NULL,
  password_hash VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_staff_email (email),
  UNIQUE KEY uk_staff_employee (employee_id)
);

CREATE TABLE IF NOT EXISTS rooms (
  id INT AUTO_INCREMENT PRIMARY KEY,
  room_number VARCHAR(30) NOT NULL,
  room_type VARCHAR(60) NOT NULL,
  capacity INT NOT NULL,
  status VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uk_room_number (room_number)
);

CREATE TABLE IF NOT EXISTS bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  guest_name VARCHAR(120) NOT NULL,
  guest_email VARCHAR(160) NOT NULL,
  room_number VARCHAR(30) NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS room_rates (
  id INT AUTO_INCREMENT PRIMARY KEY,
  room_type VARCHAR(60) NOT NULL,
  season VARCHAR(60) NOT NULL,
  nightly_rate DECIMAL(10,2) NOT NULL,
  package_name VARCHAR(120),
  status VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS room_availability (
  id INT AUTO_INCREMENT PRIMARY KEY,
  room_number VARCHAR(30) NOT NULL,
  availability_status VARCHAR(20) NOT NULL,
  notes VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  booking_reference VARCHAR(50) NOT NULL,
  guest_name VARCHAR(120) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  method VARCHAR(30) NOT NULL,
  payment_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE room_availability DROP COLUMN availability_date;staff
ALTER TABLE staff ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255);
