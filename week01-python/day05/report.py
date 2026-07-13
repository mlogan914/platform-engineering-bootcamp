def status_report(project_root, config, files, job_status):
    status = {
    "project": config["project_name"],
    "input_folder": config["input_folder"],
    "bucket": config["s3_bucket"],
    "prefix": config["s3_prefix"],
    "files_found": len(files),
    "files_uploaded": len(files),
    "summary_file": config["summary_file"],
    "log_file": config["log_file"],
    "job_status": job_status,
    "report_file": config["report_file"]
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

    with open(project_root / status["report_file"], "w") as file:
        file.write(report)