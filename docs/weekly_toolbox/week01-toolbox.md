# Python Toolbox (Week 1)

## Debugging

| Task | Command |
|------|---------|
| Check an object's type | `type(obj)` |
| View available methods | `dir(obj)` |
| Read documentation | `help(obj)` |
| Discover methods in VS Code | `obj.` *(autocomplete)* |

---

# Strings (`str`)

**Common Uses**

- User input
- Filenames
- Text processing

| Method | Purpose |
|---------|---------|
| `strip()` | Remove leading/trailing whitespace |
| `split()` | Split a string |
| `replace()` | Replace text |
| `upper()` | Convert to uppercase |
| `lower()` | Convert to lowercase |
| `startswith()` | Check prefix |
| `endswith()` | Check suffix |
| `find()` | Find substring |

---

# Lists (`list`)

| Method | Purpose |
|---------|---------|
| `append()` | Add one item |
| `extend()` | Add multiple items |
| `pop()` | Remove an item |
| `sort()` | Sort list |
| `reverse()` | Reverse list |

---

# Dictionaries (`dict`)

| Method | Purpose |
|---------|---------|
| `get()` | Retrieve value safely |
| `keys()` | Get keys |
| `values()` | Get values |
| `items()` | Get key/value pairs |
| `update()` | Update dictionary |

---

# Path (`pathlib.Path`)

```python
from pathlib import Path
```

```python
folder = Path("./incoming_data")
```

| Method | Purpose |
|---------|---------|
| `exists()` | Check if path exists |
| `is_dir()` | Check if directory |
| `is_file()` | Check if file |
| `glob()` | Find matching files |
| `iterdir()` | Iterate directory |
| `mkdir()` | Create directory |
| `rename()` | Rename path |

---

# argparse

```python
import argparse
```

| Function | Purpose |
|----------|----------|
| `ArgumentParser()` | Create parser |
| `add_argument()` | Define arguments |
| `parse_args()` | Parse CLI arguments |

Access arguments:

```python
args.project
args.input_folder
```

---

# logging

```python
import logging
```

| Function | Purpose |
|----------|----------|
| `basicConfig()` | Configure logging |
| `getLogger()` | Create custom logger |
| `info()` | Informational message |
| `warning()` | Warning message |
| `error()` | Error message |
| `critical()` | Critical error |

---

# subprocess

```python
import subprocess
```

| Function | Purpose |
|----------|----------|
| `run()` | Run another program |

Useful parameters:

| Parameter | Purpose |
|-----------|----------|
| `check=True` | Raise exception on failure |
| `capture_output=True` | Capture stdout/stderr |
| `text=True` | Return strings instead of bytes |

Example:

```python
subprocess.run(
    ["echo", "Hello"],
    check=True,
    capture_output=True,
    text=True
)
```

---

# json

```python
import json
```

| Function | Purpose |
|----------|----------|
| `load()` | Read JSON file |
| `loads()` | Read JSON string |
| `dump()` | Write JSON file |
| `dumps()` | Convert object to JSON string |

---

# yaml (PyYAML)

```python
import yaml
```

| Function | Purpose |
|----------|----------|
| `safe_load()` | Read YAML |
| `dump()` | Write YAML |

---

# boto3 (AWS)

```python
import boto3
```

| Function | Purpose |
|----------|----------|
| `client()` | Create AWS client |
| `resource()` | Create AWS resource |

Common S3 methods:

| Method | Purpose |
|---------|---------|
| `upload_file()` | Upload file |
| `download_file()` | Download file |
| `list_objects_v2()` | List objects |

---

# Python Workflow

When using an object:

1. **What type is it?** (`type(obj)`)
2. **What methods does it have?** (`dir(obj)` or VS Code autocomplete)
3. **Read the documentation** (`help(obj)` or official docs)
4. **Use the appropriate method**