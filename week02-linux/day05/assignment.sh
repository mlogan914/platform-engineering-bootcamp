# ==============================
# Assignment - Logs & Troubleshooting
# ==============================

# ==============================
# Exercise 1 — Follow a Live Log File
# ==============================
"
Objective

Use tail -f to monitor new log entries as they are written.
"

mkdir -p logs

touch logs/app.log

ls -l logs/app.log

cat > logs/app.log <<'EOF'
2026-08-02 18:20:01 INFO Application started
2026-08-02 18:20:04 INFO Database connection established
2026-08-02 18:20:09 WARNING Disk usage above 75%
EOF

tail -f logs/app.log

"
Step 2 — Simulate the Application

Open a second terminal (or a second SSH session if you were on a real server).

Append a new log entry:

echo "2026-08-02 18:22:30 INFO User login successful" >> logs/app.log"

What should happen?

The first terminal running tail -f should immediately display:

2026-08-02 18:22:30 INFO User login successful

"
output:
2026-08-02 18:20:01 INFO Application started
2026-08-02 18:20:04 INFO Database connection established
2026-08-02 18:20:09 WARNING Disk usage above 75%
2026-08-02 18:22:30 INFO User login successful
"

"
Add a few more entries

Run these one at a time:
echo "2026-08-02 18:22:45 WARNING Memory usage above 80%" >> logs/app.log
echo "2026-08-02 18:23:01 ERROR Database connection timeout" >> logs/app.log
echo "2026-08-02 18:23:10 INFO Retry succeeded" >> logs/app.log
"

"
output:
2026-08-02 18:20:01 INFO Application started
2026-08-02 18:20:04 INFO Database connection established
2026-08-02 18:20:09 WARNING Disk usage above 75%
2026-08-02 18:22:30 INFO User login successful
2026-08-02 18:22:45 WARNING Memory usage above 80%
2026-08-02 18:23:01 ERROR Database connection timeout
2026-08-02 18:23:10 INFO Retry succeeded
"

# ==============================
# Exercise 2 — Search for Application Errors
# ==============================

"
Objective

Find all error messages in an application log.

1. Show only the ERROR messages.
2. Show only the WARNING messages.
3. Show both ERROR and WARNING messages with a single command.
4. Count how many ERROR messages exist.

TIP: When troubleshooting production systems, one of the most common commands you'll run is:
grep -Ei "error|warning|fatal" application.log
"

cat logs/app.log

# 1. Show only the ERROR messages.

grep "ERROR" logs/app.log

# 2. Show only the WARNING messages.

grep "WARNING" logs/app.log

# 3. Show both ERROR and WARNING messages with a single command.

grep -E "ERROR|WARNING" logs/app.log

# 4. Count how many ERROR messages exist.

grep -c "ERROR" logs/app.log

"
Alternative: grep "ERROR" logs/app.log | wc -l
"
# Bonus: Suppose the application logs mixed case messages

grep -i "ERROR" logs/app.log

"
Notes:
- `grep ".*ERROR.*" logs/app.log` since grep matches anywhere on the line by default, 
the .* is unnecessary, so use: grep "ERROR" logs/app.log

- Rule of thumb: Use regex only when you actually need regex.
"

# ==============================
# Exercise 3 — Count Failed Requests
# ==============================
"
Objective

Count failed HTTP requests in an access log.

Create a new practice log:
cat > logs/access.log <<'EOF'
2026-08-02 20:30:01 GET /health 200
2026-08-02 20:30:03 GET /api/users 200
2026-08-02 20:30:05 POST /api/upload 500
2026-08-02 20:30:07 GET /api/report 404
2026-08-02 20:30:10 POST /api/upload 201
2026-08-02 20:30:12 GET /api/users 503
2026-08-02 20:30:15 GET /health 200
EOF

Assume any HTTP status code beginning with 4 or 5 is a failed request.

Tasks
1. Display every failed request.
2. Count all failed requests.
3. Count only server errors: status codes beginning with 5.
4. Bonus: show only the status codes for failed requests.
"

# 1. Display every failed request.
grep -E "4..$|5..$" logs/access.log

"
2026-08-02 20:30:05 POST /api/upload 500
2026-08-02 20:30:07 GET /api/report 404
2026-08-02 20:30:12 GET /api/users 503
"

# 2. Count all failed requests.
grep -Ec "4..$|5..$" logs/access.log
"
3
"
# 3. Count only server errors: status codes beginning with 5.
grep -Ec "5..$" logs/access.log
"
2
"

# 4. Bonus: show only the status codes for failed requests.
grep -Eo "4..$|5..$" logs/access.log
"
500
404
503
"

# ==============================
# Exercise 4 — Extract Timestamps
# ==============================
"
Objective

Extract only the date and time from each log entry.

Use the existing file:
logs/access.log

Example line:
2026-08-02 20:30:05 POST /api/upload 500

Tasks
1. Print only the date from each line.
2. Print only the time from each line.
3. Print the full timestamp: date and time.
4. Bonus: print the timestamp only for failed requests (4xx and 5xx).

The timestamp is made of the first two fields:
2026-08-02 20:30:05
"

# Print only the date from each line.
"
NOTE: In basic regular expressions , {} are treated as literal characters unless 
you escape them.

NOTE2: DO NOT add spaces, even for pipes unless explicit
"
grep -o "....-..-.." logs/access.log # too permissive
grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" logs/access.log

"
2026-08-02
2026-08-02
2026-08-02
2026-08-02
2026-08-02
2026-08-02
2026-08-02
"

# Print only the time from each line.
grep -o "..:..:.." logs/access.log # too permissive
grep -o "[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}" logs/access.log

"
20:30:01
20:30:03
20:30:05
20:30:07
20:30:10
20:30:12
20:30:15
"

# Print the full timestamp: date and time.
grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}" logs/access.log

"
2026-08-02 20:30:01
2026-08-02 20:30:03
2026-08-02 20:30:05
2026-08-02 20:30:07
2026-08-02 20:30:10
2026-08-02 20:30:12
2026-08-02 20:30:15
"
# Bonus: print the timestamp only for failed requests (4xx and 5xx).

grep -E "4..$ | 5..$" logs/access.log \
|grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}"

"
2026-08-02 20:30:05
2026-08-02 20:30:12
"