#!/bin/zsh

setopt aliases

alias aws-cf='aws cloudformation --profile awsbootstrap'
STACK_NAME=example-ec2-codedeploy-01

if [ $1 = 'create' ] || [ $1 = 'update' ]; then
aws-cf ${1}-stack \
    --stack-name $STACK_NAME \
    --template-body file://create-ec2+rds+codedeploy-role.yaml \
    --parameters ParameterKey=AvailabilityZone,ParameterValue=us-east-1a \
                 ParameterKey=Environment,ParameterValue=dev \
                 ParameterKey=KeyPairName,ParameterValue=debd-1 \
                 ParameterKey=DBPassword,ParameterValue=postgres \
                 ParameterKey=TagKey,ParameterValue=Ec2Type \
                 ParameterKey=TagValue,ParameterValue=Ec2CodeDeploy \
                 --capabilities CAPABILITY_IAM
elif [ $1 = 'delete' ]; then
    aws-cf delete-stack --stack-name $STACK_NAME
elif [ $1 = 'info' ]; then
    aws-cf describe-stacks --stack-name $STACK_NAME
fi

