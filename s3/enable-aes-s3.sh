#!/bin/bash

selected_buckets=$(aws s3api list-buckets | jq -r '.Buckets | .[].Name' | fzf -m --bind 'ctrl-a:select-all,ctrl-d:deselect-all')
for bucket in ${selected_buckets[@]}; do
    aws s3api put-bucket-encryption --bucket $bucket --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}' --no-cli-pager
    echo "Processed $bucket"
done
