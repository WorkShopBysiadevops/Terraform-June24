pipeline {
    agent any
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('git') {
            steps{
                git url: 'https://github.com/WorkShopBysiadevops/Terraform-June24.git',
                branch: 'develop'
            }
            
        }
        stage('build docker image') {
            steps {
                sh 'sudo docker image build -t siadevops/nopcoommerce:latest .'
                sh 'sudo docker image push siadevops/nopcoommerce:latest'
            }
            
        }
        stage('infra provisioning') {
            steps {
                sh 'cd infra/Terraform && terraform init && terraform workspace select dev && pwd && terraform apply -lock=false -var-file="dev.tfvars" -var "build_number=${BUILD_ID}" -auto-approve'
            }
            
        }
        stage('deploy') {
            steps{
                sh 'kubectl apply -f infra/k8s'
            }
            
        }
    }
}
