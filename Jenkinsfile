pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    checkout scmGit(
                        branches: [[name: '*/main']],
                        extensions: [],
                        userRemoteConfigs: [[url: 'https://github.com/SpatikaP/terraform-eks-cicd']]
                    )
                }
            }
        }

        stage('Initializing Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Formatting Terraform Code') {
            steps {
                sh 'terraform fmt'
            }
        }

        stage('Validating Terraform') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Previewing the Infra using Terraform') {
            steps {
                sh 'terraform plan'
                input(message: "Are you sure to proceed?", ok: "Proceed")
            }
        }

        stage('Creating/Destroying an EKS Cluster') {
            steps {
                sh 'terraform $action --auto-approve'
            }
        }

        stage('Deploying Nginx Application') {
            steps {
                script {
                    sh 'aws eks update-kubeconfig --name my-eks-cluster'
                    sh 'kubectl apply -f ConfigurationFiles/deployment.yaml'
                    sh 'kubectl apply -f ConfigurationFiles/service.yaml'
                }
            }
        }
    }
}
