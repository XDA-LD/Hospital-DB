CREATE TABLE PATIENT (
	patient_id INT SERIAL PRIMARY KEY,
	patient_name VARCHAR(100) NOT NULL,
	date_of_birth DATE NOT NULL,
	sex VARCHAR(11) CHECK (sex in ('Male', 'Female', 'Unspecified')),
	medical_insurance VARCHAR(100),
	address_street VARCHAR(100),
	address_city VARCHAR(100),
	address_district VARCHAR(100),
	emergency_name VARCHAR(100),
	emergency_phone VARCHAR(30),
	CHECK (
		(emergency_name IS NULL AND emergency_phone IS NULL) OR 
		(emergency_name IS NOT NULL AND emergency_phone IS NOT NULL)
	)
)

CREATE TABLE PATIENT_ALLERGY (
	allergy VARCHAR(100),
	patient_id INT,
	PRIMARY KEY (allergy, patient_id),
	CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
)

CREATE TABLE PATIENT_EMAIL (
	email VARCHAR(100),
	patient_id INT,
	PRIMARY KEY (email, patient_id),
	CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
)

CREATE TABLE PATIENT_PHONE (
	phone_number VARCHAR(30),
	patient_id INT,
	PRIMARY KEY (phone_number, patient_id),
	CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
)

CREATE TABLE PREEXISTING_CONDITION (
	patient_condition VARCHAR(100),
	patient_id INT,
	PRIMARY KEY (patient_condition, patient_id),
	CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id)
)

CREATE TABLE DOCTOR (
	doctor_id SERIAL INT PRIMARY KEY,
	doctor_name VARCHAR(100) NOT NULL,
	medical_expertise VARCHAR(100) NOT NULL,
	license_number VARCHAR(50) NOT NULL,
	address_street VARCHAR(100),
	address_city VARCHAR(100),
	address_district VARCHAR(100)
)

CREATE TABLE DOCTOR_EMAIL (
	email VARCHAR(100),
	doctor_id INT,
	PRIMARY KEY (email, doctor_id),
	CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
)
1
CREATE TABLE DOCTOR_PHONE (
	phone_number VARCHAR(30),
	doctor_id INT,
	PRIMARY KEY (phone_number, doctor_id),
	CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
)

CREATE TABLE APPOINTMENT (
	appointment_id SERIAL INT,
	date_time DATE NOT NULL,
	reason VARCHAR(255),
	patient_id INT,
	doctor_id INT,
	PRIMARY KEY (appointment_id),
	CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
	CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
)

CREATE TABLE TREATMENT (
	treatment_id SERIAL INT,
	appointment_id INT,
	diagnosis VARCHAR(255) NOT NULL,
	PRIMARY KEY (treatment_id, appointment_id),
	CONSTRAINT fk_appointment FOREIGN KEY (appointment_id) REFERENCES APPOINTMENT(appointment_id)
)

CREATE TABLE PRESCRIPTION (
	prescription_id SERIAL INT,
	treatment_id INT,
	appointment_id INT,
	date DATE NOT NULL,
	drug_name VARCHAR(100) NOT NULL,
	dosage FLOAT NOT NULL,
	PRIMARY KEY (prescription_id, treatment_id, appointment_id),
	FOREIGN KEY (treatment_id, appointment_id) REFERENCES TREATMENT(treatment_id, appointment_id)
) -- SHOULD WE NAME THIS CONSTRAINT TOO? THIS SEEMS VERY SPECIFIC

CREATE TABLE MEDICAL_CARE (
	description VARCHAR(255),
	treatment_id INT,
	appointment_id INT,
	date DATE NOT NULL,
	PRIMARY KEY (description, treatment_id, appointment_id),
	FOREIGN KEY (treatment_id, appointment_id) REFERENCES TREATMENT(treatment_id, appointment_id)
)

CREATE TABLE BILL (
	bill_id SERIAL INT PRIMARY KEY,
	appointment_id INT,
	medical_service VARCHAR(100) NOT NULL,
	amount FLOAT NOT NULL,
	payment_method VARCHAR(15) CHECK (payment_method IN ('Cash', 'Credit Card', 'Insurance')),
	paid BOOLEAN,
	FOREIGN KEY (appointment_id) REFERENCES APPOINTMENT(appointment_id)
)