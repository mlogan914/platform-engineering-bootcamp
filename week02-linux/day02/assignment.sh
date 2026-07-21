# ==============================
# Assignment
# ==============================

"
A bioinformatics team cannot access sequencing data.

Determine why and repair the permissions.

The sequencing data lives in a directory:
sequencing_data/
├── run001.fastq
├── run002.fastq
└── metadata.csv

"

sudo groupadd bioinformatics
sudo groupadd platform
sudo groupadd developers

getent group bioinformatics

"
bioinformatics:x:1004:
"

mkdir -p sequencing_data

touch sequencing_data/run001.fastq
touch sequencing_data/run002.fastq
touch sequencing_data/metadata.csv

# Inspect folder permissions
ls -ld sequencing_data

"
drwxrwxr-x 2 mlogan mlogan 4096 Jul 21 15:48 sequencing_data/
"

# Inspect file permissions
ls -l sequencing_data
 
# Change permissions
 sudo chgrp -R bioinformatics sequencing_data

 ls -ld sequencing_data

"
 drwxrwxr-x 2 mlogan bioinformatics 4096 Jul 21 15:48 sequencing_data
"

 ls -l sequencing_data

"
-rw-rw-r-- 1 mlogan bioinformatics 0 Jul 21 15:48 metadata.csv
-rw-rw-r-- 1 mlogan bioinformatics 0 Jul 21 15:48 run001.fastq
-rw-rw-r-- 1 mlogan bioinformatics 0 Jul 21 15:48 run002.fastq
"

find sequencing_data -type d -exec chmod 770 {} \;
find sequencing_data -type f -exec chmod 660 {} \;

find sequencing_data -name "*.fastq" -exec chmod 660 {} \;
find sequencing_data -name "*.csv" -exec chmod 660 {} \;
find sequencing_data -name "*.sh" -exec chmod 770 {} \;
