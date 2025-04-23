CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

DROP TABLE IF EXISTS Drug_Presc;
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Sells;

DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Drugs;
DROP TABLE IF EXISTS Pharmacy;

DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Company;

CREATE TABLE Doctor (
    Doc_Aadhar_ID INT PRIMARY KEY,
    Name VARCHAR(40),
    Specialty VARCHAR(40),
    Experience INT
);

DROP PROCEDURE IF EXISTS AddDoctor;

DELIMITER //
CREATE PROCEDURE AddDoctor (
    IN id INT, IN name VARCHAR(40), IN spec VARCHAR(40), IN exp INT
)
BEGIN
    INSERT INTO Doctor VALUES (id, name, spec, exp);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteDoctor;

DELIMITER //
CREATE PROCEDURE DeleteDoctor (IN id INT)
BEGIN
    DELETE FROM Doctor WHERE Doc_Aadhar_ID = id;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateDoctorExperience;

DELIMITER //
CREATE PROCEDURE UpdateDoctorExperience (
    IN id INT, IN new_exp INT
)
BEGIN
    UPDATE Doctor SET Experience = new_exp WHERE Doc_Aadhar_ID = id;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateDoctor;

DELIMITER //
CREATE PROCEDURE UpdateDoctor (
    IN id INT,
    IN new_name VARCHAR(40),
    IN new_specialty VARCHAR(40),
    IN new_experience INT
)
BEGIN
    UPDATE Doctor
    SET Name = new_name,
        Specialty = new_specialty,
        Experience = new_experience
    WHERE Doc_Aadhar_ID = id;
END;
//

DELIMITER ;
CREATE TABLE Patient (
    Patient_Aadhar_ID INT PRIMARY KEY,
    Name VARCHAR(40),
    Age INT,
    Address VARCHAR(40),
    Primary_Physician INT,
    FOREIGN KEY (Primary_Physician) REFERENCES Doctor(Doc_Aadhar_ID)
);

DROP PROCEDURE IF EXISTS AddPatient;

DELIMITER //
CREATE PROCEDURE AddPatient (
    IN id INT, IN name VARCHAR(40), IN age INT, IN addr VARCHAR(40), IN doc_id INT
)
BEGIN
    INSERT INTO Patient VALUES (id, name, age, addr, doc_id);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeletePatient;

DELIMITER //
CREATE PROCEDURE DeletePatient (IN id INT)
BEGIN
    DELETE FROM Patient WHERE Patient_Aadhar_ID = id;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdatePatient;

DELIMITER //
CREATE PROCEDURE UpdatePatient (
    IN id INT,
    IN new_name VARCHAR(40),
    IN new_age INT,
    IN new_address VARCHAR(40),
    IN new_physician INT
)
BEGIN
    UPDATE Patient
    SET Name = new_name,
        Age = new_age,
        Address = new_address,
        Primary_Physician = new_physician
    WHERE Patient_Aadhar_ID = id;
END;
//

DELIMITER ;
CREATE TABLE Prescription (
    Doctor INT,
    Patient INT,
    PrescriptionDate DATE,
    PRIMARY KEY (Doctor, Patient, PrescriptionDate),
    FOREIGN KEY (Doctor) REFERENCES Doctor(Doc_Aadhar_ID),
    FOREIGN KEY (Patient) REFERENCES Patient(Patient_Aadhar_ID)
);

DELIMITER ;
DROP PROCEDURE IF EXISTS AddPrescription;

DELIMITER //
CREATE PROCEDURE AddPrescription (
    IN doc INT, IN pat INT, IN date_presc DATE
)
BEGIN
    INSERT INTO Prescription VALUES (doc, pat, date_presc);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdatePrescription;

DELIMITER //
CREATE PROCEDURE UpdatePrescription (
    IN doc_id INT,
    IN pat_id INT,
    IN old_date DATE,
    IN new_date DATE
)
BEGIN
    UPDATE Prescription
    SET PrescriptionDate = new_date
    WHERE Doctor = doc_id AND Patient = pat_id AND PrescriptionDate = old_date;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeletePrescription;

DELIMITER //
CREATE PROCEDURE DeletePrescription (
    IN doc_id INT,
    IN pat_id INT,
    IN presc_date DATE
)
BEGIN
    DELETE FROM Prescription
    WHERE Doctor = doc_id AND Patient = pat_id AND PrescriptionDate = presc_date;
