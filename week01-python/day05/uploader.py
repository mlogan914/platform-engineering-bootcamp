import boto3
import logging
from pathlib import Path
from report import status_report

def list_objects():
    s3 = boto3.resource('s3')
    print("\nExisting s3 buckets:")
    for bucket in s3.buckets.all():
        print(bucket.name)

        
def upload_files(project_root, input_path, config, s3_bucket, s3_prefix):
    s3 = boto3.resource('s3')
    file_path = Path(input_path)
    files = []

    try:
        for file in file_path.glob('*.fastq.gz'):
            files.append(file.name)

            object_key = f"{s3_prefix}/{file.name}"
            

            with open(file_path / file.name, 'rb') as data:
                s3.Bucket(s3_bucket).put_object(
                    Key=object_key, 
                    Body=data
                )

                print(f"file: {file.name} has been uploaded to {s3_bucket}")

        logging.info(
            "%s files successfully uploaded to %s", len(files), 
            s3_bucket
        )
        status_report(project_root, config, files, job_status="SUCCESS")

    except Exception as e:
        logging.error(
            "Upload failed: %s", e
        )
        status_report(project_root, config, files, job_status="FAILURE")
    
    return files


## -- End of Program Code -- ##