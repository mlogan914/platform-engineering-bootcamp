import yaml
import logging
import json

def read_config(filename):
    with open(filename, 'r') as file:
        config = yaml.safe_load(file)

    logging.info(
        "Config successfully loaded: %s", config
    )
    return config


def write_summary(input_path, project_root, config):
    sequencing_files = list(input_path.glob("*.fastq.gz"))
    logging.info(
        "Found %d sequencing files", 
        len(sequencing_files)
    )

    summary = {
        "project_name": config["project_name"],
        "input_folder": str(input_path),
        "file_count": len(sequencing_files),
        "files": [file.name for file in sequencing_files],
        "s3_bucket": config["s3_bucket"],
        "s3_prefix": config["s3_prefix"],
    }

    summary_path = project_root / config["summary_file"]

    with summary_path.open("w") as file:
        json.dump(summary, file, indent=4)

    logging.info(
        "Summary written to %s", summary_path
    )

## -- End of Program Code -- ##