END;
//

DELIMITER ;
CREATE TABLE Company (
    CompanyName VARCHAR(40) PRIMARY KEY,
    PhoneNo BIGINT
);

DELIMITER ;
DROP PROCEDURE IF EXISTS AddCompany;

DELIMITER //
CREATE PROCEDURE AddCompany (
    IN name VARCHAR(40), IN phone BIGINT
)
BEGIN
    INSERT INTO Company VALUES (name, phone);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteCompany;

DELIMITER //
CREATE PROCEDURE DeleteCompany (
    IN company_name VARCHAR(40)
)
BEGIN
    DELETE FROM Company WHERE CompanyName = company_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateCompany;

DELIMITER //
CREATE PROCEDURE UpdateCompany (
    IN company_name VARCHAR(40),
    IN new_phone BIGINT
)
BEGIN
    UPDATE Company
    SET PhoneNo = new_phone
    WHERE CompanyName = company_name;
END;
//

DELIMITER ;
CREATE TABLE Drugs (
    CompanyNameDrugs VARCHAR(40),
    TradeName VARCHAR(40),
    Formula VARCHAR(40),
    PRIMARY KEY (CompanyNameDrugs, TradeName),
    FOREIGN KEY (CompanyNameDrugs) REFERENCES Company(CompanyName)
);

DELIMITER ;
DROP PROCEDURE IF EXISTS AddDrug;

DELIMITER //
CREATE PROCEDURE AddDrug (
    IN company VARCHAR(40), IN tradename VARCHAR(40), IN formula VARCHAR(40)
)
BEGIN
    INSERT INTO Drugs VALUES (company, tradename, formula);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteDrug;

DELIMITER //
CREATE PROCEDURE DeleteDrug (IN comp VARCHAR(40), IN tradename VARCHAR(40))
BEGIN
    DELETE FROM Drugs WHERE CompanyNameDrugs = comp AND TradeName = tradename;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateDrug;

DELIMITER //
CREATE PROCEDURE UpdateDrug (
    IN comp_name VARCHAR(40),
    IN trade_name VARCHAR(40),
    IN new_formula VARCHAR(40)
)
BEGIN
    UPDATE Drugs
    SET Formula = new_formula
    WHERE CompanyNameDrugs = comp_name AND TradeName = trade_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS GetDrugsByCompany;

DELIMITER //
CREATE PROCEDURE GetDrugsByCompany (
    IN company_name VARCHAR(40)
)
BEGIN
    SELECT
        TradeName,
        Formula
    FROM
        Drugs
    WHERE
        CompanyNameDrugs = company_name;
END;
//

DELIMITER ;
CREATE TABLE Drug_Presc (
    DoctorPrescribed INT,
    PatientPrescribed INT,
    CompanyNameDrugPresc VARCHAR(40),
    TradeNameDrugPresc VARCHAR(40),
    DatePrescribed DATE,
    Quantity INT,
    PRIMARY KEY (DoctorPrescribed, PatientPrescribed, CompanyNameDrugPresc, TradeNameDrugPresc),
    FOREIGN KEY (DoctorPrescribed, PatientPrescribed, DatePrescribed)
        REFERENCES Prescription(Doctor, Patient, PrescriptionDate),
    FOREIGN KEY (CompanyNameDrugPresc, TradeNameDrugPresc)
        REFERENCES Drugs(CompanyNameDrugs, TradeName)
);

DELIMITER ;
DROP PROCEDURE IF EXISTS AddDrugToPrescription;

DELIMITER //
CREATE PROCEDURE AddDrugToPrescription (
    IN doc INT, IN pat INT, IN comp VARCHAR(40), IN tradename VARCHAR(40), IN date_presc DATE, IN qty INT
)
BEGIN
    INSERT INTO Drug_Presc VALUES (doc, pat, comp, tradename, date_presc, qty);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteDrugFromPrescription;

DELIMITER //
CREATE PROCEDURE DeleteDrugFromPrescription (
    IN doc_id INT,
    IN pat_id INT,
    IN comp_name VARCHAR(40),
    IN trade_name VARCHAR(40)
)
BEGIN
    DELETE FROM Drug_Presc
    WHERE DoctorPrescribed = doc_id
      AND PatientPrescribed = pat_id
      AND CompanyNameDrugPresc = comp_name
      AND TradeNameDrugPresc = trade_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateDrugInPrescription;

