-- ============================================================
--  Saint Raphael Hospital — RFID Patient Management
--  MySQL Schema  (run once to initialize the database)
-- ============================================================

CREATE DATABASE IF NOT EXISTS saint_raphael_hospital
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE saint_raphael_hospital;

-- ── PATIENTS ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS patients (
    id        INT           NOT NULL AUTO_INCREMENT,
    rfid      VARCHAR(32)   NOT NULL,
    name      VARCHAR(120)  NOT NULL,
    birthdate VARCHAR(20)   NOT NULL,   -- stored as MM/DD/YYYY
    age       TINYINT       NOT NULL,
    gender    ENUM('Male','Female') NOT NULL,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_rfid (rfid)
);

-- ── MEDICATIONS ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS medications (
    id         INT          NOT NULL AUTO_INCREMENT,
    patient_id INT          NOT NULL,
    medicine   VARCHAR(80)  NOT NULL,
    dosage     VARCHAR(20)  NOT NULL,
    schedule   VARCHAR(60)  NOT NULL,  -- human-readable date string
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id) REFERENCES patients (id)
        ON DELETE CASCADE
);

-- ── SAMPLE DATA (optional — remove for production) ──────
INSERT INTO patients (rfid, name, birthdate, age, gender) VALUES
  ('A4-B9-C2-D1', 'Juan dela Cruz',     '03/15/1985', 40, 'Male'),
  ('E8-F0-93-01', 'Maria Santos',       '07/22/1992', 33, 'Female'),
  ('3F-9A-00-CC', 'Pedro Reyes',        '11/08/1978', 46, 'Male');

INSERT INTO medications (patient_id, medicine, dosage, schedule) VALUES
  (1, 'Paracetamol',  '500 mg',  'May 1, 2025'),
  (1, 'Amoxicillin',  '250 mg',  'May 2, 2025'),
  (2, 'Metformin',    '500 mg',  'May 3, 2025');
