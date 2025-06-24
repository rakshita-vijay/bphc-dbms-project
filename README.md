# 🏥 NOVA Pharmacy Chain Management System

A comprehensive **Database Management System** designed for NOVA, a modern pharmacy chain that bridges the gap between patients, doctors, pharmaceutical companies, and pharmacies. Built using **MySQL**, this system demonstrates advanced database design principles, normalization techniques, and real-world application of relational database concepts.

---

## 1. Background
**Built for the Database Systems course (CS F212) at BITS Pilani Hyderabad Campus**
<br>This project showcases the practical application of database design principles in creating a real-world healthcare management system that balances complexity with usability.

---

## 2. Project Overview

The NOVA Pharmacy Chain Management System serves as the backbone for a network of pharmacies, managing complex relationships between healthcare stakeholders. This is a fully-functional system that can power real pharmacy operations, handling everything from patient prescriptions to pharmaceutical company contracts.

**Technology Stack:** MySQL with advanced PL/SQL stored procedures and functions

---

## 3. Repository Structure

```
bphc-dbms-project/
├── Diagrams/
│   ├── er_model.png           # Comprehensive ER diagram
│   ├── relational_mapping.png # Schema transformation
│   └── assumptions.md         # Design assumptions and decisions
├── dbms_project_version_2.sql # Complete database implementation
└── README.md                  # Project documentation
```

The repository follows a clean, logical structure that separates design artifacts from implementation, making it easy for developers and stakeholders to understand both the conceptual design and technical implementation.

---

## 4. Design Philosophy & Highlights

- ### **Entity-Centric Architecture**
  The system revolves around six core entities that mirror real-world healthcare operations:
  
  - **👨‍⚕️ Doctor Entity** - Healthcare professionals with specialized expertise
    - Unique identification through Aadhar ID
    - Specialization tracking (Cardiology, Neurology, Pediatrics, etc.)
    - Experience quantification for better patient-doctor matching
  
  - **🏥 Patient Entity** - The heart of the healthcare system
    - Comprehensive demographic information
    - Mandatory primary physician assignment ensuring continuity of care
    - Address and age tracking for demographic analysis
  
  - **🏢 Pharmaceutical Company Entity** - Drug manufacturers and suppliers
    - Company name serves as natural primary key
    - Contact information for business communications
    - Foundation for drug supply chain management
  
  - **💊 Drugs Entity** - Medication catalog with company associations
    - Composite primary key ensuring trade name uniqueness within companies
    - Chemical formula storage for pharmaceutical reference
    - Flexible design allowing same generic drugs from different manufacturers
  
  - **🏪 Pharmacy Entity** - Physical pharmacy locations
    - Complete contact and location information
    - Foundation for inventory and sales management
    - Contract management capabilities
  
  - **📋 Prescription Entity** - The critical link between doctors, patients, and medications
    - Temporal tracking with prescription dates
    - Support for multiple drugs per prescription
    - Quantity specification for precise medication management

- ### **Relationship Design**

  The system implements sophisticated relationship modeling that captures real-world complexities:
  
  - **Primary Physician Relationship** - Every patient has exactly one primary physician, but doctors can serve multiple patients, ensuring accountability while allowing workload distribution.
  
  - **Prescription Flexibility** - The many-to-many relationship between prescriptions and drugs is elegantly handled through the `Drug_Presc` junction table, allowing doctors to prescribe multiple medications with specific quantities.
  
  - **Pharmacy-Drug Marketplace** - The `Sells` relationship creates a flexible marketplace where the same drug can be sold at different pharmacies with varying prices, reflecting real market dynamics.
  
  - **Contract Management** - Pharmaceutical companies and pharmacies are connected through formal contracts with supervisors, dates, and content tracking, enabling proper business relationship management.

---

## 5. Schema Formation & Structure

- ### **Normalization**
  The database achieves **Third Normal Form (3NF)** through careful decomposition:
  
  - **First Normal Form**: All attributes contain atomic values
  - **Second Normal Form**: Elimination of partial dependencies through proper primary key design
  - **Third Normal Form**: Removal of transitive dependencies, particularly in the prescription-drug relationship

- ### **Primary Key Strategy**
  The system employs both simple and composite primary keys strategically:
  - **Simple Keys**: Natural identifiers like Aadhar IDs and company names
  - **Composite Keys**: Complex relationships like `(Doctor, Patient, PrescriptionDate)` ensuring temporal uniqueness