DELIMITER //
CREATE PROCEDURE UpdateDrugInPrescription (
    IN doc_id INT,
    IN pat_id INT,
    IN comp_name VARCHAR(40),
    IN trade_name VARCHAR(40),
    IN new_quantity INT
)
BEGIN
    UPDATE Drug_Presc
    SET Quantity = new_quantity
    WHERE DoctorPrescribed = doc_id
      AND PatientPrescribed = pat_id
      AND CompanyNameDrugPresc = comp_name
      AND TradeNameDrugPresc = trade_name;
END;
//

DELIMITER ;
CREATE TABLE Pharmacy (
    PharmName VARCHAR(40) PRIMARY KEY,
    Address VARCHAR(40),
    PhoneNoPharmacy VARCHAR(40)
);

DELIMITER ;
DROP PROCEDURE IF EXISTS AddPharmacy;

DELIMITER //
CREATE PROCEDURE AddPharmacy (
    IN name VARCHAR(40), IN addr VARCHAR(40), IN phone VARCHAR(40)
)
BEGIN
    INSERT INTO Pharmacy VALUES (name, addr, phone);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeletePharmacy;

DELIMITER //
CREATE PROCEDURE DeletePharmacy (IN name VARCHAR(40))
BEGIN
    DELETE FROM Pharmacy WHERE PharmName = name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdatePharmacy;

DELIMITER //
CREATE PROCEDURE UpdatePharmacy (
    IN pharm_name VARCHAR(40),
    IN new_address VARCHAR(40),
    IN new_phone VARCHAR(40)
)
BEGIN
    UPDATE Pharmacy
    SET Address = new_address,
        PhoneNoPharmacy = new_phone
    WHERE PharmName = pharm_name;
END;
//

DELIMITER ;
CREATE TABLE Sells (
    PharmacyName VARCHAR(40),
    CompanyNameSells VARCHAR(40),
    TradeName VARCHAR(40),
    Price DECIMAL(10,2),
    PRIMARY KEY (PharmacyName, CompanyNameSells, TradeName),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(PharmName),
    FOREIGN KEY (CompanyNameSells, TradeName) REFERENCES Drugs(CompanyNameDrugs, TradeName)
);

DROP PROCEDURE IF EXISTS AddSells;

DELIMITER //
CREATE PROCEDURE AddSells (
    IN pharm VARCHAR(40),
    IN comp VARCHAR(40),
    IN drug VARCHAR(40),
    IN price DECIMAL(10,2)
)
BEGIN
    INSERT INTO Sells VALUES (pharm, comp, drug, price);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteSells;

DELIMITER //
CREATE PROCEDURE DeleteSells (
    IN pharm_name VARCHAR(40),
    IN comp_name VARCHAR(40),
    IN tradename VARCHAR(40)
)
BEGIN
    DELETE FROM Sells WHERE PharmacyName = pharm_name  AND CompanyNameSells = comp_name AND TradeName = tradename;
END;

//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateSells;

DELIMITER //
CREATE PROCEDURE UpdateSells (
    IN pharm_name VARCHAR(40),
    IN comp_name VARCHAR(40),
    IN tradename VARCHAR(40),
    IN new_price DECIMAL(10,2)
)
BEGIN
    UPDATE Sells SET Price = new_price WHERE PharmacyName = pharm_name  AND CompanyNameSells = comp_name AND TradeName = tradename;
END;

//

DELIMITER ;
CREATE TABLE Contract (
    PharmacyContract VARCHAR(40),
    CompanyNameContract VARCHAR(40),
    Supervisor VARCHAR(40),
    Content VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (PharmacyContract, CompanyNameContract),
    FOREIGN KEY (PharmacyContract) REFERENCES Pharmacy(PharmName),
    FOREIGN KEY (CompanyNameContract) REFERENCES Company(CompanyName)
);

DELIMITER ;
DROP PROCEDURE IF EXISTS AddContract;

DELIMITER //
CREATE PROCEDURE AddContract (
    IN pharm VARCHAR(40), IN comp VARCHAR(40), IN supervisor VARCHAR(40), IN content VARCHAR(50), IN sdate DATE, IN edate DATE
)
BEGIN
    INSERT INTO Contract VALUES (pharm, comp, supervisor, content, sdate, edate);
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteContract;

