# Policies check

### 1) How to launch policies scan using *checkov*:

1. First of all, we need to install *checkov* on the local machine:
- pip3 install checkov;
2. For test purposes, I`ve used Terraform configs from */task5_tf_db_restore* folder. To launch scan process, use next command:
- checkov -d task5_tf_db_restore/terraform/

### 2) *checkov* scan results:

- Can be viewed in this folder, ./task7_policies, *checkov scan results.txt* file.

### 3) What was fixed after the scan from *checkov*:

- In S3 bucket, was forbidden public access;
- In S3 bucket, was enabled versioning.

### 4) Screenshots

- Can be viewed in this folder, ./task7_policies