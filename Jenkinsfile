pipeline {
    agent any

    tools {
        terraform 'terraform'
    }

    parameters{        
        choice(
            choices: ['plan', 'apply', 'destroy'], 
            name: 'Terraform_Action'
        )
    }

    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing'
            }
        }
        stage('Git Pulling') {
            steps {
                git branch: 'main', url: 'https://github.com/Groupvslxl-3/DoAnDevOpsTerraform.git'
            }
        }
        stage('Init') {
            steps {
                withAWS(credentials: 'AWS_SECRET_KEY', region: 'us-east-1') {
                sh 'terraform init'
                }
            }
        }
        stage('Validate') {
            steps {
                withAWS(credentials: 'AWS_SECRET_KEY', region: 'us-east-1') {
                sh 'terraform validate'
                }
            }
        }
        stage('Action') {
            steps {
                withAWS(credentials: 'AWS_SECRET_KEY', region: 'us-east-1') {
                    script {    
                        if (params.Terraform_Action == 'plan') {
                            sh "terraform plan"
                        }   else if (params.Terraform_Action == 'apply') {
                            sh "terraform apply -auto-approve"
                            echo "Triggering PipelineDockerKubernets..."
                            // Trigger another pipeline
                            build job: 'PipelineDockerKubernets', wait: true
                        }   else if (params.Terraform_Action == 'destroy') {
                            sh "terraform destroy -auto-approve"
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                }
            }
        }
    }
}