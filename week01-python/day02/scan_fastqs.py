# ===============================================
# -- Assignment 1 – Create Sample Data --
# ===============================================
'''
mkdir incoming_data
cd incoming_data/
touch Patient{001,002}_L001_R{1,2}.fastq.gz

Patient002_L001_R1.fastq.gz
Patient001_L001_R1.fastq.gz
Patient002_L001_R2.fastq.gz
Patient001_L001_R2.fastq.gz

'''
# ===============================================
# -- Assignment 2 – Scan a Directory --
# ===============================================
from pathlib import Path
import json
import yaml

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_PATH = BASE_DIR / "day02" / "incoming_data"
OUTPUT_JSON = BASE_DIR / "day02" / "summary.json"
OUTPUT_YAML = BASE_DIR / "day02" / "summary.yaml"

print(BASE_DIR)
print(DATA_PATH)

count = 0
for file in DATA_PATH.glob("*.fastq.gz"):
    print(file.name)
    count += 1

print(f"Total FASTQ files: {count}")

count = 0
subjects = set()
for file in DATA_PATH.glob("*.fastq.gz"):
    name = file.name.split('_')
    subject = name[0]
    subjects.add(subject)

count = len(subjects)

print(f"Total number of subjects: {count}")

r1_count = 0
r2_count = 0
for file in DATA_PATH.glob("*.fastq.gz"):
    # name = file.name.split('_')
    # name_part = name[2]
    # read_part = name_part.split('.')
    # read = read_part[0]

    read = file.name.split("_")[2].split(".")[0]

    if read == "R1":
        r1_count +=1

    elif read == "R2":
        r2_count +=1

print(f"Total number of R1: {r1_count}")
print(f"Total number of R2: {r2_count}")

# ===============================================
# Assignment 3 – Produce JSON Output
# ===============================================
def filenames(DATA_PATH):
    filenames = []
    for file in DATA_PATH.glob("*.fastq.gz"):
        filenames.append(file.name)
    return sorted(filenames)


def total_files(DATA_PATH):
    total_files = 0
    for file in DATA_PATH.glob("*.fastq.gz"):
        print(file.name)
        total_files += 1

    return total_files
 
def total_subjects(DATA_PATH):
    subjects = set()
    for file in DATA_PATH.glob("*.fastq.gz"):
        name = file.name.split('_')
        subject = name[0]
        subjects.add(subject)

    return len(subjects)

def total_reads(DATA_PATH):
    r1_count = 0
    r2_count = 0
    for file in DATA_PATH.glob("*.fastq.gz"):
        read = file.name.split("_")[2].split(".")[0]

        if read == "R1":
            r1_count +=1

        elif read == "R2":
            r2_count +=1

    return r1_count, r2_count

summary = {
    "Total files": total_files(DATA_PATH),
    "Total patients": total_subjects(DATA_PATH),
    "List of filenames": filenames(DATA_PATH),
}

with open(OUTPUT_JSON, "w") as f:
    json.dump(summary, f, indent=4)

# ===============================================
# -- Stretch Goal --
# ===============================================
with open(OUTPUT_YAML, "w") as f:
    yaml.dump(summary, f, indent=2)

### -- End of Program Code -- ###