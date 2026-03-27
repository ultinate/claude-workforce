#!/bin/bash
curl -L "https://www.kaggle.com/api/v1/datasets/download/wjburns/common-password-list-rockyoutxt" -o tools/rockyou.zip
unzip -o tools/rockyou.zip -d tools/
rm tools/rockyou.zip
