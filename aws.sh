#!/usr/bin/env bash
echo This script has by default values of profile=rafid and region=ap-southeast-1. If you wish to override it abort the script and run the command "profile=<<profile_Name>> region=<<region_name>> bash aws.sh"
exec 3< config.txt
delimiter="="
read -r prfl <&3
prfl=${prfl#*$delimiter}
read -r rgn <&3
rgn=${rgn#*$delimiter}
exec 3<&-

profile=${profile:=$prfl}
region=${region:=$rgn}
echo "Please enter instance type:" 
read instanceType
echo $profile $region $instanceType
# aws $instanceType describe-instances --query 'Reservations[*].Instances[*].Tags[?Key==`Name`].Value[]' --output text --profile $profile --region $region
# echo "Please enter required instance:" 
# read instance
# instace_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance}" --query "Reservations[].Instances[].InstanceId" --output text --profile $profile --region $region)
# group_id=$((aws $instanceType describe-instances --instance-ids $instace_id --query "Reservations[0].Instances[0].NetworkInterfaces[0].Groups[0].GroupId"  --profile $profile --region $region) | sed 's/"//g')
# echo $group_id
# aws ec2 describe-security-groups --group-ids $group_id --profile $profile --region $region

