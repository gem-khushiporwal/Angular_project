node {
    def app

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
        bat 'docker image build -f Dockerfile -t khushiporwal/sample-app:1.0-$BUILD_NUMBER -t khushiporwal/sample-app .'
       // bat 'docker build -t khushiporwal/sample-app:${BUILD_NUMBER} .'
    }

    // stage('Test image') {
  

    //     app.inside {
    //         sh 'echo "Tests passed"'
    //     }
    // }

    stage('Push image') {
        
        withDockerRegistry(credentialsId: 'dockerhub', url: 'https://registry.hub.docker.com') {
            bat 'docker push khushiporwal/sample-app:1.0-$BUILD_NUMBER'
        }
    }
    
    // stage('Trigger ManifestUpdate') {
    //             echo "triggering UpdateManifest job"
    //             build job: 'UpdateManifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
    //     }
}
