# ===============================================
# - Bioinformatics Upload Utility
# ===============================================
from pathlib import Path
import logging
import json

from logger import setup_logger
from validator import validate_config
from utils import read_config
from utils import write_summary
from uploader import list_objects
from uploader import upload_files


project_root = Path(__file__).resolve().parent


def main():
    setup_logger(project_root / "upload.log")
    
    # Load config and validate
    config = read_config(project_root / 'config.yml')
    
    validate_config(config)

    input_path = Path(project_root / config["input_folder"])
    s3_bucket = config["s3_bucket"]
    s3_prefix = config["s3_prefix"]

    # Validate configuration and input folder
    if not input_path.is_dir():
        raise FileNotFoundError(
            f"{input_path} does not exist."
    )
    
    # Produce a JSON summary
    write_summary(input_path, project_root, config)

    # Upload files
    list_objects()

    upload_files(project_root, input_path, config, s3_bucket, s3_prefix)

if __name__ == '__main__':
    main()

## -- End of Program Code -- ##