#!/bin/zsh

setopt aliases

alias aws-cf='aws cloudformation --profile awsbootstrap'
STACK_NAME=example-codepipeline-01
CODE_DEPLOY_SERVICE_ROLE_ARN=arn:aws:iam::521614954326:role/example-ec2-codedeploy-01-CodeDeployRole-1DW431FMGMNS2

if [ $1 = 'create' ] || [ $1 = 'update' ]; then
aws-cf ${1}-stack \
    --stack-name $STACK_NAME \
    --template-body file://create-codepipeline.yaml \
    --parameters ParameterKey=GitHubRepo,ParameterValue=aws-bootstrap \
                 ParameterKey=GitHubBranch,ParameterValue=main \
                 ParameterKey=GitHubUser,ParameterValue=0pointr \
                 ParameterKey=CodeDeployServiceRoleArn,ParameterValue="$CODE_DEPLOY_SERVICE_ROLE_ARN" \
                 ParameterKey=TagKey,ParameterValue=Ec2Type \
                 ParameterKey=TagValue,ParameterValue=Ec2CodeDeploy \
                 --capabilities CAPABILITY_IAM
elif [ $1 = 'delete' ]; then
    aws-cf delete-stack --stack-name $STACK_NAME
elif [ $1 = 'info' ]; then
    aws-cf describe-stacks --stack-name $STACK_NAME
fi

