# ===============================================
# -- Assignment 3 – Logging --
# ===============================================
import logging
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
LOG_PATH = BASE_DIR / "day03"

'''
Source Lesson:
https://www.youtube.com/watch?v=urrfJgHwIJA

LogRecord attributes for formatting:
https://docs.python.org/3/library/logging.html#logrecord-attributes

Sample:
logging.debug("debug message")
logging.info("info message")
logging.warning("warning message")  # default ^ (and above)
logging.error("error message")
logging.critical("critical message")

Output:
WARNING:root:warning message
ERROR:root:error message
CRITICAL:root:critical message
# root = root logger if no custom logger is defined

'''

logging.basicConfig(level=logging.INFO, filename=LOG_PATH / "pipeline.log", filemode="w",
                    format="%(asctime)s - %(levelname)s - %(message)s") # ERROR and above

logging.debug("debug message")
logging.info("info message")
logging.warning("warning message")
logging.error("error message")
logging.critical("critical message")

# Embed variable
x=2
logging.info(f"the value of x is {x}")

# Log exception traceback
try:
    1 / 0
except ZeroDivisionError as e:
    logging.exception("ZeroDivisionError")


# Custom logger
'''
- handler allows us to configure logger
- create a formatter for the custom logger
- add the formatter to the handler
- add the handler to the logger
'''
logger = logging.getLogger(__name__) # name of the current module
handler = logging.FileHandler(LOG_PATH / 'custom_log.log', mode="w")
formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")

handler.setFormatter(formatter)
logger.addHandler(handler)

logger.info("test the custom logger")

### -- Enf of Program Code -- ##