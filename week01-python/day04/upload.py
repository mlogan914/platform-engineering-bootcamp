# ===============================================
# - Assignment 1 – AWS Credentials
# ===============================================
import boto3
from pathlib import Path
import logging

DAY04_DIR = Path(__file__).resolve().parent
LOG_FILE = DAY04_DIR / "upload.log"
INPUT_DIR = DAY04_DIR / "incoming_data"
LOG_PATH = DAY04_DIR

logging.basicConfig(level=logging.INFO, filename=LOG_PATH / "upload.log", filemode="w",
                    format="%(asctime)s - %(levelname)s - %(message)s") # ERROR and above

s3 = boto3.resource('s3')

# ===============================================
# - Assignment 3 – List Objects
# ===============================================
# for bucket in s3.buckets.all():
#     print(bucket.name)

def list_objects():
    print("\nExisting s3 buckets:")
    for bucket in s3.buckets.all():
        print(bucket.name)
# ===============================================
# - Assignment 2 – Upload to S3
# ===============================================
# with open(INPUT_DIR / 'Patient001_L001_R1.fastq.gz', 'rb') as data:
#     s3.Bucket('appdata-5201201').put_object(Key='Patient001_L001_R1.fastq.gz', Body=data)

def upload_file(INPUT_DIR, file, bucket):
    s3 = boto3.resource('s3')
    with open(INPUT_DIR / file, 'rb') as data:
        s3.Bucket(bucket).put_object(Key=file, Body=data)
        logging.info(f"File {file} sucessfully uploaded to {bucket}")

# ===============================================
# - Assignment 4 – Download an Object
# ===============================================
# s3 = boto3.client('s3')
# with open(INPUT_DIR / 'raw_wearable_device_02102023.csv', 'wb') as f:
#     s3.download_fileobj('appdata-5201201', 'raw_wearable_device_02102023.csv', f)

def download_file(INPUT_DIR, file, bucket):
    s3 = boto3.client('s3')
    with open(INPUT_DIR / file, 'wb') as f:
        s3.download_fileobj(bucket, file, f)
        logging.info(f"File {file} sucessfully downloaded to {bucket}")

# Upload every file in a dir
def upload_folder(INPUT_DIR, bucket):
    s3 = boto3.resource('s3')
    FILE_PATH = Path(INPUT_DIR)
    files = []

    try:
        for file in FILE_PATH.glob('*.fastq.gz'):
            files.append(file.name)
            with open(FILE_PATH / file.name, 'rb') as data:
                s3.Bucket(bucket).put_object(Key=file.name, Body=data)

                print(f"file: {file.name} has been uploaded to {bucket}")
        logging.info(f"{len(files)} files sucsesfully uploaded to {bucket}")
    except Exception as e:
        logging.error("Upload failed: %s", e)

def main():
    list_objects()
    upload_file(INPUT_DIR, 'Patient001_L001_R1.fastq.gz', 'appdata-5201201')
    download_file(INPUT_DIR, 'raw_wearable_device_02102023.csv','appdata-5201201')
    upload_folder(INPUT_DIR, 'appdata-5201201')

if __name__ == "__main__":
    main()

## -- End of Program Code -- ##