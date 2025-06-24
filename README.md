# NOVA Pharmacy Chain Management System

A database management system for a pharmacy chain, handling prescriptions, inventory, contracts, and stakeholder relationships. Built using MySQL, this system demonstrates advanced database design principles, normalization techniques, and real-world application of relational database concepts.

---

## 1. Overview

Purpose: Centralized management of pharmacy operations, including patients, doctors, drugs, pharmacies, pharmaceutical companies, and prescriptions.
  - Supports efficient data storage, querying, and reporting for real-world pharmacy workflows.
  - Designed for scalability and maintainability.
  - Serves as the backbone for a network of pharmacies, managing complex relationships between healthcare stakeholders.
  - Balances complexity with usability to power real pharmacy operations.

---

## 2. Repository Structure

```
bphc-dbms-project/
├── Diagrams/
│  ├── er_model.png            # Comprehensive ER diagram
│  ├── relational_mapping.png  # Schema transformation
│  └── assumptions.md          # Design assumptions and decisions
├── dbms_project_version_2.sql # Complete database implementation
└── README.md                  # Project documentation
```

The repository follows a clean, logical structure that separates design artifacts from implementation, making it easy for developers and stakeholders to understand both the conceptual design and technical implementation.

---

## 3. Design Highlights

- **Key entities and relationships:**
  - **Entities:**
    - Doctor: Identified by Aadhar ID, includes name, specialty, and experience.
      - Healthcare professionals with specialized expertise.
    - Patient: Includes demographic details, address, and assigned primary physician.
      - Mandatory primary physician assignment ensuring continuity of care.
    - Pharmaceutical Company: Identified by company name, includes contact info.
      - Drug manufacturers and suppliers forming the supply chain backbone.
    - Drug: Linked to a company, includes trade name, formula, and price.
      - Composite primary key ensuring trade name uniqueness within companies.
      - Supports multiple manufacturers for the same generic drug.
    - Pharmacy: Location and contact details.
      - Physical pharmacy locations with inventory and contract management capabilities.
    - Prescription: Connects patient, doctor, and multiple drugs with quantities.
      - Supports multiple drugs per prescription with quantity specification.
  - **Relationships:**
    - Each patient has one primary physician; doctors can serve multiple patients.
    - Prescriptions can include multiple drugs, modeled via a junction table.
    - Pharmacies stock various drugs with price and quantity details.
    - Contracts link pharmacies and pharmaceutical companies, including supervisors and contract periods.

---

## 4. Schema Structure

- Normalized to third normal form (3NF):
  - First Normal Form: Atomic attribute values.
  - Second Normal Form: Elimination of partial dependencies.
  - Third Normal Form: Removal of transitive dependencies, especially in prescription-drug relationships.
- Primary keys:
  - Simple keys like Aadhar IDs and company names.
  - Composite keys for complex relationships, e.g., (Doctor, Patient, PrescriptionDate).
- Foreign key constraints ensure referential integrity and data consistency.
- Junction tables handle many-to-many relationships, such as prescriptions and drugs.

---

## 5. Functionalities

- Core operations:
  - CRUD (Create, Read, Update, Delete) for all entities via stored procedures.
  - Advanced query capabilities:
    - Prescription analytics: Generate reports for patients within date ranges.
    - Inventory management: Real-time stock tracking across pharmacies.
    - Relationship queries: List patients per doctor, retrieve pharmacy-company contacts.
  - Cascade deletion procedures maintain data integrity when deleting related records.

---

## 6. Features

- Comprehensive sample data included for immediate testing.
  - Covers all entities and their relationships with realistic data (doctors, patients, companies, pharmacies, drugs).
- Modular stored procedures designed for extensibility and maintainability.
- Business rules enforced at the schema and procedure level.
- Data validation through database constraints and stored procedure logic.
- Integrated contact and contract management between pharmacies and pharmaceutical companies.

---

## 7. Flexibility & Extensibility

- Modular design supports adding new attributes or entities with minimal changes.
  - Stored procedures can be extended for new operations.
  - Schema accommodates evolving business rules and relationships.
- Handles complex business scenarios:
  - Multiple prescriptions per patient-doctor pair on different dates.
  - Supervisor reassignment for pharmaceutical contracts.
  - Cascade deletion policies ensuring referential integrity.
- Multi-layered validation framework:
  - Database constraints for data integrity.
  - Stored procedure validation for business logic enforcement.
  - Referential integrity maintenance.

---

## 8. Implementation Notes

- All code written in standard SQL (MySQL).
  - Stored procedures and queries are structured for clarity and maintainability.
  - Over 25 specialized stored procedures handle CRUD, reporting, and cascade deletions.
- Diagrams illustrate entity relationships and schema mapping.
- Sample data reflects real-world scenarios with diverse demographics and drug portfolios.

---

## 9. Getting Started

- Run `dbms_project_version_2.sql` in a MySQL environment.
  - The script includes schema creation, sample data insertion, and stored procedure definitions.
- Use provided stored procedures for all operations, including adding, updating, deleting, and querying data.
- Extend the system using the modular stored procedure patterns as needed.

---

## 10. Additional Information

- Key design assumptions and rationale are documented in `Diagrams/assumptions.md`.
- Developed as part of the Database Systems course (CSF 212) at BITS Pilani Hyderabad Campus.
- Serves as an educational resource demonstrating advanced ER modeling, normalization, and stored procedure development.

---

*For more details, refer to the diagrams and assumptions files in the repository.*

---
