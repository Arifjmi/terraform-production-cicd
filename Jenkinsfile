pipeline {

    agent any

    environment {
        TF_DIR = 'environments/prod'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Archive Terraform Plan') {
            steps {
                archiveArtifacts artifacts: "${TF_DIR}/tfplan",
                                 fingerprint: true
            }
        }

        stage('Production Approval') {
            steps {
                input(
                    message: 'Approve deployment to PRODUCTION?',
                    ok: 'Deploy to Production'
                )
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {

        success {
            echo 'Production Terraform deployment completed successfully.'
        }

        failure {
            echo 'Production Terraform deployment failed.'
        }
    }
}

