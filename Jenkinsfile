pipeline {
    agent any

    environment {
        // Uses your GCP Service Account credential stored in Jenkins
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa-json')
        // Put your GCP project ID here so Terraform picks it up automatically
        TF_VAR_gcp_project_id = 'YOUR_NEW_PROJECT_ID'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Security Gate: Checkov Plan Scan') {
            steps {
                bat 'terraform plan -out=tfplan.binary'
                bat 'terraform show -json tfplan.binary > tfplan.json'
                bat 'checkov -f tfplan.json --compact'
            }
        }

        stage('Manual Approval & Deploy') {
            steps {
                input message: 'Security scan passed! Do you want to deploy to GCP?', ok: 'Deploy'
                bat 'terraform apply -auto-approve tfplan.binary'
            }
        }
    }

    post {
        always {
            cleanWs deleteDirs: true, notFailBuild: true
        }
    }
}
