function assume-arn
    # Usage: assume-arn <role-arn> [session-name]

    if test (count $argv) -lt 1
    echo "Usage: assume-arn <role-arn> [session-name]"
    return 1
end

set role_arn $argv[1]
if test (count $argv) -ge 2
    set session_name $argv[2]
else
    set session_name "van-de-ven"
end

set creds (aws sts assume-role \
    --role-arn $role_arn \
    --role-session-name $session_name \
    --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
    --output text | string split \t)

set -x AWS_ACCESS_KEY_ID $creds[1]
set -x AWS_SECRET_ACCESS_KEY $creds[2]
set -x AWS_SESSION_TOKEN $creds[3]

aws sts get-caller-identity
end
