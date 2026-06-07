pipeline {
    agent any
    stages{
        stage("Checkout") {
            steps {
                git branch: 'main',
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
                sh '/usr/local/bin/docker build -t employeeapp .'
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
                    sh 'echo $DOCKER_PASS | /usr/local/bin/docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }
        stage('Push Image') {
            steps{
                sh '/usr/local/bin/docker tag employeeapp rajdeeptalukdar/employeeapp:v2'
                sh '/usr/local/bin/docker push rajdeeptalukdar/employeeapp:v2'
            }
        }
        stage('Run Container') {
            steps{
                sh '/usr/local/bin/docker rm -f employeecontainer || exit 0'
                sh '/usr/local/bin/docker run --name employeecontainer employeeapp'
            }
        }
        
    }
}