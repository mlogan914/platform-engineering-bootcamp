# Bash Git Branch Prompt Setup (Ubuntu/Linux)

This guide configures Bash to display the current Git branch in the terminal prompt.

Example:

```text
(.venv) user@user-VirtualBox:~/platform_practice (main)$
```

---

# 1. Verify Git is Installed

```bash
git --version
```

If needed:

```bash
sudo apt update
sudo apt install git
```

---

# 2. Locate the Git Prompt Script

On Ubuntu:

```bash
dpkg -L git | grep git-prompt
```

Expected output:

```text
/etc/bash_completion.d/git-prompt
```

---

# 3. Create a ~/.bashrc (If Missing)

Ubuntu provides a default template:

```bash
cp /etc/skel/.bashrc ~/.bashrc
```

Verify:

```bash
ls -l ~/.bashrc
```

---

# 4. Edit ~/.bashrc

Open:

```bash
nano ~/.bashrc
```

Add the following to the bottom of the file:

```bash
# Git branch prompt
source /etc/bash_completion.d/git-prompt

export PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '
```

> **Note:** If you're using a Python virtual environment (`venv`), don't include `(.venv)` in `PS1`. The virtual environment automatically prepends it when activated.

---

# 5. Reload Bash

```bash
source ~/.bashrc
```

---

# 6. Verify

Navigate to any Git repository:

```bash
cd ~/platform_practice
```

You should now see something similar to:

```text
user@user-VirtualBox:~/platform_practice (main)$
```

Activate your virtual environment:

```bash
source .venv/bin/activate
```

Now the prompt should become:

```text
(.venv) user@user-VirtualBox:~/platform_practice (main)$
```

---

# Troubleshooting

## Git prompt script not found

Search for it:

```bash
dpkg -L git | grep git-prompt
```

or

```bash
find /usr -name "git-prompt*" 2>/dev/null
```

---

## ~/.bashrc Missing

Recreate it:

```bash
cp /etc/skel/.bashrc ~/.bashrc
```

---

## Changes Don't Appear

Reload Bash:

```bash
source ~/.bashrc
```

or open a new terminal.

---

## Verify Current Branch

Without modifying your prompt, you can always check the current branch:

```bash
git branch --show-current
```

---

# Result

Your prompt will automatically display:

- Current directory
- Current Git branch
- Active Python virtual environment (if activated)

Example:

```text
(.venv) user@user-VirtualBox:~/platform_practice (main)$
```