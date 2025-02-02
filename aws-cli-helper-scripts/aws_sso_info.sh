#!/usr/bin/env bash
# ~/.aws/scripts/aws_sso_bar.sh
# Combines AWS SSO session info and session timer for display in Starship.
# Requires: aws CLI and jq.

# Get caller identity from AWS CLI.
identity=$(aws sts get-caller-identity --output json 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$identity" ]; then
    exit 0
fi

# Extract ARN and Account.
arn=$(echo "$identity" | jq -r '.Arn')
account=$(echo "$identity" | jq -r '.Account')

sso_info=""
if echo "$arn" | grep -qi "sso"; then
    # Example ARN format for SSO:
    # arn:aws:sts::123456789012:assumed-role/AWSReservedSSO_ReadOnly_abcdef1234567890/username
    role=$(echo "$arn" | awk -F 'assumed-role/' '{print $2}' | cut -d'/' -f1)
    sso_info="$account/$role"
fi

# Get the session timer info.
timer=$("$HOME/.aws/scripts/aws_session_timer.sh")

# If both sso_info and timer are empty, output nothing.
if [ -z "$sso_info" ] && [ -z "$timer" ]; then
    exit 0
fi

# Build the output string.
if [ -n "$sso_info" ] && [ -n "$timer" ]; then
    echo "SSO: $sso_info | Expires in: $timer"
elif [ -n "$sso_info" ]; then
    echo "SSO: $sso_info"
else
    echo "Expires in: $timer"
fi