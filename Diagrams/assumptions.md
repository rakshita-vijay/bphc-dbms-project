# **Database Design Assumptions**

---

## **1. Entity Attributes & Data Types** 

**(a) Patient Table:**  
- `Primary_Physician` as mandatory (NOT NULL implied by foreign key) 

**(b) Company Table:**
- `CompanyName` as primary key assumed to be unique across all companies  

**(c) Drugs Table:**
- Trade name uniqueness only within a company (composite key with `CompanyNameDrugs`)  

---

## **2. Relationship Cardinalities & Business Rules**

**(a) Patient-Doctor Relationship:**
- Assumed every patient must have exactly one primary physician 
- Doctors must have atleast 1 patient

**(b) Prescription Logic:**
- Interpreted "latest prescription" requirement as allowing multiple prescriptions per patient-doctor pair on different dates 
- Assumed quantity applies to individual drugs, not the entire prescription

**(c) Pharmacy-Drug Relationship:**
- Assumed the same drug can be sold at multiple pharmacies with different prices 
- No minimum stock quantity constraints implemented  

---

## **3. Implementation Decisions** 

**(a) Deletion Policies:** 
- When deleting a doctor, set `Primary_Physician` to NULL for affected patients 
- Complete cascade deletion for companies removes all associated drugs and contracts 

**(b) Data Validation:**
- Assumed basic referential integrity through foreign keys is sufficient  

---

## **4. Stored Procedure Assumptions**

**(a) Functionality Scope:** 
- Assumed report generation requires date range filtering 
