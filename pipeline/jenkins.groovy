pipeline {
    agent any

    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'Вибір гілки для збірки')
        choice(name: 'ENV', choices: ['dev','staging','prod'], description: 'Вибір середовища розгортання')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Запускати тести?')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checkout з гілки: ${params.BRANCH}"
                git branch: "${params.BRANCH}", url: 'https://github.com/Trohimmaster/kbot.git'
            }
        }

        stage('Build') {
            steps {
                echo "Будуємо для середовища: ${params.ENV}"
                sh 'echo "Збірка..."'
            }
        }

        stage('Tests') {
            when {
                expression { return params.RUN_TESTS }
            }
            steps {
                echo "Запускаємо тести..."
                sh 'echo "Тестування..."'
            }
        }

        stage('Deploy') {
            steps {
                echo "Розгортаємо на ${params.ENV}"
                sh 'echo "Deploy complete!"'
            }
        }
    }

    post {
        always {
            echo 'Збірка завершена'
        }
        success {
            echo 'Успішно!'
        }
        failure {
            echo 'Щось пішло не так...'
        }
    }
}

