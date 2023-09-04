node {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
        // bat 'docker image build -f Dockerfile -t khushiporwal/sample-app:1.0-$BUILD_NUMBER -t khushiporwal/sample-app .'
       bat 'docker build -t khushiporwal/sample-app:%BUILD_NUMBER% .'
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
    
    // stage('Trigger ManifestUpdate') {
    //             echo "triggering UpdateManifest job"
    //             build job: 'UpdateManifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
    //     }
    stage('Git Changes'){
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/gem-khushiporwal/test_deployment.git']]])
        withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]) {
          bat 'dir'
          bat '''@echo off
                setlocal enabledelayedexpansion
                set "BUILD_NUMBER=%BUILD_NUMBER%"
                echo %BUILD_NUMBER%
                set "TMP_FILE=tempfile.txt"
                
                (for /f "tokens=*" %%A in (application.yaml) do (
                    set "line=%%A"
                    set "line=!line:khushiporwal/sample-app.*=khushiporwal/sample-app:%BUILD_NUMBER%!"
                    echo !line!
                )) > %TMP_FILE%
                
                move /y %TMP_FILE% application.yaml
                 type application.yaml'''
            // bat 'type application.yaml'
}
    }
}
