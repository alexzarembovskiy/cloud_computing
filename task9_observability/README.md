# Observability: Logs, metrics, alerts

- As base config was used Terraform files in ./task7_policies/terraform folder.

### 1) Find logs in each of three functions related to the same request:

- *ingest func log.png*;
- *consume func log.png*;
- *consume func db log.png*.

### 2) Find built-in metrics that might help you to understand Event Stream performance:

- *kinesis get average latency.png* = to measure average latency of GetRecords; 
- *kinesis get success average ratio.png* = to measure average success ratio of GetRecords;
- *kinesis put average latency.png* = to measure average latency of PutRecords;
- *kinesis put success average ratio.png* = to measure average success ratio of PutRecords.

- More metrics can be added, those that were mentioned above are only few examples.

### 3) Compare average execution time of functions that read from Event Stream:

- *consume func duration stats.png* = 211 ms;
- *consume func db duration stats.png* = 7.7 ms.

- As we can see, writes to RDS are much faster than to S3.
