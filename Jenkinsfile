pipeline {
  agent {
    kubernetes {
      yaml '''
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug-539ddefcae3fd6b411a95982a830d987f4214251
    imagePullPolicy: Always
    command:
    - cat
    tty: true
    env:
    - name: GOOGLE_APPLICATION_CREDENTIALS
      value: "/kaniko/secret/config.json"
    volumeMounts:
    - name: gcr-credentials
      mountPath: /kaniko/secret
      readOnly: true
  volumes:
  - name: gcr-credentials
    secret:
        secretName: gcr-credentials
'''
    }

  }
  stages {
    stage('Build with Kaniko') {
      steps {
        container(name: 'kaniko') {
          sh '''
            /kaniko/executor  --skip-tls-verify --dockerfile=`pwd`/beginner-project/njs2/Dockerfile --context=`pwd` --destination=gcr.io/swagoverflow/njs2:latest
            '''
        }

      }
    }

  }
}
