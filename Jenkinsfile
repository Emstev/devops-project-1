pipeline {
    agent any

    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to destroy Terraform resources')
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/Emstev/devops-project-1.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-emmastev']]) {
                    dir('infra') {
                        sh 'echo "================= Terraform Init =================="'
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-emmastev']]) {
                            dir('infra') {
                                sh 'echo "================= Terraform Plan =================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-emmastev']]) {
                            dir('infra') {
                                sh 'echo "================= Terraform Apply =================="'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-emmastev']]) {
                            dir('infra') {
                                sh 'echo "================= Terraform Destroy =================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }

      stage('Deploy Flask App on EC2') {
    steps {
        sh '''
            echo "[+] Installing Python and required packages..."
            sudo apt update
            sudo apt install -y python3-pip

            echo "[+] Installing Flask and pymysql with override..."
            pip3 install flask pymysql --break-system-packages

            echo "[+] Preparing app directory..."
            sudo mkdir -p /home/ubuntu/app/templates
            sudo cp -r * /home/ubuntu/app

            echo "[+] Registering systemd service..."
            sudo cp deployment/flaskapp.service /etc/systemd/system/flaskapp.service
            sudo systemctl daemon-reload
            sudo systemctl enable flaskapp
            sudo systemctl restart flaskapp

            echo "[✓] Flask app is now running via systemd"
        '''
    }
}

