#!/bin/bash

selected_buckets=$(aws s3api list-buckets | jq -r '.Buckets | .[].Name' | fzf -m --bind 'ctrl-a:select-all,ctrl-d:deselect-all')
for bucket in ${selected_buckets[@]}; do
    aws s3 cp s3://$bucket/ s3://$bucket/ --recursive --no-cli-pager
    echo "Processed $bucket"
done
