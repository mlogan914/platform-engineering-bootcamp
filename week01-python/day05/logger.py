import logging
from pathlib import Path


def setup_logger(log_file):
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[
            logging.FileHandler(log_file, mode="w"), # log file
            logging.StreamHandler() #
        ]
    )
## -- End of Program Code -- ##