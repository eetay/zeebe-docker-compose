#!/bin/bash
eval `aws ecr get-login --region us-east-2 --no-include-email  --registry-ids 712823164894 | sed 's|https://||'`