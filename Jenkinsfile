node {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
        // bat 'docker image build -f Dockerfile -t khushiporwal/sample-app:1.0-$BUILD_NUMBER -t khushiporwal/sample-app .'
       bat 'docker build -t khushiporwal/sample-app:%BUILD_NUMBER% .'
       bat 'docker pull aquasec/trivy:0.19.2'
        bat 'docker run --rm -v ./:/root/.cache/ aquasec/trivy:latest image khushiporwal/sample-app:%BUILD_NUMBER%'
    }

    // stage('Test image') {
  

    //     app.inside {
    //         sh 'echo "Tests passed"'
    //     }
    // }

    stage('Push image') {
        
        withDockerRegistry([credentialsId: "dockerhub", url: ""]) {
            bat 'docker push khushiporwal/sample-app:%BUILD_NUMBER%'
        }
    }
    
    stage('Git Changes'){
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/gem-khushiporwal/test_deployment.git']]])
        withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
          bat 'git config user.name gem-khushiporwal'
          bat 'dir' 
          bat """
                powershell.exe -Command \"((Get-Content -path application.yaml -Raw) -replace 'image: khushiporwal/sample-app:\\d+', 'image: khushiporwal/sample-app:%BUILD_NUMBER%') | Set-Content -path application.yaml\"
                """
          bat '''  powershell.exe -Command "Get-Content -path application.yaml " '''
        bat 'git add .'
        bat "git commit -m \"Changed the tag of the image\""
        bat "git push https://github.com/gem-khushiporwal/test_deployment.git HEAD:main "    
}
    }
}
