# ===============================================
# -- Assignment 1 – Sequencing Run Inventory --
# ===============================================
# runs = [
#     {
#         "run_id": "RUN001",
#         "project_name": "Cancer Study",
#         "status": "Completed",
#         "sample_count": 24
#     },
#     {
#         "run_id": "RUN002",
#         "project_name": "Rare Disease",
#         "status": "Running",
#         "sample_count": 12
#     },
#     {
#         "run_id": "RUN003",
#         "project_name": "Lung Biomarkers",
#         "status": "Completed",
#         "sample_count": 48
#     },
#     {
#         "run_id": "RUN004",
#         "project_name": "Whole Genome",
#         "status": "Queued",
#         "sample_count": 96
#     }
# ]

# total_runs = len(runs)
# print(f"Total number of runs: {total_runs}")

# total_samples = 0
# for run in runs:
#     total_samples += run["sample_count"]

# print (f"Total number of samples: {total_samples}")


# completed_runs = 0
# for run in runs:
#     if run["status"] == "Completed":
#         completed_runs += 1

# print(completed_runs)


# total_samples = 0
# # total_runs = 0
# total_runs = len(runs)

# for run in runs:
#     total_samples += run["sample_count"]
#     # total_runs += 1

# average = total_samples / total_runs

# print (f"Average runs per sample: {average}")


# ===============================================
# -- Assignment 2 – Refactor into Functions --
# ===============================================
def load_runs():
    runs = [
    {
        "run_id": "RUN001",
        "project_name": "Cancer Study",
        "status": "Completed",
        "sample_count": 24
    },
    {
        "run_id": "RUN002",
        "project_name": "Rare Disease",
        "status": "Running",
        "sample_count": 12
    },
    {
        "run_id": "RUN003",
        "project_name": "Lung Biomarkers",
        "status": "Completed",
        "sample_count": 48
    },
    {
        "run_id": "RUN004",
        "project_name": "Whole Genome",
        "status": "Queued",
        "sample_count": 96
    }
]
    return runs

def count_samples(runs):
    total_samples = 0

    for run in runs:
        total_samples += run["sample_count"]
    
    return total_samples


def completed_runs(runs):
    count = 0

    for run in runs:
        if run["status"] == "Completed":
            count += 1

    return count


def average_samples(runs):
    total_runs = len(runs)
    total_samples = 0

    for run in runs:
        total_samples += run["sample_count"]

    average = total_samples / total_runs
    return average


def main():
    runs = load_runs()

    print(f"Total runs: {len(runs)}")
    print(f"Total samples: {count_samples(runs)}")
    print(f"Completed runs: {completed_runs(runs)}")
    print(f"Average samples per run: {average_samples(runs)}")

main()

# ===============================================
# -- Stretch Goal --
# ===============================================
from pathlib import Path
import json

BASE_DIR = Path(__file__).resolve().parent.parent
OUTPUT_FILE = BASE_DIR / "day01" / "sorted.json"

print(BASE_DIR)
print(OUTPUT_FILE)

runs = load_runs()

runs.sort(key=lambda run: run["sample_count"])

print(runs)

with open(OUTPUT_FILE, "w") as f:
    json.dump(runs, f, indent=4)

### --- End of Program Code --- ###