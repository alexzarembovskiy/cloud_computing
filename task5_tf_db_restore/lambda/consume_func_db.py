import sys
import logging
import pymysql
import json
import os
import base64

# rds settings
rds_host  = os.getenv('DB_INSTANCE_ADDRESS')
user_name = os.getenv('username')
password = os.getenv('password')
db_name = os.getenv('db_name')

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# create the database connection outside of the handler to allow connections to be
# re-used by subsequent function invocations.
try:
    conn = pymysql.connect(host=rds_host, user=user_name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")

def lambda_handler(event, context):
    """
    This function creates a new RDS database table and writes records to it
    """
    message = base64.b64decode(event['Records'][0]['kinesis']['data']).decode('utf-8')
    print(message)
    data = json.loads(message)
    event_attribute = data['event_attribute']['event_attribute']
    request_id = data['ingest_request_id']

    item_count = 0
    sql_string = f"""insert into events (event_attribute, ingest_request_id, row_created_at) 
        values('{event_attribute}', '{request_id}', NOW());"""

    with conn.cursor() as cur:
        cur.execute("""create table if not exists events 
            ( event_attribute  varchar(20) NOT NULL, ingest_request_id varchar(50) NOT NULL, row_created_at timestamp NOT NULL);""")
        cur.execute(sql_string)
        conn.commit()
        cur.execute("select * from events;")
        logger.info("The following items have been added to the database:")
        for row in cur:
            item_count += 1
            logger.info(row)
    conn.commit()

    return "Added %d items to RDS MySQL table" %(item_count)