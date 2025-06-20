// pipeline {
//   agent any
//   stages {
//     stage('Build') {
//       steps {
//         echo '▶ Démarrage de la compilation'
//       }
//     }
//     stage('Test') {
//       steps {
//         echo '▶ Exécution des tests (simulation)'
//       }
//     }
//     stage('Deploy') {
//       steps {
//         echo '▶ Simulation de déploiement'
//       }
//     }
//   }
// }


pipeline {
  agent {
    docker { image 'python:3.11' }
  }
  stages {
    stage('Afficher version Python') {
      steps {
        sh 'python --version'
      }
    }
    stage('Exécuter un script Python') {
      steps {
        sh 'echo "print(\'Hello depuis Docker !\')" > hello.py'
        sh 'python hello.py'
      }
    }
  }
}
