# ==============================
# Assignment
# ==============================

"
Scenario: New Compute Server

A new Ubuntu compute server has been provisioned for running a pipeline.

"

# The DevOps engineer says:
# "I've provisioned the VM. I need your SSH public key so you can log in.""
# Your objective is to gain passwordless SSH access.


# Local server
ssh-keygen -t ed25519 -C "cluster_name" -f ~/.ssh/cluster_ed25519

"

What this does
-t ed25519 → Use the Ed25519 algorithm.
-C "cluster_name" → Add a comment to help identify the key later.
-f ~/.ssh/cluster_ed25519 → Save the key pair to:
~/.ssh/cluster_ed25519 (private)
~/.ssh/cluster_ed25519.pub (public)

"

"
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/user/.ssh/cluster_ed25519
Your public key has been saved in /home/user/.ssh/cluster_ed25519.pub
The key fingerprint is:
SHA256:S6we/XUNPTWU1gNRkLm8WEpo2UgJuFtRFGSELUS3fks cluster_name
The key's randomart image is:
+--[ED25519 256]--+
|      ++OOo  +Boo|
|     . +o+.  o.+.|
|      . +.= . o.o|
|     . o.= o + .o|
|      o S..E+ o..|
|     . + .oo.. o.|
|      o o  .. . .|
|     . . . . .   |
|      .   .      |
+----[SHA256]-----+
"

# Which file do you send, and how would you display its contents to copy into Slack or Teams?"

cat ~/.ssh/cluster_ed25519.pub
"
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBTDLNzYAxs3X/0PzYbdtUfteOs0EWxCUE6L0zLP2wqq cluster_name

"

# Now they send you the server information:
# "Thanks! I've added your public key to /home/mlogan/.ssh/authorized_keys on the server."

# Server Information:
# Hostname: bio-cluster.company.com
# Username: mlogan



# How do you connect to a server?

# Run on the local machine.
# Use -i when the private key has a non-default filename.
ssh -i ~/.ssh/cluster_ed25519 mlogan@bio-cluster.company.com


# How do you install your public key on a server?

# Option 1: You have password access.
# Run from the local machine.
ssh-copy-id -i ~/.ssh/cluster_ed25519.pub \
  mlogan@bio-cluster.company.com

# Option 2: An administrator manages access.
# Display the public key locally and send it to the administrator.
cat ~/.ssh/cluster_ed25519.pub

# The administrator adds it on the remote server to:
# /home/mlogan/.ssh/authorized_keys

" 

commands:
ssh-copy-id = install the public key
ssh         = connect using the private key

"