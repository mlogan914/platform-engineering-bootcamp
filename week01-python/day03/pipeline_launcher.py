# ===============================================
# -- Assignment 1 – Command Line Utility --
# ===============================================
''' 

Pass params to script using argparse

Example call:

python3 pipeline_launcher.py \
    --project VEXIN-03 \
    --input-folder ./incoming_data

'''
# import argparse

# parser = argparse.ArgumentParser()

# parser.add_argument(
#     '--project', 
#     help='Project or study name'

#     )

# parser.add_argument(
#     '--input-folder', 
#     help='Input folder'

#     )

# args = parser.parse_args()

# '''

# Note that although the command-line argument uses a hyphen (--input-folder), 
# Python converts it to an underscore (args.input_folder).

# '''

# print(f'\nProcessing project: {args.project} \nSource directory: {args.input_folder}')

# ===============================================
# -- Assignment 2 – Validate User Input --
# ===============================================
'''

required=True checks that the argument was provided.
Path.exists() checks that the path exists.
Path.is_dir() checks that it is a folder.
parser.error() gives the user a clean command-line error instead of a Python traceback.

object.property.method

'''

import argparse
from pathlib import Path

parser = argparse.ArgumentParser()

parser.add_argument(
    "--project", 
    required=True, 
    help="Project or study name"

    )
parser.add_argument(
    "--input-folder", 
    required=True, 
    help="Input folder"

    )

args = parser.parse_args()

input_folder = Path(args.input_folder)

if not args.project.strip():
    parser.error("--project cannot be empty")

if not input_folder.exists():
    parser.error(f"--input-folder does not exist: {input_folder}")

if not input_folder.is_dir():
    parser.error(f"--input-folder must be a directory: {input_folder}")

print(f"Project: {args.project}")
print(f"Input folder: {input_folder}")

## -- End of Porgram Code -- ##