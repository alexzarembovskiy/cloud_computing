# Pricing calculator

### 1) Monthly cost per 1000, 100000 and 10000000 requests:

- 1000 requests: 76.07$/month;
- 100000 requests: 78.6$/month;
- 10000000 requests: 138.83$/month.

### 2) Conclusions:

1. What is the most expensive part of the project?
- It was AWS Kinesis;
- But if we make 10000000 requests per month - the costs for the storage are climbing up.
2. If there is a way to reduce the bill?
- Compress DB, if possible;
- Make a batch loads to S3 and RDS - it will decrease number of writes and costs for the services;
- If we write in batches to S3 - store data in compressed formats (parquet, for instance).

### 3) If the price changes linearly/logarithmically/exponentially and what causes this change?

- AWS Kinesis: relatively stable pricing;
- AWS Lambda: drastically increased when 10000000 requests per month expected;
- AWS RDS MySQL: relatively stable pricing, the only change that affects price - storage amount;
- AWS S3: drastically increased when 10000000 writes to bucket per month are expected.

### 4) Screenshots

- Can be viewed in this folder, ./task8_pricing