#!/bin/bash

DATE=$(date +"%Y-%m-%d")

REPORT="iam-report-$DATE.txt"

echo "AWS IAM REPORT" > $REPORT
echo "Generated on $(date)" >> $REPORT
echo "" >> $REPORT

echo "===== IAM USERS =====" >> $REPORT

aws iam list-users \
--query 'Users[*].UserName' \
--output text >> $REPORT

echo "" >> $REPORT

echo "===== ACCESS KEYS =====" >> $REPORT

for user in $(aws iam list-users \
--query 'Users[*].UserName' \
--output text)
do
    echo "User: $user" >> $REPORT

    aws iam list-access-keys \
    --user-name $user \
    --query 'AccessKeyMetadata[*].[AccessKeyId,Status]' \
    --output table >> $REPORT

    echo "" >> $REPORT
done

echo "Report generated successfully."
