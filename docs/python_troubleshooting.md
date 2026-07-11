# Python Virtual Environment & Module Troubleshooting

When a module cannot be imported or packages don't appear to install correctly, work through this checklist.

---

# Creating a Virtual Environment

## Linux / macOS

Create a virtual environment:

```bash
python3 -m venv .venv
```

Activate it:

```bash
source .venv/bin/activate
```

Deactivate it:

```bash
deactivate
```

---

## Windows (PowerShell)

Create a virtual environment:

```powershell
python -m venv .venv
```

Activate it:

```powershell
.venv\Scripts\Activate.ps1
```

Deactivate it:

```powershell
deactivate
```

> **Note:** If PowerShell blocks activation, you may need to run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Windows (Command Prompt)

Activate:

```cmd
.venv\Scripts\activate.bat
```

Deactivate:

```cmd
deactivate
```

---

# Verify the Active Virtual Environment

```bash
echo $VIRTUAL_ENV
```

Expected:

```text
/path/to/project/.venv
```

On Windows PowerShell:

```powershell
echo $env:VIRTUAL_ENV
```

---

# Verify Python

Linux/macOS:

```bash
which python
```

Windows:

```powershell
where python
```

Expected:

```text
.../.venv/bin/python
```

or

```text
...\.venv\Scripts\python.exe
```

---

# Verify pip

Linux/macOS:

```bash
which pip
```

Windows:

```powershell
where pip
```

Expected:

```text
.../.venv/bin/pip
```

or

```text
...\.venv\Scripts\pip.exe
```

If you see something like:

```text
/usr/bin/pip
```

or

```text
C:\Python...\Scripts\pip.exe
```

you're using the system pip instead of the virtual environment.

---

# Check PATH

Linux/macOS:

```bash
echo "$PATH"
```

Windows:

```powershell
echo $env:PATH
```

The **first** entry should be your virtual environment's `bin` (Linux/macOS) or `Scripts` (Windows) directory.

---

# Confirm pip Exists Inside the Virtual Environment

Linux/macOS:

```bash
ls -l .venv/bin/pip*
```

Windows:

```powershell
dir .venv\Scripts\pip*
```

Expected:

```text
pip
pip3
```

(or `pip.exe` on Windows)

---

# Install Packages Correctly

Always prefer:

```bash
python -m pip install <package>
```

Example:

```bash
python -m pip install boto3
```

This guarantees the package is installed into the same Python interpreter running your program.

---

# Verify the Package

```bash
python -m pip show boto3
```

or

```python
import boto3

print(boto3.__version__)
```

---

# Clear Bash's Cached Executables (Linux/macOS)

Sometimes Bash remembers old executable locations.

```bash
hash -r
```

---

# If You Renamed or Moved the Project

Virtual environments are **not portable**.

If your project folder changes names (for example):

```text
platform_practice_week1
```

↓

```text
platform_practice
```

the virtual environment may still reference the old location.

The easiest solution is to recreate it.

```bash
deactivate

rm -rf .venv

python3 -m venv .venv

source .venv/bin/activate

python -m pip install --upgrade pip
```

Then reinstall your project dependencies.

---

# My Quick Debug Checklist

Whenever something feels wrong, I run:

```bash
echo $VIRTUAL_ENV

echo "$PATH"

which python

which pip

python -m pip --version

python -m pip show <package>
```

---

# Lessons Learned

- Seeing `(.venv)` in the prompt **does not guarantee** you're using the correct Python or pip.
- Always verify `which python` and `which pip`.
- Prefer `python -m pip install ...` over `pip install ...`.
- If a virtual environment was created before renaming or moving a project, recreate the virtual environment.
- If `pip` appears to point to the wrong executable, try:

```bash
hash -r
```

to clear Bash's cached executable paths.