pipeline {
    agent any

    environment {
        // Uses your GCP Service Account credential stored in Jenkins
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa-json')
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Security Gate: Checkov Plan Scan') {
            steps {
                sh 'terraform plan -out=tfplan.binary'
                sh 'terraform show -json tfplan.binary > tfplan.json'
                sh 'checkov -f tfplan.json --compact'
            }
        }

        stage('Manual Approval & Deploy') {
            steps {
                input message: 'Security scan passed! Do you want to deploy to GCP?', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan.binary'
            }
        }
    }

    post {
        always {
            cleanWs deleteDirs: true, notFailBuild: true
        }
    }
}
