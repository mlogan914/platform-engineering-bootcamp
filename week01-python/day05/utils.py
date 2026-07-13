import yaml
import logging
import json

def read_config(filename):
    with open(filename, 'r') as file:
        config = yaml.safe_load(file)

    logging.info("Config successfully loaded: %s", config)
    return config


def write_summary(INPUT_PATH, DAY05_DIR, config):
    sequencing_files = list(INPUT_PATH.glob("*.fastq.gz"))
    logging.info("Found %d sequencing files", len(sequencing_files))

    summary = {
        "project_name": config["project_name"],
        "input_folder": str(INPUT_PATH),
        "file_count": len(sequencing_files),
        "files": [file.name for file in sequencing_files],
        "s3_bucket": config["s3_bucket"],
        "s3_prefix": config["s3_prefix"],
    }

    summary_path = DAY05_DIR / config["summary_file"]

    with summary_path.open("w") as file:
        json.dump(summary, file, indent=4)

    logging.info("Summary written to %s", summary_path)

def status_report(DAY05_DIR, config, files, job_status):
    status = {
    "project": config["project_name"],
    "input_folder": config["input_folder"],
    "bucket": config["s3_bucket"],
    "prefix": config["s3_prefix"],
    "files_found": len(files),
    "files_uploaded": len(files),
    "summary_file": config["summary_file"],
    "log_file": config["log_file"],
    "job_status": job_status
}

    report = f'''
========================================
 Bioinformatics Upload Summary
========================================
Project:        {status["project"]}
Input Folder:   {status["input_folder"]}
S3 Bucket:      {status["bucket"]}
S3 Prefix:      {status["prefix"]}

FASTQ Files Found:      {status["files_found"]}
Files Uploaded:         {status["files_uploaded"]}
Summary File:           {status["summary_file"]}
Log File:               {status["log_file"]}

Status: {status["job_status"]}
========================================
    '''

    with open(DAY05_DIR / "status_report.txt", "w") as file:
        file.write(report)

## -- End of Program Code -- ##