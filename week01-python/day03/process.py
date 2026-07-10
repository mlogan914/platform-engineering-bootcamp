# ===============================================
# -- Assignment 4 – Launch a Process --
# ===============================================
'''
subprocess lets your Python program start and communicate with other programs.

- subprocess.run() executes the command
- capture_output=True stores output instead of printing directly
- text=True converts output to string
- result.stdout contains the output

'''
import logging
import subprocess
from pathlib import Path


DAY03_DIR = Path(__file__).resolve().parent
LOG_FILE = DAY03_DIR / "process.log"
INPUT_DIR = DAY03_DIR / "incoming_data"


logging.basicConfig(
    level=logging.INFO,
    filename=LOG_FILE,
    filemode="w",
    format="%(asctime)s - %(levelname)s - %(message)s",
)

def launch_pipeline(project, input_dir):
    input_path = Path(input_dir)

    if not project.strip():
        logging.error("Project name is empty")
        print("Error: Project name cannot be empty.")
        return

    if not input_path.is_dir():
        logging.error("Input directory does not exist: %s", input_path)
        print(f"Error: Input directory does not exist: {input_path}")
        return

    command = [
        "echo",
        f"Launching pipeline for {project} using directory {input_path}...",
    ]

    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=True,
        )

        logging.info(
            "Pipeline launched successfully for project %s using %s",
            project,
            input_path,
        )

        print(result.stdout.strip())

    except FileNotFoundError:
        logging.exception("The pipeline command was not found")
        print("Error: The pipeline command was not found.")

    except subprocess.CalledProcessError as error:
        logging.error(
            "Pipeline failed with exit code %s: %s",
            error.returncode,
            error.stderr.strip(),
        )
        print("Error: Pipeline execution failed. Check process.log.")


def main():
    launch_pipeline("VEXIN-03", INPUT_DIR)


if __name__ == "__main__":
    main()
    
# res = subprocess.run(
#     ["echo", "Launcging workflow..."],
#     capture_output=True,
#     text=True,
#     check=True
# )

# print(res.stdout)

# subprocess.run(["ls", "-l"])

# subprocess.run(["git", "log", "--oneline"])

## -- End of Program Code -- ##