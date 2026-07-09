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
import subprocess

res = subprocess.run(["python3", "--version"], capture_output=True, text=True)
print(res.stdout)

subprocess.run(
    ["echo", "Hello"],
    capture_output=True,
    text=True,
    check=True
)

subprocess.run(["ls", "-l"])

## -- End of Program Code -- ##