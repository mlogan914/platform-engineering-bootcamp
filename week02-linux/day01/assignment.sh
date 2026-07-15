# ==============================
# Assignment
# ==============================
"
A sequencing server has become cluttered.

Organize the filesystem into a clean project structure while preserving all data.

"

"
Initial State

Create a messy directory:

cluttered_server/
├── app.log
├── upload.log
├── debug.log
├── config.yml
├── pipeline.py
├── notes.txt
├── run.sh
├── sample1.fastq.gz
├── sample2.fastq.gz
└── old_report.txt

"

mkdir cluttered_server
cd cluttered_server

touch {app,upload,debug}.log
touch config.yml pipeline.py notes.txt run.sh old_report.txt
touch sample{1..2}.fastq.gz

"

Goal

Transform it into:
project/
├── configs/
│   └── config.yml
├── scripts/
│   ├── pipeline.py
│   └── run.sh
├── logs/
│   ├── app.log
│   ├── upload.log
│   └── debug.log
├── data/
│   ├── sample1.fastq.gz
│   └── sample2.fastq.gz
├── reports/
│   └── old_report.txt
└── notes.txt

Requirements
Use only commands you've learned today:

pwd
ls
mkdir
mv
cp
tree
find
du
df

"

mkdir -p project/{configs,scripts,logs,data,reports}

mv config.yml project/configs/

mv pipeline.py run.sh project/scripts/

mv *.log project/logs/

mv *.fastq.gz project/data/

mv old_report.txt project/reports/

mv notes.txt project/

tree project

"
user@user-VirtualBox:~/platform_practice/week02-linux/day01/assignment/cluttered_server/project (week2-linux)$ tree
.
├── configs
│   └── config.yml
├── data
│   ├── sample1.fastq.gz
│   └── sample2.fastq.gz
├── logs
│   ├── app.log
│   ├── debug.log
│   └── upload.log
├── notes.txt
├── reports
│   └── old_report.txt
└── scripts
    ├── pipeline.py
    └── run.sh

"

cd ..

find project -name "*.log"

"
project/logs/upload.log
project/logs/app.log
project/logs/debug.log

"

du -sh project/*

"

4.0K    project/configs
4.0K    project/data
4.0K    project/logs
0       project/notes.txt
4.0K    project/reports
4.0K    project/scripts

"