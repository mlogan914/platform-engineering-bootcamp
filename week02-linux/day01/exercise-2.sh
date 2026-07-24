#!/bin/bash

# ==============================
# Copy configuration files into multiple environment folders.
# ==============================

"
Example:
project/
├── configs/
│   ├── dev/
│   ├── test/
│   └── prod/

You can copy into each environemnt:
cp project/configs/app.conf project/configs/dev/
cp project/configs/app.conf project/configs/test/
cp project/configs/app.conf project/configs/prod/

or loop:
for env in dev test prod; do
    cp project/configs/app.conf "project/configs/$env/"
done

From the terminal:
for env in dev test prod; do cp project/configs/app.conf "project/configs/$env/"; done

"

mkdir -p project/configs/{dev,test,prod}

touch project/configs/app.conf

for env in dev test prod; 
    do cp project/configs/app.conf "project/configs/$env/" 
done