# Database backup/restore

### 1) Files description

1. *../lambda* - folder with AWS Lambda`s and requirements;
2. *../iam* - folder with configs in JSON format for *../terraform/lambda-iam.tf* file;
3. *../outputs* - folder with zipped Python files for Lambda functions;
4. *../terraform* - folder with Terraform files.

### 2) General workflow

Provision infrastructure using Terraform --> Invoke ingest func using HTTP Request --> Receive event in AWS Kinesis --> Invoke consume func by new event in AWS Kinesis --> Write data to AWS S3 and AWS RDS My SQL

### 3) How to launch Terraform

- Navigate to folder ./task5_tf_db_restore, using cd command;
- Set account key and secret key as environmental variables;
- Launch Terraform using "terraform init" and "terraform apply" commands;

### 4) How to make a HTTP request

To make a HTTP request awscurl was used. Here is example of request without secrets:
- awscurl -v -X POST https://76i3jtkea2uuxzjc3ejaciqbly0gpbpt.lambda-url.eu-central-1.on.aws/ --data '{"event_attribute":"first db write"}' --region eu-central-1 --service lambda --access_key (PASTE ACCESS KEY) --secret_key (PASTE SECRET KEY)

### 5) Used technologies

- Terraform - to provision infrastructure;
- AWS Lambda - as FaaS;
- AWS Kinesis - as Event Streaming;
- AWS S3 - as Storage for *consume_func* function output;
- AWS IAM - config policies and roles;
- AWS RDS - as Storage for *consume_func_db* function output.

### 6) Screenshots

Can be viewed in this folder, ./task5_tf_db_restored

### 7) Actions to acomplish this lab.

- Add in inbound rules of security group your IP. It`s needed to access DB from local machine;
- Connect to DB, check whether the data is present;
- Create DB snapshot from AWS RDS website;
- Make modifications to your data;
- Restore to the previous state using created snapshot;
- Change connection to the restored instance, check the state of data.