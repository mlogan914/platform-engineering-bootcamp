# ==============================
# Assignment - Networking
# ==============================

# ==============================
# Exercise 6 – Verify Network Connectivity
# ==============================
"
Objective

Confirm network access.

Tasks
1. Display your hostname.
2. Ping Google's DNS server.
3. Ping GitHub.
4. Stop the ping manually.
"

# 1. Display your hostname.
hostname

# 2. Ping Google's DNS server.
ping google.com

"
PING google.com (142.251.41.14) 56(84) bytes of data.
64 bytes from lga34s40-in-f14.1e100.net (142.251.41.14): icmp_seq=1 ttl=115 time=8.16 ms
64 bytes from dclaxb-au-in-f14.1e100.net (142.251.41.14): icmp_seq=2 ttl=115 time=6.72 ms
"

# 3. Ping GitHub.

ping github.com

"
PING github.com (140.82.116.3) 56(84) bytes of data.
64 bytes from lb-140-82-116-3-sea.github.com (140.82.116.3): icmp_seq=1 ttl=51 time=32.4 ms
64 bytes from lb-140-82-116-3-sea.github.com (140.82.116.3): icmp_seq=2 ttl=51 time=30.8 ms
"

# Stop the ping manually.
" Ctrl+C" 


# ==============================
# Exercise 7 – Make HTTP Requests
# ==============================
"
Objective

Inspect HTTP responses.

Tasks
1. Retrieve the headers for GitHub.
2. Download a webpage.
3. Save it locally.
"

# 1. Retrieve the headers for GitHub.
" 
HTTP headers are metadata sent along with an HTTP request or response. 
They aren't the webpage or API data itself—they provide information about the 
communication.
"
curl -I https://github.com/

"
HTTP/2 200 
date: Tue, 28 Jul 2026 03:10:19 GMT
content-type: text/html; charset=utf-8
server: ...
"

# 2. Download a webpage.
curl https://github.com/

# 3. Save a file locally.
wget https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore

# ==============================
# Exercise 8 – Inspect Network Configuration
# ==============================
"
Objective

View your network interfaces.

Tasks
1. Display all interfaces.
2. Identify your IP address.
3. Identify the loopback interface.
"

# 1. Display all interfaces.
ip addr

# 2. Identify your IP address.
"
like:  inet 10.0.3.15/24
"

# 3. Identify the loopback interface.
"
like: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
"
# ==============================
# Exercise 9 – View Listening Ports
# ==============================
"
Exercise 9 – View Listening Ports
Objective

Inspect open network connections.

Tasks
1. Display listening TCP ports.
2. Compare the output of ss and netstat (if installed).
"

# 1. Display listening TCP ports.

ss -tuln
"
SSH Example:

Netid     State      Recv-Q     Send-Q         Local Address:Port            Peer Address:Port     Process   
tcp   LISTEN   0   128   [::]:22   [::]:*

"
# 2. Compare the output of ss and netstat (if installed).
"
SSH Example:
Proto Recv-Q Send-Q Local Address           Foreign Address         State  
tcp6       0      0 :::22                   :::*                    LISTEN

"

# ==============================
# Exercise 10 – DNS Lookup
# ==============================
"
Objective

Verify DNS resolution.

Tasks
1. Find the IP address for:
github.com
2. Repeat using another DNS utility.
"

# 1. Find the IP address for: github.com
dig github.com

"

;; ANSWER SECTION:
github.com.             10      IN      A       140.82.116.3

"
# 2. Repeat using another DNS utility.
nslookup github.com

"
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   github.com
Address: 140.82.116.4

"