DELIMITER //
CREATE PROCEDURE DeleteContract (
    IN pharm VARCHAR(40),
    IN comp VARCHAR(40)
)
BEGIN
    DELETE FROM Contract
    WHERE PharmacyContract = pharm AND CompanyNameContract = comp;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS UpdateContract;

DELIMITER //
CREATE PROCEDURE UpdateContract (
    IN pharm VARCHAR(40),
    IN comp VARCHAR(40),
    IN new_supervisor VARCHAR(40),
    IN new_content VARCHAR(50),
    IN new_start DATE,
    IN new_end DATE
)
BEGIN
    UPDATE Contract
    SET Supervisor = new_supervisor,
        Content = new_content,
        StartDate = new_start,
        EndDate = new_end
    WHERE PharmacyContract = pharm AND CompanyNameContract = comp;
END;
//

-- adders here
DELIMITER ;
DROP PROCEDURE IF EXISTS DeletePatientCascade;

DELIMITER //
CREATE PROCEDURE DeletePatientCascade (IN pat_id INT)
BEGIN
    DELETE FROM Drug_Presc WHERE PatientPrescribed = pat_id;
    DELETE FROM Prescription WHERE Patient = pat_id;
    DELETE FROM Patient WHERE Patient_Aadhar_ID = pat_id;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteDoctorCascade;

DELIMITER //
CREATE PROCEDURE DeleteDoctorCascade (IN doc_id INT)
BEGIN
    DELETE FROM Drug_Presc WHERE DoctorPrescribed = doc_id;
    DELETE FROM Prescription WHERE Doctor = doc_id;
    UPDATE Patient SET Primary_Physician = NULL WHERE Primary_Physician = doc_id;
    DELETE FROM Doctor WHERE Doc_Aadhar_ID = doc_id;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeleteCompanyCascade;

DELIMITER //
CREATE PROCEDURE DeleteCompanyCascade (IN comp_name VARCHAR(40))
BEGIN
    DELETE FROM Drug_Presc WHERE CompanyNameDrugPresc = comp_name;
    DELETE FROM Sells WHERE CompanyNameSells = comp_name;
    DELETE FROM Drugs WHERE CompanyNameDrugs = comp_name;
    DELETE FROM Contract WHERE CompanyNameContract = comp_name;
    DELETE FROM Company WHERE CompanyName = comp_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS DeletePharmacyCascade;

DELIMITER //
CREATE PROCEDURE DeletePharmacyCascade (IN pharm_name VARCHAR(40))
BEGIN
    DELETE FROM Sells WHERE PharmacyName = pharm_name;
    DELETE FROM Contract WHERE PharmacyContract = pharm_name;
    DELETE FROM Pharmacy WHERE PharmName = pharm_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS GetPrescriptionReport;

DELIMITER //
CREATE PROCEDURE GetPrescriptionReport (
    IN p_PatientID INT,
    IN p_StartDate DATE,
    IN p_EndDate DATE
)
BEGIN
    SELECT
        pr.PrescriptionDate,
        d.Name AS Doctor_Name,
        dp.TradeNameDrugPresc,
        dp.CompanyNameDrugPresc,
        dp.Quantity
    FROM
        Prescription pr
    JOIN
        Drug_Presc dp ON pr.Doctor = dp.DoctorPrescribed
                      AND pr.Patient = dp.PatientPrescribed
                      AND pr.PrescriptionDate = dp.DatePrescribed
    JOIN
        Doctor d ON pr.Doctor = d.Doc_Aadhar_ID
    WHERE
        pr.Patient = p_PatientID
        AND pr.PrescriptionDate BETWEEN p_StartDate AND p_EndDate
    ORDER BY
        pr.PrescriptionDate;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS GetPrescriptionDetails;

