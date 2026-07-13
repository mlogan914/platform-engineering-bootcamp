import boto3
import logging
from pathlib import Path
from utils import status_report

def list_objects():
    s3 = boto3.resource('s3')
    print("\nExisting s3 buckets:")
    for bucket in s3.buckets.all():
        print(bucket.name)


def upload_file(INPUT_PATH, file, s3_bucket):
    s3 = boto3.resource('s3')
    with open(INPUT_PATH / file, 'rb') as data:
        s3.Bucket(s3_bucket).put_object(Key=file, Body=data)
        logging.info(f"File {file} sucessfully uploaded to {s3_bucket}")


def upload_files(DAY05_DIR, INPUT_PATH, config, s3_bucket, s3_prefix):
    s3 = boto3.resource('s3')
    FILE_PATH = Path(INPUT_PATH)
    files = []

    try:
        for file in FILE_PATH.glob('*.fastq.gz'):
            files.append(file.name)

            object_key = f"{s3_prefix}/{file.name}"
            

            with open(FILE_PATH / file.name, 'rb') as data:
                s3.Bucket(s3_bucket).put_object(
                    Key=object_key, 
                    Body=data
                )

                print(f"file: {file.name} has been uploaded to {s3_bucket}")

        logging.info("%s files successfully uploaded to %s", len(files), s3_bucket)
        status_report(DAY05_DIR, config, files, job_status="SUCCESS")

    except Exception as e:
        logging.error("Upload failed: %s", e)
        status_report(DAY05_DIR, config, files, job_status="FAILURE")
    
    return files


## -- End of Program Code -- ##