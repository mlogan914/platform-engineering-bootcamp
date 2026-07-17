# ==============================
# Bonus Exercise – grep
# ==============================
"
Assignment

A sequencing server has become cluttered.

Organize the filesystem into a clean project structure while preserving all data.
Bonus Exercise – grep

Scenario

You have an application log called app.log:

2026-07-14 08:15:22 INFO Application started
2026-07-14 08:15:25 INFO User logged in
2026-07-14 08:16:01 WARNING Low disk space
2026-07-14 08:16:45 ERROR Failed to connect to database
2026-07-14 08:17:02 INFO Retrying connection
2026-07-14 08:17:05 ERROR Connection timeout
2026-07-14 08:18:10 INFO Upload complete

Tasks

- Display every line containing ERROR.
- Display every line containing either ERROR or WARNING.
- Count how many INFO messages exist.
- Show line numbers for every ERROR.
- Search for error regardless of capitalization.
- Display every line that does not contain INFO.
- Save all ERROR messages to a new file named errors.log.

"

touch app.log

vim app.log

cat app.log

tldr grep


# Display every line containing ERROR.
grep ".*ERROR.*" app.log

"
2026-07-14 08:16:45 ERROR Failed to connect to database
2026-07-14 08:17:05 ERROR Connection timeout
"

# Display every line containing either ERROR or WARNING.
grep -E ".*ERROR.*|.*WARNING.*" app.log

"
2026-07-14 08:16:01 WARNING Low disk space
2026-07-14 08:16:45 ERROR Failed to connect to database
2026-07-14 08:17:05 ERROR Connection timeout
"

# Count how many INFO messages exist.
grep -c "INFO" app.log

"
4
"

# Show line numbers for every ERROR.
grep -n "ERROR" app.log

"
4:2026-07-14 08:16:45 ERROR Failed to connect to database
6:2026-07-14 08:17:05 ERROR Connection timeout
"

# Search for error regardless of capitalization.
grep -i "ERROR" app.log

"
2026-07-14 08:16:45 ERROR Failed to connect to database
2026-07-14 08:17:05 ERROR Connection timeout
error
"

# Display every line that does not contain INFO.
grep -v "INFO" app.log

"
2026-07-14 08:16:01 WARNING Low disk space
2026-07-14 08:16:45 ERROR Failed to connect to database
2026-07-14 08:17:05 ERROR Connection timeout
error
"

# Save all ERROR messages to a new file named errors.log.
grep ".*ERROR.*" app.log > errors.log
