# ===============================================
# - Bioinformatics Upload Utility
# ===============================================
from pathlib import Path
import logging
import json

from logger import setup_logger
from utils import read_config
from utils import write_summary
from uploader import list_objects
from uploader import upload_files


DAY05_DIR = Path(__file__).resolve().parent


def main():
    setup_logger(DAY05_DIR / "upload.log")
    
    # Load configuration
    config = read_config(DAY05_DIR / 'config.yml')

    INPUT_PATH = Path(DAY05_DIR / config["input_folder"])
    s3_bucket = config["s3_bucket"]
    s3_prefix = config["s3_prefix"]

    # Validate configuration and input folder
    if not INPUT_PATH.exists():
        logging.error(f"Path does not exist: {DAY05_DIR}/%s", INPUT_PATH)
    
    # Produce a JSON summary
    write_summary(INPUT_PATH, DAY05_DIR, config)

    # Upload files
    list_objects()

    upload_files(DAY05_DIR, INPUT_PATH, config, s3_bucket, s3_prefix)

if __name__ == '__main__':
    main()

## -- End of Program Code -- ##