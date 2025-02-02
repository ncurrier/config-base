#!/usr/bin/env bash
# ~/.aws/scripts/aws_session_timer.sh
# Calculates the remaining time for your AWS session.
# Expects AWS_SESSION_EXPIRATION to be set (either as epoch seconds or as an ISO8601 string).

if [ -z "$AWS_SESSION_EXPIRATION" ]; then
    echo ""
    exit 0
fi

# Determine if AWS_SESSION_EXPIRATION is numeric (epoch seconds) or an ISO8601 string.
if [[ "$AWS_SESSION_EXPIRATION" =~ ^[0-9]+$ ]]; then
    expiration_epoch=$AWS_SESSION_EXPIRATION
else
    # Try GNU date parsing.
    expiration_epoch=$(date -d "$AWS_SESSION_EXPIRATION" +%s 2>/dev/null)
    # Fallback for macOS (BSD date).
    if [ -z "$expiration_epoch" ]; then
        expiration_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "$AWS_SESSION_EXPIRATION" +"%s" 2>/dev/null)
    fi
fi

current_epoch=$(date +%s)
remaining=$(( expiration_epoch - current_epoch ))

if [ "$remaining" -le 0 ]; then
    echo "Expired"
else
    # Format remaining seconds as HH:MM:SS.
    hours=$(( remaining / 3600 ))
    minutes=$(( (remaining % 3600) / 60 ))
    seconds=$(( remaining % 60 ))
    printf "%02d:%02d:%02d" $hours $minutes $seconds
fi