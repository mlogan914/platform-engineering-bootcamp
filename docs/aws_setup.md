# AWS & boto3 Setup Cheat Sheet

## References

### boto3
- https://docs.aws.amazon.com/boto3/latest/guide/quickstart.html#using-boto3
- S3 Examples:
  - https://docs.aws.amazon.com/boto3/latest/guide/s3-examples.html

### AWS CLI
- https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

---

# Install boto3

Verify if it is installed:

```bash
python -m pip show boto3
```

Install:

```bash
python -m pip install boto3
```

> **Why use `python -m pip`?**
>
> It guarantees you are installing packages into the same Python interpreter that will execute your script.

Verify:

```python
import boto3

print(boto3.__version__)
```

---

# Install AWS CLI (Ubuntu/Linux)

Download:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

Extract:

```bash
unzip awscliv2.zip
```

Install:

```bash
sudo ./aws/install
```

Verify installation:

```bash
aws --version
```

---

# Configure AWS Credentials

Run:

```bash
aws configure
```

You'll be prompted for:

- AWS Access Key ID
- AWS Secret Access Key
- Default region
- Default output format

Credentials are stored in:

```text
~/.aws/credentials
~/.aws/config
```

Verify your credentials:

```bash
aws sts get-caller-identity
```

If successful, AWS will return information about the authenticated IAM user or role.

---

# boto3 Client vs Resource

## Client (Recommended)

```python
s3 = boto3.client("s3")
```

Use for:

- Uploading files
- Downloading files
- Listing objects
- Creating AWS resources
- Most automation scripts

Examples:

```python
s3.upload_file(...)
s3.download_file(...)
s3.download_fileobj(...)
s3.list_objects_v2(...)
```

---

## Resource

```python
s3 = boto3.resource("s3")
```

Creates higher-level Python objects.

Examples:

```python
bucket = s3.Bucket("my-bucket")
obj = s3.Object("my-bucket", "file.csv")
```

Examples:

```python
bucket.upload_file(...)
bucket.download_file(...)
bucket.download_fileobj(...)
```

---

## Rule of Thumb

- **Client** → Call AWS APIs directly (recommended for platform engineering).
- **Resource** → Work with AWS resources as Python objects.