DELIMITER //
CREATE PROCEDURE GetPrescriptionDetails (
    IN p_PatientID INT,
    IN p_PrescriptionDate DATE
)
BEGIN
    SELECT
        d.Name AS Doctor_Name,
        dp.TradeNameDrugPresc,
        dp.CompanyNameDrugPresc,
        dp.Quantity
    FROM
        Prescription pr
    JOIN
        Drug_Presc dp ON pr.Doctor = dp.DoctorPrescribed
                      AND pr.Patient = dp.PatientPrescribed
                      AND pr.PrescriptionDate = dp.DatePrescribed
    JOIN
        Doctor d ON pr.Doctor = d.Doc_Aadhar_ID
    WHERE
        pr.Patient = p_PatientID
        AND pr.PrescriptionDate = p_PrescriptionDate;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS GetPharmacyStock;

DELIMITER //
CREATE PROCEDURE GetPharmacyStock (
    IN pharmacy_name VARCHAR(40)
)
BEGIN
    SELECT
        s.CompanyNameSells AS Supplier_Company,
        d.TradeName AS Drug_TradeName,
        d.Formula AS Drug_Formula,
        s.Price
    FROM
        Sells s
    JOIN
        Drugs d ON s.CompanyNameSells = d.CompanyNameDrugs AND d.TradeName = s.TradeName
    WHERE
        s.PharmacyName = pharmacy_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS GetPharmacyCompanyContact;

DELIMITER //
CREATE PROCEDURE GetPharmacyCompanyContact (
    IN pharm_name VARCHAR(40),
    IN comp_name VARCHAR(40)
)
BEGIN
    SELECT
        p.PharmName AS Pharmacy,
        p.PhoneNoPharmacy AS Pharmacy_Contact,
        c.CompanyName AS Company,
        c.PhoneNo AS Company_Contact
    FROM
        Pharmacy p
    JOIN
        Contract ct ON ct.PharmacyContract = p.PharmName
    JOIN
        Company c ON ct.CompanyNameContract = c.CompanyName
    WHERE
        p.PharmName = pharm_name
        AND c.CompanyName = comp_name;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS GetPatientsForDoctor;

DELIMITER //
CREATE PROCEDURE GetPatientsForDoctor (
    IN doc_id INT
)
BEGIN
    SELECT
        Patient_Aadhar_ID,
        Name AS Patient_Name,
        Age,
        Address
    FROM
        Patient
    WHERE
        Primary_Physician = doc_id;
END;
//

DELIMITER ;
DROP PROCEDURE IF EXISTS PrintDemo;

DELIMITER //
CREATE PROCEDURE PrintDemo (
    IN message VARCHAR(300)
)
BEGIN
    SELECT message as TITLE_OF_TABLE;
END;
//

DELIMITER ;
CALL AddDoctor(1001, 'Dr. Meera Rao', 'Cardiology', 15);
CALL AddDoctor(1002, 'Dr. Anand Roy', 'Neurology', 12);
CALL AddDoctor(1003, 'Dr. Pooja Nair', 'Dermatology', 9);
CALL AddDoctor(1004, 'Dr. Rohan Gupta', 'Pediatrics', 7);
CALL AddDoctor(1005, 'Dr. Kavita Iyer', 'Orthopedics', 10);
CALL AddDoctor(1006, 'Dr. Nilesh Pandey', 'Gastroenterology', 14);
CALL AddDoctor(1007, 'Dr. Swati Kulkarni', 'Psychiatry', 10);
CALL AddDoctor(1008, 'Dr. Abhay Rao', 'ENT', 9);

CALL AddPatient(2001, 'Amit Shah', 45, 'Hyderabad', 1001);
CALL AddPatient(2002, 'Neha Verma', 30, 'Mumbai', 1002);
CALL AddPatient(2003, 'Ravi Menon', 55, 'Chennai', 1003);
CALL AddPatient(2004, 'Sneha Kapoor', 25, 'Delhi', 1004);
CALL AddPatient(2005, 'Manoj Iyer', 60, 'Bangalore', 1005);
CALL AddPatient(2006, 'Tina Joshi', 38, 'Pune', 1006);
CALL AddPatient(2007, 'Rohan Shetty', 50, 'Mumbai', 1007);
CALL AddPatient(2008, 'Farhan Khan', 28, 'Delhi', 1008);

CALL AddPatient(2011, 'Ritika Sen', 42, 'Secunderabad', 1001);
CALL AddPatient(2012, 'Suresh Rawat', 55, 'Warangal', 1001);

CALL AddPatient(2013, 'Leena Mehra', 35, 'Navi Mumbai', 1002);
CALL AddPatient(2014, 'Tarun Joshi', 28, 'Thane', 1002);

