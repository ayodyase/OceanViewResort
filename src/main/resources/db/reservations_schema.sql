CREATE TABLE IF NOT EXISTS reservations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  reservation_number VARCHAR(50) NOT NULL,
  guest_name VARCHAR(120) NOT NULL,
  address VARCHAR(200) NOT NULL,
  contact_number VARCHAR(40) NOT NULL,
  room_type VARCHAR(40) NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uk_reservation_number (reservation_number)
);
