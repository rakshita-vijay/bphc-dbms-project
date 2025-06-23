## **Database Design Assumptions**

### **Entity Attributes & Data Types** 

**Patient Table:**  
- `Primary_Physician` as mandatory (NOT NULL implied by foreign key) 

**Company Table:**
- `CompanyName` as primary key assumed to be unique across all companies  

**Drugs Table:**
- Trade name uniqueness only within a company (composite key with `CompanyNameDrugs`)  

### **Relationship Cardinalities & Business Rules**

**Patient-Doctor Relationship:**
- Assumed every patient must have exactly one primary physician 
- Doctors must have atleast 1 patient

**Prescription Logic:**
- Interpreted "latest prescription" requirement as allowing multiple prescriptions per patient-doctor pair on different dates 
- Assumed quantity applies to individual drugs, not the entire prescription

**Pharmacy-Drug Relationship:**
- Assumed the same drug can be sold at multiple pharmacies with different prices 
- No minimum stock quantity constraints implemented  

### **Implementation Decisions** 

**Deletion Policies:** 
- When deleting a doctor, set `Primary_Physician` to NULL for affected patients 
- Complete cascade deletion for companies removes all associated drugs and contracts 

**Data Validation:**
- Assumed basic referential integrity through foreign keys is sufficient  

### **Stored Procedure Assumptions**

**Functionality Scope:** 
- Assumed report generation requires date range filtering  