CALL AddPatient(2015, 'Karan Oberoi', 41, 'Coimbatore', 1003);
CALL AddPatient(2016, 'Divya Narang', 47, 'Madurai', 1003);

CALL AddPatient(2017, 'Simran Kaul', 10, 'Noida', 1004);
CALL AddPatient(2018, 'Arjun Reddy', 8, 'Gurgaon', 1004);

CALL AddPatient(2019, 'Nisha Thomas', 65, 'Mysore', 1005);
CALL AddPatient(2020, 'Naveen Jain', 70, 'Mangalore', 1005);

CALL AddPatient(2021, 'Rahul Saxena', 33, 'Nagpur', 1006);
CALL AddPatient(2022, 'Priya Dey', 39, 'Raipur', 1006);

CALL AddPatient(2023, 'Rajat Yadav', 52, 'Aurangabad', 1007);
CALL AddPatient(2024, 'Meera Pillai', 46, 'Nasik', 1007);

CALL AddPatient(2025, 'Rohit Verma', 32, 'Patna', 1008);
CALL AddPatient(2026, 'Shreya Sharma', 25, 'Ranchi', 1008);


CALL AddCompany('MediLife Ltd', 9988776655);
CALL AddCompany('PharmaCure', 9911223344);
CALL AddCompany('BioNova', 9900990011);
CALL AddCompany('WellnessCorp', 9800880077);
CALL AddCompany('ZenithPharma', 9777766655);
CALL AddCompany('NovaHealth', 9123456780);
CALL AddCompany('TruMedix', 9123456781);
CALL AddCompany('Genexa', 9123456782);
CALL AddCompany('GlobeMeds', 9123456783);

CALL AddDrug('MediLife Ltd', 'CardioX', 'Atorvastatin + Amlodipine');
CALL AddDrug('PharmaCure', 'NeuroFast', 'Piracetam');
CALL AddDrug('BioNova', 'BonePlus', 'Calcium + D3');
CALL AddDrug('WellnessCorp', 'WellKid', 'Multivitamin Syrup');
CALL AddDrug('ZenithPharma', 'SkinLite', 'Hydroquinone + Tretinoin');
CALL AddDrug('NovaHealth', 'GastroHeal', 'Omeprazole');
CALL AddDrug('TruMedix', 'MindCalm', 'Sertraline');
CALL AddDrug('Genexa', 'NasoRelief', 'Xylometazoline');
CALL AddDrug('GlobeMeds', 'OncoCare', 'Paclitaxel');

CALL AddDrug('MediLife Ltd', 'HeartMax', 'Bisoprolol + Aspirin');
CALL AddDrug('MediLife Ltd', 'CholestGuard', 'Rosuvastatin');

CALL AddDrug('PharmaCure', 'NeuroPlus', 'Donepezil');
CALL AddDrug('PharmaCure', 'MoodLift', 'Fluoxetine');

CALL AddDrug('BioNova', 'BoneBoost', 'Vitamin D3 + Calcium Citrate');
CALL AddDrug('BioNova', 'FlexiJoint', 'Glucosamine + MSM');

CALL AddDrug('WellnessCorp', 'ImmunoVita', 'Zinc + Vitamin C');
CALL AddDrug('WellnessCorp', 'LiverCare', 'Silymarin');

CALL AddDrug('ZenithPharma', 'SkinBright', 'Kojic Acid');
CALL AddDrug('ZenithPharma', 'AcneAway', 'Clindamycin + Benzoyl Peroxide');

CALL AddDrug('NovaHealth', 'DigestAid', 'Pancreatin');
CALL AddDrug('NovaHealth', 'GutRelief', 'Lactobacillus + Rifaximin');

CALL AddDrug('TruMedix', 'AnxioFree', 'Buspirone');
CALL AddDrug('TruMedix', 'NeuroZen', 'Amitriptyline');

CALL AddDrug('Genexa', 'AllerSafe', 'Levocetirizine');
CALL AddDrug('Genexa', 'ColdRelief', 'Paracetamol + Phenylephrine');

CALL AddDrug('GlobeMeds', 'ChemoCare', 'Doxorubicin');
CALL AddDrug('GlobeMeds', 'ImmunoBoost', 'Interferon Alfa');


