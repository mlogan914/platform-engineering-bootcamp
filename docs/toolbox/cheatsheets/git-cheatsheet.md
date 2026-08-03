# Git Cheat Sheet

<details>
<summary><strong>1. Initial Repository Setup (New Project)</strong></summary>

## Clone the Repository

### HTTPS

```bash
git clone https://github.com/company/project.git
```

### SSH

```bash
git clone git@github.com:company/project.git
```

Move into the project:

```bash
cd project
```

---

## Verify Remote

```bash
git remote -v
```

Example:

```text
origin  git@github.com:company/project.git (fetch)
origin  git@github.com:company/project.git (push)
```

---

## Check Current Branch

```bash
git branch
```

or

```bash
git status
```

---

## Configure Identity (One-Time Per Machine)

```bash
git config --global user.name "Your Name"
git config --global user.email "you@company.com"
```

View configuration:

```bash
git config --list
```

---

## Authentication

### HTTPS

GitHub:

- Personal Access Token (PAT)
- Git Credential Manager
- GitHub CLI (`gh auth login`)

---

### SSH

Generate key:

```bash
ssh-keygen -t ed25519 -C "work-laptop"
```

View public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Upload the **public key** to:

- GitHub
- GitLab
- Bitbucket
- Azure DevOps

Test connection:

```bash
ssh -T git@github.com
```

---

## Common Remote Commands

View remotes:

```bash
git remote -v
```

Change remote URL:

```bash
git remote set-url origin git@github.com:company/project.git
```

</details>

---

<details>
<summary><strong>2. Daily Development Workflow</strong></summary>

## Before Starting Work

Switch to main:

```bash
git checkout main
```

Get the latest changes:

```bash
git pull origin main
```

Create a feature branch:

```bash
git checkout -b feature/my-feature
```

---

## During Development

Check status:

```bash
git status
```

View changes:

```bash
git diff
```

Stage files:

```bash
git add file.py
```

Stage everything:

```bash
git add .
```

Commit:

```bash
git commit -m "Add API validation"
```

---

## Push Your Branch

First push:

```bash
git push -u origin feature/my-feature
```

Future pushes:

```bash
git push
```

---

## Stay Current

Fetch remote updates:

```bash
git fetch
```

Update your branch from main:

```bash
git checkout main
git pull origin main
git checkout feature/my-feature
git merge main
```

(Some teams use `git rebase` instead of `merge`.)

---

## Before Opening a Pull Request

```bash
git status
git diff
git log --oneline --decorate --graph -10
```

Push latest commits:

```bash
git push
```

Open a Pull Request.

</details>

---

<details>
<summary><strong>3. Common Commands</strong></summary>

| Task | Command |
|------|---------|
| Status | `git status` |
| Stage file | `git add file` |
| Stage everything | `git add .` |
| Commit | `git commit -m "message"` |
| Push | `git push` |
| Pull | `git pull` |
| Fetch | `git fetch` |
| View history | `git log --oneline` |
| View changes | `git diff` |
| Show branches | `git branch` |
| Switch branch | `git checkout branch` |
| Create branch | `git checkout -b branch` |
| Delete local branch | `git branch -d branch` |

</details>

---

<details>
<summary><strong>4. Typical Platform Engineer Workflow</strong></summary>

```text
Clone repository
        │
        ▼
Checkout main
        │
        ▼
Pull latest changes
        │
        ▼
Create feature branch
        │
        ▼
Make code changes
        │
        ▼
git status
git diff
        │
        ▼
git add
        │
        ▼
git commit
        │
        ▼
git push
        │
        ▼
Open Pull Request
        │
        ▼
Merge into main
```

</details>

---

<details>
<summary><strong>5. Common Troubleshooting</strong></summary>

### Authentication failed

Check remote:

```bash
git remote -v
```

If using HTTPS:

- Verify PAT or GitHub authentication.

If using SSH:

```bash
ssh -T git@github.com
```

---

### Forgot what changed?

```bash
git status
git diff
```

---

### Pull before pushing?

Generally yes.

```bash
git checkout main
git pull origin main
```

Then merge or rebase into your feature branch if needed.

---

### Accidentally staged everything

```bash
git restore --staged .
```

---

### Discard local changes

Single file:

```bash
git restore file.py
```

Everything:

```bash
git restore .
```

**Warning:** This permanently discards uncommitted changes.

</details>

---

<details>
<summary><strong>6. HTTPS vs SSH</strong></summary>

| HTTPS | SSH |
|--------|-----|
| Uses PAT or credential manager | Uses SSH key pair |
| Easier to start | Better for daily development |
| May prompt for credentials | Passwordless after setup |
| `https://github.com/...` | `git@github.com:...` |

Typical recommendation:

- Personal projects → Either HTTPS or SSH.
- Company projects → Usually SSH.

</details>