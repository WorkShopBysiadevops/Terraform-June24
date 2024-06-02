pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('git') {
            git url: 'https://github.com/WorkshopsByKhaja/Terraform-June24.git',
                branch: 'develop'
        }
        stage('build docker image') {
            sh 'docker image build -t shaikkhajaibrahim/nop-demo-terraform:latest .'
            sh 'docker image push shaikkhajaibrahim/nop-demo-terraform:latest'
        }
        stage('infra provisioning') {
            sh 'cd infra/Terraform && terraform init && terraform workspace select dev && terraform apply -var-file="dev.tfvars" -auto-approve'
        }
        stage('deploy') {
            sh 'kubectl apply -f infra/k8s'
        }
    }
}