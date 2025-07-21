#!/bin/bash

#####################################################
#Author: Subhashini.B                               
#Date:20-07-2025
#To check the resources used in the AWS cloud infra
#####################################################

set -x
set -e
#to check the list of EC2 instances
echo "List the EC2 instances details"
#aws ec2 describe-instances|jq -r "[.Resources:[].Instances:[]|{State: .State.name, InstanceType: .InstanceType, InstanceID: .InstanceId]"
aws ec2 describe-instances | jq -r "[.Reservations[].Instances[]|{ state: .State.Name, type: .InstanceType, instanceid: .InstanceId, Placement: .Placement }]" >resource_tracker.txt

#to check the list of S3 buckets
echo "List the S3 buckets"
aws s3 ls >>resource_tracker.txt


#to check the list of DynamoDB tables
echo "list the table in DynamoDB"
aws dynamodb list-tables >>resource_tracker.txt
