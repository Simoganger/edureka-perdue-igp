pipeline {
    agent any
    environment {
        PROJECT_ID = 'abc-technologies-88625635'
        ANSIBLE_SERVER = 'ansible-server'
        REMOTE_DIRECTORY = '//opt//docker'
    }
    tools {
        maven 'maven-3.2'
        jdk 'java-21'
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                git 'https://github.com/Simoganger/edureka-perdue-igp'
            }
        }

        stage('Compile project') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test project') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build project') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Copy to Ansible'){
            sshPublisher(
                continueOnError: false,
                failOnError: true,
                publishers: [
                    sshPublisherDesc(
                        configName: '${env.ANSIBLE_SERVER}',
                        verbose: true, 
                        transfers: [
                            sshTransfer(
                                remoteDirectory: '${env.REMOTE_DIRECTORY}', 
                                sourceFiles: '**/*.war,**/*.yml,Dockerfile',
                                execCommand: 'ansible-playbook /opt/docker/abc-tech-playbook.yml', 
                            )
                        ]
                    )
                ]
            )
        }
    }
}