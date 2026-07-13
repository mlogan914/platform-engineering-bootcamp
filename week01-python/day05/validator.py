def validate_config(config):
    required_keys = [
        "project_name",
        "input_folder",
        "s3_bucket",
        "s3_prefix",
        "summary_file",
        "report_file",
        "log_file"
    ]

    for key in required_keys:
        if key not in config:
            raise ValueError(f"Missing required config value: {key}")
    
    for key in required_keys:
        if not config.get(key):
            raise ValueError(f"'{key}' is missing or empty.")