- ### **Foreign Key Integrity**
  Comprehensive referential integrity through carefully designed foreign key constraints that maintain data consistency while allowing business flexibility.

---

## 6. Functionalities & Features

- ### **Core CRUD Operations**
  Every entity supports full **Create, Read, Update, Delete** operations through dedicated stored procedures:
  
  ```sql
  -- Example: Adding a new doctor with validation
  CALL AddDoctor(1001, 'Dr. Meera Rao', 'Cardiology', 15);
  ```

- ### **Advanced Query Capabilities**

  - **📊 Prescription Analytics**
    - `GetPrescriptionReport()`: Generate comprehensive prescription reports for patients within date ranges
    - `GetPrescriptionDetails()`: Retrieve specific prescription information for a given patient and date
  
  - **🏥 Inventory Management**
    - `GetPharmacyStock()`: Complete inventory listing with supplier and pricing information
    - Real-time stock position tracking across multiple pharmacy locations
  
  - **👥 Relationship Queries**
    - `GetPatientsForDoctor()`: Patient roster management for healthcare professionals
    - `GetPharmacyCompanyContact()`: Business relationship and contact information retrieval

- ### **Business Intelligence Features**

  - **Drug Analysis by Company**: Complete pharmaceutical portfolio analysis showing all medications produced by specific manufacturers, essential for procurement and partnership decisions.
  
  - **Contact Management System**: Integrated communication system linking pharmacies with their pharmaceutical partners, including supervisor assignments and contract details.

---

## 7. System Flexibility & Adaptability

- ### **Scalable Architecture**
  The system design anticipates growth through:
  - **Modular stored procedures** that can be easily extended
  - **Flexible pricing models** allowing dynamic market adjustments
  - **Expandable entity attributes** without breaking existing relationships

- ### **Business Rule Accommodation**
  The system gracefully handles complex business scenarios:
  - **Multiple prescriptions per patient-doctor pair** on different dates
  - **Supervisor reassignment** for pharmaceutical contracts
  - **Cascade deletion policies** that maintain referential integrity while providing cleanup flexibility

- ### **Data Validation Framework**
  Multi-layered validation through:
  - **Database constraints** ensuring data integrity at the storage level
  - **Stored procedure validation** providing business logic enforcement
  - **Referential integrity** maintaining relationship consistency

---

## 8. Technical Implementation Details

- ### **Stored Procedure Architecture**
  The system employs over 25 specialized stored procedures, each designed for specific operations:
  
  - **Cascade Deletion Management**: Advanced procedures like `DeleteDoctorCascade()` that intelligently handle complex deletion scenarios while preserving data integrity.
  
  - **Report Generation Engine**: Sophisticated reporting procedures that join multiple tables and provide formatted output for business intelligence.
  
  - **Update Flexibility**: Granular update procedures allowing modification of specific attributes without affecting unrelated data.

- ### **Sample Data Integration**
  The system includes realistic sample data covering:
  - **8 specialized doctors** across various medical fields
  - **26 patients** with diverse demographics
  - **9 pharmaceutical companies** with comprehensive drug portfolios
  - **8 pharmacy locations** across major Indian cities
  - **Real-world drug formulations** and pricing structures

---

## 9. Innovation & Best Practices

- ### **Assumption-Driven Design**
  The project documentation includes a comprehensive assumptions file that explains design decisions, making the system transparent and maintainable. Key assumptions include simplified Aadhar ID formats for demonstration purposes while maintaining real-world applicability.

- ### **Error Handling Strategy**
  Robust error handling through database constraints and stored procedure validation, ensuring system stability under various operational conditions.

- ### **Performance Optimization**
  Strategic indexing through primary and foreign key relationships, ensuring efficient query execution even with large datasets.

---

## 10. Getting Started

(1) **Database Setup**: Execute `dbms_project_version_2.sql` in your MySQL environment
<br>(2) **Sample Data**: The script includes comprehensive sample data for immediate testing
<br>(3) **Procedure Testing**: Use the included demonstration calls to explore system capabilities
<br>(4) **Custom Operations**: Extend the system using the established stored procedure patterns

---

## 11. Educational Value

This project serves as an excellent educational resource demonstrating:
- **Advanced ER modeling** with complex relationships
- **Normalization techniques** applied to real-world scenarios
- **Stored procedure development** for business logic implementation
- **Database design documentation** and assumption management

--- 
