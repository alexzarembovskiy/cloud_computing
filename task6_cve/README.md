# Haunting CVEs

### 1) How to launch trivy CVE scan:

- Using terminal execute, next command to scan for only fixed issues, with HIGH and CRITICAL severity:
- docker run --rm -v ~/.trivy:/root/.cache/ aquasec/trivy:0.40.0 image --severity HIGH,CRITICAL --ignore-unfixed ghcr.io/mlflow/mlflow:v2.3.0

### 2) How to launch grype CVE scan:

1. Install grype on local machine by next command:
- curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin
2. Run next command. As filtering in grype doesn`t work, I`ve used grep|egrep to filter output:
- grype ghcr.io/mlflow/mlflow:v2.3.0 | grep -e High -e Critical | egrep -v "\(won't fix\)" | egrep "[0-9] +[0-9]"

### 3) Screenshots

Can be viewed in this folder, ./task6_cve

### 4) Points for improvement

- Rewrite scan command for grype, as it can give not desired state in the future.