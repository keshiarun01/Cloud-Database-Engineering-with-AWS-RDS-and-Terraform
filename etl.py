import boto3
import pandas as pd
from sqlalchemy import create_engine

# UPDATE THESE
bucket_name = "keshika-rds-demo-bucket"
rds_host = "resume-demo-db.cejakyoc8wat.us-east-1.rds.amazonaws.com"
rds_user = "admin"
rds_password = "YourStrongPassword123"
database = "ecommerce"

# ---------- DOWNLOAD FROM S3 ----------
s3 = boto3.client('s3')

files = ["users.csv", "products.csv", "orders.csv", "order_items.csv", "inventory.csv"]

for file in files:
    s3.download_file(bucket_name, f"data/{file}", file)
    print(f"Downloaded {file} from S3")

# ---------- CONNECT TO RDS ----------
engine = create_engine(f"mysql+pymysql://{rds_user}:{rds_password}@{rds_host}/{database}")

# ---------- LOAD DATA ----------
table_mapping = {
    "users.csv": "users",
    "products.csv": "products",
    "orders.csv": "orders",
    "order_items.csv": "order_items",
    "inventory.csv": "inventory"
}

for file, table in table_mapping.items():
    df = pd.read_csv(file)
    df.to_sql(table, con=engine, if_exists='append', index=False)
    print(f"Inserted data into table: {table}")
