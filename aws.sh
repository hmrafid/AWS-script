#!/usr/bin/env bash
echo "Please enter profile name:" 
read profileName
echo "Please enter the region:" 
read region
echo "Please enter instance type:" 
read instanceType
# echo $profileName $region $instance
aws $instanceType describe-instances --query 'Reservations[*].Instances[*].Tags[?Key==`Name`].Value[]' --output text --profile $profileName --region $region
echo "Please enter required instance:" 
read instance
instace_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance}" --query "Reservations[].Instances[].InstanceId" --output text --profile $profileName --region $region)
group_id=$((aws $instanceType describe-instances --instance-ids $instace_id --query "Reservations[0].Instances[0].NetworkInterfaces[0].Groups[0].GroupId"  --profile $profileName --region $region) | sed 's/"//g')
echo $group_id
aws ec2 describe-security-groups --group-ids $group_id --profile $profileName --region $region

