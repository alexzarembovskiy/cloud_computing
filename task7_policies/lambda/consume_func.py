import base64
import json
import boto3

print('Loading function')

s3 = boto3.resource('s3')

def lambda_handler(event, context):
    bucket_name = 'consume-bucket'
    for record in event['Records']:
        # Kinesis data is base64 encoded so decode here
        payload = base64.b64decode(record['kinesis']['data']).decode('utf-8')
        file_name = 'record_' + context.aws_request_id + '.json'
        s3.Bucket(bucket_name).put_object(Key=file_name, Body=payload)
        print("Decoded payload: " + payload)
    return 'Successfully processed {} records.'.format(len(event['Records']))
