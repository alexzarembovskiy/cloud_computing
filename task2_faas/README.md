# Function as a Service project

### 1) Python files description

1. *ingest_func.py* - AWS Lambda that accepts input data and sends it to AWS Kinesis. Can be triggered by HTTP request;
2. *consume_func.py* - AWS Lambda that reads data from Kinesis and writes to AWS S3 bucket.

### 2) General workflow

Invoke ingest func using HTTP Request --> Receive event in AWS Kinesis --> Invoke consume func by new event in AWS Kinesis --> Write data to AWS S3

### 3) How to make a HTTP request

To make a HTTP request awscurl was used. Here is example of request without secrets:
awscurl -v -X POST https://qkk2okaq236ri5bd7fmihqomha0ydayg.lambda-url.eu-central-1.on.aws/ --data '{"event_attribute":"http request test"}' --region eu-central-1 --service lambda --access_key (PASTE ACCESS KEY) --secret_key (PASTE SECRET KEY)

### 4) Used technologies

- AWS Lambda - as FaaS
- AWS Kinesis - as Event Streaming
- AWS S3 - as Storage

### 5) Screenshots

Can be viewed in this folder, ./task2_faas