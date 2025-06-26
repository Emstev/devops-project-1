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
                deleteDir()
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
                echo "[+] Connecting to EC2 and deploying Flask app..."

                ssh -o StrictHostKeyChecking=no -i ~/.ssh/your-key.pem ubuntu@your-ec2-public-ip << 'EOF'
                    echo "[+] Updating system..."
                    sudo apt update -y
                    sudo apt install -y python3-pip

                    echo "[+] Cloning App Repo..."
                    git clone https://github.com/Emstev/python-mysql-db-proj-1.git /home/ubuntu/app
                    cd /home/ubuntu/app

                    echo "[+] Installing Python requirements..."
                    pip3 install -r requirements.txt --break-system-packages

                    echo "[+] Copying systemd service..."
                    sudo cp deployment/flaskapp.service /etc/systemd/system/flaskapp.service

                    echo "[+] Enabling and starting Flask app..."
                    sudo systemctl daemon-reload
                    sudo systemctl enable flaskapp
                    sudo systemctl restart flaskapp
                EOF

                echo "[✓] Flask app deployment completed!"
                '''
            }
        }
    }
}
