pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                git branch: 'master', url: 'https://github.com/DawidKosior/url-tetris'
                sh 'npm install'
                sh 'git pull origin master'
                sh 'yarn build > log1.txt'
            }
            
            post {
                failure {
                    script {
                        env.FAILED = true
                    }  

                    emailext attachLog: true,
                        attachmentsPattern: 'log1.txt',
                        to:'d4wt0n@gmail.com',
                        subject: "Build failed: ${currentBuild.fullDisplayName}",
                        body: "error ${env.BUILD_URL}"     
                      
                }
                success {
                    mail to: 'd4wt0n@gmail.com',
                        subject: "Build success! ${currentBuild.fullDisplayName}",
                        body: "Build success!"
                }
            }
        }
        stage('Test') {
             steps {
                 script {
                    if ( env.FAILED ) {
                    expression {
                        currentBuild.result = 'ABORTED'
                        error('Failed on build stage!')
                        }
                    }
                }
                sh 'yarn test > log.txt'
            }
            post {
                failure {
                    emailext attachLog: true,
                        attachmentsPattern: 'log2.txt',
                        to:'d4wt0n@gmail.com',
                        subject: "Failed on test stage: ${currentBuild.fullDisplayName}",
                        body: "Error ${env.BUILD_URL}"        
                }
                success {
                    mail to: 'd4wt0n@gmail.com',
                        subject: "Success on testing ${currentBuild.fullDisplayName}",
                        body: "Success on testing ${env.BUILD_URL} "    
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker build -t dockertetris -f Dockerfile .'
                sh 'docker run dockertetris'
                }
                post {
                    failure {
                         emailext attachLog: true,
                            attachmentsPattern: 'log3.txt',
                            to:'d4wt0n@gmail.com',
                            subject: "Failed: ${currentBuild.fullDisplayName}",
                            body: "error ${env.BUILD_URL}"        
                    }
                    success {
                        mail to: 'd4wt0n@gmail.com',
                            subject: "Success: ${currentBuild.fullDisplayName}",
                            body: "Success deploy ${env.BUILD_URL} "                        
                    }
                }
        }
    }
}
