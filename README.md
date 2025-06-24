# NOVA Pharmacy Chain Management System

A database management system for a pharmacy chain, handling prescriptions, inventory, contracts, and stakeholder relationships. Built using MySQL.

---

## 1. Overview

- Purpose: Centralized management of pharmacy operations, including patients, doctors, drugs, pharmacies, pharmaceutical companies, and prescriptions.
  - Supports efficient data storage, querying, and reporting for real-world pharmacy workflows.
  - Designed for scalability and maintainability.

---

## 2. Repository Structure

```
bphc-dbms-project/
├── Diagrams/
│   ├── er_model.png           # Comprehensive ER diagram
│   ├── relational_mapping.png # Schema transformation
│   └── assumptions.md         # Design assumptions and decisions
├── dbms_project_version_2.sql # Complete database implementation
└── README.md                  # Project documentation
``` 

---

## 3. Design Highlights

- **Key entities and relationships:**
  - **Entities:**
    - Doctor: Identified by Aadhar ID, includes name, specialty, and experience.
    - Patient: Includes demographic details, address, and assigned primary physician.
    - Pharmaceutical Company: Identified by company name, includes contact info.
    - Drug: Linked to a company, includes trade name, formula, and price.
    - Pharmacy: Location and contact details.
    - Prescription: Connects patient, doctor, and multiple drugs with quantities.
  - **Relationships:**
    - Each patient has one primary physician.
    - Prescriptions can include multiple drugs.
    - Pharmacies stock various drugs with price and quantity details.
    - Contracts link pharmacies and companies.

---

## 4. Schema Structure

- Normalized to third normal form.
  - Simple and composite primary keys used as appropriate.
  - Foreign key constraints maintain referential integrity.
  - Junction tables handle many-to-many relationships (e.g., prescriptions and drugs).

---

## 5. Functionalities

- Core operations:
  - CRUD (Create, Read, Update, Delete) for all entities via stored procedures.
  - Analytics and reporting:
    - Prescription reports for patients within date ranges.
    - Inventory and stock queries for pharmacies.
  - Relationship queries:
    - List patients for a doctor.
    - Retrieve pharmacy-company contacts.
  - Cascade deletion for entities with dependent records.

---

## 6. Features

- Comprehensive sample data included for immediate testing.
  - Covers all entities and their relationships.
- Modular stored procedures for extensibility.
- Cascade deletion and update procedures for data integrity.
- Data validation through constraints and procedure logic.
- Business rules handled at the schema and procedure level.

---

## 7. Flexibility & Extensibility

- Modular design supports adding new attributes or entities with minimal changes.
  - Stored procedures can be extended for new operations.
  - Schema accommodates changes in business rules or relationships.

---

## 8. Implementation Notes

- All code written in standard SQL (MySQL).
  - Procedures and queries are structured for clarity and maintainability.
  - Diagrams illustrate entity relationships and schema mapping.

---

## 9. Getting Started

- Run `dbms_project_version_2.sql` in a MySQL environment.
  - Sample data is loaded automatically.
  - Use provided stored procedures for all operations.

---

## 10. Additional Information

- Key design assumptions and rationale are documented in `Diagrams/assumptions.md`.
- Developed for the Database Systems course (CSF 212) at BITS Pilani Hyderabad Campus.

---

*For more details, refer to the diagrams and assumptions files in the repository.* 

---