CALL AddPharmacy('HealthPlus', 'Mumbai', '02233445566');
CALL AddPharmacy('CurePoint', 'Delhi', '01144332211');
CALL AddPharmacy('CityMeds', 'Chennai', '04455667788');
CALL AddPharmacy('MediStore', 'Bangalore', '08099887766');
CALL AddPharmacy('CareZone', 'Hyderabad', '04066778899');
CALL AddPharmacy('LifeMeds', 'Indore', '0731223344');
CALL AddPharmacy('VitalCare', 'Nagpur', '0712223344');
CALL AddPharmacy('MaxPharma', 'Kochi', '0484223344');

CALL AddPrescription(1001, 2001, '2025-04-20');
CALL AddPrescription(1002, 2002, '2025-04-21');
CALL AddPrescription(1003, 2003, '2025-04-22');
CALL AddPrescription(1004, 2004, '2025-04-23');
CALL AddPrescription(1005, 2005, '2025-04-24');
CALL AddPrescription(1006, 2006, '2025-05-01');
CALL AddPrescription(1007, 2007, '2025-05-02');
CALL AddPrescription(1008, 2008, '2025-05-03');

CALL AddDrugToPrescription(1001, 2001, 'MediLife Ltd', 'CardioX', '2025-04-20', 2);
CALL AddDrugToPrescription(1002, 2002, 'PharmaCure', 'NeuroFast', '2025-04-21', 1);
CALL AddDrugToPrescription(1003, 2003, 'BioNova', 'BonePlus', '2025-04-22', 2);
CALL AddDrugToPrescription(1004, 2004, 'WellnessCorp', 'WellKid', '2025-04-23', 3);
CALL AddDrugToPrescription(1005, 2005, 'ZenithPharma', 'SkinLite', '2025-04-24', 1);
CALL AddDrugToPrescription(1001, 2001, 'GlobeMeds', 'OncoCare', '2025-04-20', 1);
CALL AddDrugToPrescription(1001, 2001, 'PharmaCure', 'NeuroFast', '2025-04-20', 1);
CALL AddDrugToPrescription(1006, 2006, 'NovaHealth', 'GastroHeal', '2025-05-01', 2);
CALL AddDrugToPrescription(1006, 2006, 'MediLife Ltd', 'CardioX', '2025-05-01', 1);
CALL AddDrugToPrescription(1007, 2007, 'TruMedix', 'MindCalm', '2025-05-02', 2);
CALL AddDrugToPrescription(1008, 2008, 'Genexa', 'NasoRelief', '2025-05-03', 1);


CALL AddSells('HealthPlus', 'MediLife Ltd', 'CardioX', 150.00);
CALL AddSells('HealthPlus', 'MediLife Ltd', 'CholestGuard', 140.00);
CALL AddSells('HealthPlus', 'MediLife Ltd', 'HeartMax', 155.00);

CALL AddSells('CurePoint', 'PharmaCure', 'NeuroFast', 130.00);
CALL AddSells('CurePoint', 'PharmaCure', 'NeuroPlus', 125.00);
CALL AddSells('CurePoint', 'PharmaCure', 'MoodLift', 135.00);

CALL AddSells('CityMeds', 'BioNova', 'BonePlus', 120.00);
CALL AddSells('CityMeds', 'BioNova', 'BoneBoost', 110.00);
CALL AddSells('CityMeds', 'BioNova', 'FlexiJoint', 130.00);

CALL AddSells('MediStore', 'WellnessCorp', 'WellKid', 100.00);
CALL AddSells('MediStore', 'WellnessCorp', 'ImmunoVita', 95.00);
CALL AddSells('MediStore', 'WellnessCorp', 'LiverCare', 105.00);

CALL AddSells('CareZone', 'ZenithPharma', 'SkinLite', 90.00);
CALL AddSells('CareZone', 'ZenithPharma', 'SkinBright', 85.00);
CALL AddSells('CareZone', 'ZenithPharma', 'AcneAway', 92.00);

CALL AddSells('LifeMeds', 'NovaHealth', 'GastroHeal', 175.00);
CALL AddSells('LifeMeds', 'NovaHealth', 'DigestAid', 165.00);
CALL AddSells('LifeMeds', 'NovaHealth', 'GutRelief', 180.00);

