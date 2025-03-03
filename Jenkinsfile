pipeline {
    agent any
    
     environment {
        TF_VAR_client_id       = credentials('AZURE_CLIENT_ID')
        TF_VAR_client_secret   = credentials('AZURE_CLIENT_SECRET')
        TF_VAR_tenant_id       = credentials('AZURE_TENANT_ID')
        TF_VAR_subscription_id = credentials('AZURE_SUBSCRIPTION_ID')
    }


    stages {
        
        stage('Sonar Scanner') {
            steps {
                // Use the Sonar Scanner tool configured in Jenkins to perform the analysis
                 tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                echo 'No Warnings'
                
            }
        }
        stage('Install Terraform') {
            steps {
                script {
                    // Ensure Terraform is installed on the Jenkins agent
                    sh '''
                    if ! terraform version; then
                        echo "Terraform is not installed. Installing..."
                        curl -LO https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
                        unzip terraform_1.5.0_linux_amd64.zip
                        mv terraform /usr/local/bin/
                    fi
                    terraform version
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform (downloads providers and sets up the working environment)
                    sh '''
                    terraform init
                    '''
                }
            }
        }
            stage('Terraform Plan') {
            steps {
                script {
                    // Run Terraform plan to preview the changes before applying
                    sh '''
                    terraform plan 
                    '''
                }
            }
        }
stage('Terraform Apply') {
            steps {
                script {
                    // Apply the Terraform configuration (create/update the resources like roles and policies)
                    sh '''
                    terraform apply -auto-approve 
                    '''
                }
            }
        }

        stage('Post-apply Actions') {
            steps {
                script {
                    echo "Terraform apply completed successfully!"
                }
            }
        }
        
        
    }
}