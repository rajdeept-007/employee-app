pipeline {
    agent any
    stages{
        stage("Checkout") {
            steps {
                git branch: main,
                url: 'https://github.com/rajdeept-007/employee-app.git'
            }
        }
        stage("Build Jar") {
            steps {
                sh '/opt/homebrew/bin/mvn clean package'
            }
        }
        stage("Build Docker Image") {
            steps {
                sh 'docker build -t employeeapp'
            }
        }
        stage("Docker Login") {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh 'doker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                }
            }
        }
        stage('Push Image') {
            steps{
                sh 'docker tag employeeapp rajdeeptalukdar/employeeapp:v2'
                sh 'docker push rajdeeptalukdar/employeeapp:v2'
            }
        }
        stage('Run Container') {
            steps{
                sh 'docker rm -f employeecontainer || exit 0'
                sh 'docker run --name employeecontainer employeeapp'
            }
        }
        
    }
}