CALL AddSells('VitalCare', 'TruMedix', 'MindCalm', 195.00);
CALL AddSells('VitalCare', 'TruMedix', 'AnxioFree', 190.00);
CALL AddSells('VitalCare', 'TruMedix', 'NeuroZen', 200.00);

CALL AddSells('MaxPharma', 'Genexa', 'NasoRelief', 160.00);
CALL AddSells('MaxPharma', 'Genexa', 'AllerSafe', 150.00);
CALL AddSells('MaxPharma', 'Genexa', 'ColdRelief', 165.00);



CALL AddContract('HealthPlus', 'MediLife Ltd', 'Ravi Kumar', 'Supply for cardio medications', '2025-01-01', '2025-12-31');
CALL AddContract('CurePoint', 'PharmaCure', 'Anil Mehta', 'Neuro supplies', '2025-02-01', '2025-12-31');
CALL AddContract('CityMeds', 'BioNova', 'Leela Thomas', 'Bone medication', '2025-01-15', '2025-11-15');
CALL AddContract('MediStore', 'WellnessCorp', 'Sunita Rao', 'Multivitamin support', '2025-03-01', '2025-12-01');
CALL AddContract('CareZone', 'ZenithPharma', 'Rajiv Das', 'Dermatology meds', '2025-04-01', '2025-12-31');
CALL AddContract('LifeMeds', 'NovaHealth', 'Kavita Menon', 'Gastro meds supply', '2025-05-01', '2025-12-31');
CALL AddContract('VitalCare', 'TruMedix', 'Manoj Thakur', 'Psychiatric supplies', '2025-05-05', '2025-11-30');
CALL AddContract('MaxPharma', 'Genexa', 'Jaya Mehta', 'ENT inventory support', '2025-06-01', '2025-12-31');


CALL PrintDemo('Doctor');
SELECT * FROM DOCTOR;

 CALL PrintDemo('Company');
SELECT * FROM COMPANY;

CALL PrintDemo('Patient');
SELECT * FROM PATIENT;

CALL PrintDemo('Pharmacy');
SELECT * FROM PHARMACY;

Call PrintDemo('Drugs');
SELECT * FROM DRUGS;

Call PrintDemo('Prescription');
SELECT * FROM PRESCRIPTION;

Call PrintDemo('Sells');
SELECT * FROM SELLS;

Call PrintDemo('Drug_Prescription');
SELECT * FROM DRUG_PRESC;

Call PrintDemo('Contract');
SELECT * FROM CONTRACT;

Call PrintDemo('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

CALL PrintDemo('GetPrescriptionReport for Patient 2001');
CALL GetPrescriptionReport(2001, '2025-04-01', '2025-04-30');

CALL PrintDemo('GetPrescriptionReport for Patient 2006');
CALL GetPrescriptionReport(2006, '2025-04-01', '2025-05-10');


CALL PrintDemo('GetPrescriptionDetails for Patient 2001 on 2025-04-20');
CALL GetPrescriptionDetails(2001, '2025-04-20');

CALL PrintDemo('GetPrescriptionDetails for Patient 2006 on 2025-05-01');
CALL GetPrescriptionDetails(2006, '2025-05-01');


CALL PrintDemo('GetDrugsByCompany for Medlife Ltd');
CALL GetDrugsByCompany('MediLife Ltd');

CALL PrintDemo('GetDrugsByCompany for PharmaCure');
CALL GetDrugsByCompany('PharmaCure');

CALL PrintDemo('GetPharmacyStock for HealthPlus');
CALL GetPharmacyStock('HealthPlus');


CALL PrintDemo('GetPharmacyCompanyContact between HealthPlus and Medlife Ltd');
CALL GetPharmacyCompanyContact('HealthPlus', 'MediLife Ltd');

CALL PrintDemo('GetPharmacyCompanyContact between CurePoint and PharmaCure');
CALL GetPharmacyCompanyContact('CurePoint', 'PharmaCure');


CALL PrintDemo('GetPatientsForDoctor for Doctor 1001');
CALL GetPatientsForDoctor(1001);

CALL PrintDemo('GetPatientsForDoctor for Doctor 1003');
CALL GetPatientsForDoctor(1003);

Call PrintDemo('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

CALL DeleteDoctorCascade(1001);
CALL DeleteCompanyCascade('MediLife Ltd');

-- DeletePatientCascade, DeletePharmacyCascade
