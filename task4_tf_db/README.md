# Add database to the FaaS project

### 1) Files description

1. *./lambda/ingest_func.py* - AWS Lambda that accepts input data and sends it to AWS Kinesis. Can be triggered by HTTP request;
2. *./lambda/consume_func.py* - AWS Lambda that reads data from Kinesis and writes to AWS S3 bucket;
3. *./lambda/consume_func_db.py* - AWS Lambda that reads data from Kinesis and writes to AWS RDS MySQL;
4. *./lambda/requirements.txt* - required Python libraries for *consume_func_db* function ;
5. *./iam* - folder with configs in JSON format for *lambda-iam.tf* file;
6. *./outputs* - folder with zipped Python files for Lambda functions;
7. *security.tf* - Terraform config to create policy and role for lambdas;
8. *ingest_func.tf* - Terraform config for AWS Lambda *ingest_func*, responsible for data ingest;
9. *consume_func.tf* - Terraform config for AWS Lambda *consume_func*, responsible for data consume into S3;
10. *consume_func_db.tf* - Terraform config for AWS Lambda *consume_func_db*, responsible for data consume into RDS MySQL;
11. *db.tf* - Terraform config for AWS RDS MySQL instance;
12. *s3.tf* - Terraform config for AWS S3 bucket;
13. *kinesis.tf* - Terraform config for AWS Kinesis Data Stream;
14. *locals.tf* - local variables for Terraform;
15. *outputs.tf* - variables to output Terraform - in our case, it`s URL for *ingest_func* to invoke;
16. *variables.tf* - variables for Terraform config (excluded in .gitignore, as contains sensitive data);

### 2) General workflow

Provision infrastructure using Terraform --> Invoke ingest func using HTTP Request --> Receive event in AWS Kinesis --> Invoke consume func by new event in AWS Kinesis --> Write data to AWS S3 and AWS RDS My SQL

### 3) How to launch Terraform

- Navigate to folder ./task4_tf_db, using cd command;
- Set account key and secret key as environmental variables;
- Launch Terraform using "terraform init" and "terraform apply" commands;

### 4) How to make a HTTP request

To make a HTTP request awscurl was used. Here is example of request without secrets:
- awscurl -v -X POST https://dria5etlhopqaazx5tyck7777m0aqfms.lambda-url.eu-central-1.on.aws/ --data '{"event_attribute":"first db write"}' --region eu-central-1 --service lambda --access_key (PASTE ACCESS KEY) --secret_key (PASTE SECRET KEY)

### 5) Used technologies

- Terraform - to provision infrastructure;
- AWS Lambda - as FaaS;
- AWS Kinesis - as Event Streaming;
- AWS S3 - as Storage for *consume_func* function output;
- AWS IAM - config policies and roles;
- AWS RDS - as Storage for *consume_func_db* function output.

### 6) Screenshots

Can be viewed in this folder, ./task4_tf_db

### 7) Points for improvement.

- Organize Terraform files in dedicated folder;
- Extract default security group id and default subnet id not manually, but automatically by Terraform (if possible).