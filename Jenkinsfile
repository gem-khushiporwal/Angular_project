node {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
  
       bat 'docker build -t khushiporwal/sample-app .'
    }

    // stage('Test image') {
  

    //     app.inside {
    //         sh 'echo "Tests passed"'
    //     }
    // }

    stage('Push image') {
        
        withDockerRegistry(credentialsId: 'dockerhub', url: 'https://hub.docker.com') {
            bat 'docker push khushiporwal/sample-app:1.0-$BUILD_NUMBER'
        }
    }
    
    // stage('Trigger ManifestUpdate') {
    //             echo "triggering UpdateManifest job"
    //             build job: 'UpdateManifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
    //     }
}
