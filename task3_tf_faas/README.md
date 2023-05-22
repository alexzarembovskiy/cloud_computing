# Terraform configuration for the project, Function as a Service project

### 1) Python files description

1. *ingest_func.py* - AWS Lambda that accepts input data and sends it to AWS Kinesis. Can be triggered by HTTP request;
2. *consume_func.py* - AWS Lambda that reads data from Kinesis and writes to AWS S3 bucket;
3. *main.tf* - Terraform config with AWS Lambda, Kinesis and S3 bucket configs;
4. *lambda-iam.tf* - Terraform config to create policy and role for lambdas;
5. *./iam* - folder with configs in JSON format for *lambda-iam.tf* file.

### 2) General workflow

Provision infrastructure using Terraform --> Invoke ingest func using HTTP Request --> Receive event in AWS Kinesis --> Invoke consume func by new event in AWS Kinesis --> Write data to AWS S3

### 3) How to launch Terraform

- Navigate to folder ./task3_tf_faas, using cd command;
- Set account key and secret key as environmental variables;
- Launch Terraform using "terraform init" and "terraform apply" commands;

### 4) How to make a HTTP request

To make a HTTP request awscurl was used. Here is example of request without secrets:
- awscurl -v -X POST https://6i7njjnjfxpi3ubzafbtxx4am40vzwgr.lambda-url.eu-central-1.on.aws/ --data '{"event_attribute":"http request test terraform"}' --region eu-central-1 --service lambda --access_key (PASTE ACCESS KEY) --secret_key (PASTE SECRET KEY)

### 5) Used technologies

- Terraform - to provision infrastructure;
- AWS Lambda - as FaaS
- AWS Kinesis - as Event Streaming
- AWS S3 - as Storage

### 6) Screenshots

Can be viewed in this folder, ./task3_tf_faas

### 7) Points for improvement.

- Play a bit with Terraform outputs to receive Lambda URL instantly;
- Parametrize Lambda - to pass parameters, as stream name, during invokation or on Terraform level.