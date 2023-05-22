import boto3
import json

kinesis = boto3.client('kinesis', region_name='eu-central-1')

def put_to_stream(stream_name, data):
    put_response = kinesis.put_record(
        StreamName=stream_name,
        Data=json.dumps(data),
        PartitionKey='partition_key'
    )
    return put_response

def lambda_handler(event, context):   
    print("Lambda function ARN:", context.invoked_function_arn)
    print("CloudWatch log stream name:", context.log_stream_name)
    print("CloudWatch log group name:",  context.log_group_name)
    print("Lambda Request ID:", context.aws_request_id)
    print("Lambda function memory limits in MB:", context.memory_limit_in_mb)
    print("Lambda time remaining in MS:", context.get_remaining_time_in_millis())
    
    event_body = json.loads(event['body'])
    print(event_body['event_attribute'])
    resp = put_to_stream('event_stream', {'event_attribute': event_body, 'ingest_request_id': context.aws_request_id})
    
    return resp
