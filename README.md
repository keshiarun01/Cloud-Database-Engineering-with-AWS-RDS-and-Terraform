# **Cloud Database Engineering with AWS RDS and Terraform**

This project demonstrates an end-to-end **cloud-native relational database deployment**, including **infrastructure-as-code provisioning**, **data migration**, **query optimization**, and **backup/restore workflows** using **AWS RDS MySQL**, **Terraform**, **S3**, and **Python ETL**.
It replicates core responsibilities of an **AWS RDS / Cloud Database Engineer**, including scalable provisioning, performance tuning, monitoring, and disaster recovery validation.

---

## **📌 Project Overview**

This project provisions an RDS MySQL instance using **Terraform**, builds a relational schema, migrates synthetic data from **Amazon S3** using Python, performs **query performance tuning**, and validates database resiliency using **snapshot-based recovery**.

The goal is to simulate real-world cloud database administration scenarios:

* Automated cloud DB provisioning
* Secure networking & parameter configuration
* ETL ingestion pipelines
* SQL performance tuning with EXPLAIN plans
* Backups, snapshots & restoration
* CloudWatch monitoring for operational visibility

---

## **🚀 Architecture Overview**

**Terraform → AWS → MySQL Workbench → S3 → Python ETL → RDS Tuning + Monitoring**

```
Terraform
   │
   ├── Creates VPC security group
   ├── Creates RDS MySQL instance (db.t3.micro)
   └── Outputs RDS endpoint
       
Python ETL
   │
   ├── Downloads CSVs from S3
   ├── Inserts data into RDS using SQLAlchemy
   └── Validates row counts
 
Database Engineering
   │
   ├── Built relational schema (Users, Orders, Products, OrderItems, Inventory)
   ├── Ran EXPLAIN-based analysis
   ├── Applied custom indexing
   └── Reduced query latency by ~65%
   
AWS RDS Operations
   │
   ├── Manual snapshot creation
   ├── Restored DB from snapshot
   ├── Validated recovery
   └── Set up CloudWatch metrics
```

---

## **📦 Features Implemented**

### **1. Infrastructure Provisioning (Terraform)**

* Automated deployment of AWS RDS MySQL
* Configured DB subnet groups, security groups, and networking
* Enabled automated backups and parameter configuration
* Built repeatable IaC for consistent DB environments

### **2. Relational Schema Design**

Created a production-style schema with 5 tables:

* `users`
* `products`
* `orders`
* `order_items`
* `inventory`

Includes PKs, FKs, normalization, and indexing.

### **3. Data Migration (S3 → Python → RDS)**

* Generated 3,700+ synthetic records using Faker
* Stored CSVs in S3
* Used SQLAlchemy + PyMySQL for bulk insertion
* Verified counts via MySQL Workbench

### **4. Query Performance Optimization**

* Ran slow multi-table joins
* Analyzed execution plans via **EXPLAIN**
* Added targeted indexes: category, user_id, order_id, product_id, order_date
* Improved query runtime by **~65%**

### **5. Backup & Restore Workflow**

* Created manual RDS snapshot
* Restored snapshot into a new DB instance
* Revalidated all tables and row counts
* Deleted restored DB to minimize cost

### **6. Monitoring & Observability**

* Enabled CloudWatch metrics for:

  * CPU Utilization
  * Free Storage
  * Database Connections
  * Read/Write IOPS
* Ensured operational visibility for debugging and performance management

---

## **🛠️ Technologies Used**

### **AWS Services**

* Amazon RDS (MySQL)
* Amazon S3
* Amazon CloudWatch
* IAM

### **Infrastructure**

* Terraform (IaC)

### **Data / ETL**

* Python
* Boto3
* Pandas
* SQLAlchemy
* Faker

### **Database Tools**

* MySQL Workbench
* EXPLAIN Query Analyzer

---

## **📂 Project Structure**

```
aws-rds-project/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── data/
│   ├── users.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   └── inventory.csv
│
├── etl/
│   └── load_data.py
│
└── README.md
```

---

## **📊 Performance Improvement Highlights**

| Component                        | Before Indexing | After Indexing | Improvement        |
| -------------------------------- | --------------- | -------------- | ------------------ |
| Query Latency (JOIN on 4 tables) | ~0.40–0.50 sec  | ~0.12–0.18 sec | **≈ 65% faster**   |
| EXPLAIN rows scanned (products)  | 300–400 rows    | 30–50 rows     | **~85% reduction** |
| JOIN Type                        | ALL / ref       | eq_ref / ref   | More efficient     |

---

## **💾 Backup & Recovery Validation**

1. Created manual snapshot of primary RDS instance
2. Restored into new DB instance (`resume-demo-restore`)
3. Connected via Workbench and revalidated table counts
4. Deleted restored DB to reduce cost

This simulates real-world disaster recovery operations.

