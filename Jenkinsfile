pipeline {
    agent { label 'terraform-vm' }

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa-json')
        TF_VAR_gcp_project_id = 'devops-security-lab-2026'
        PATH = "/home/rkrehmankhan/.local/bin:${env.PATH}"
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
                sh 'terraform plan -no-color -out=tfplan.binary'
                sh 'terraform show -json tfplan.binary > tfplan.json'
                sh 'checkov --version'
                sh 'checkov -f tfplan.json --framework terraform_plan --compact'
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
