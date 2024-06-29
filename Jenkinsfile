properties(
    [
        githubProjectProperty(
            displayName: 'docker-movienight',
            projectUrlStr: 'https://github.com/ruepp-info/docker-movienight/'
        )
    ]
)

pipeline {
    agent {
        label 'docker'
    }
    environment {
        IMAGE_FULLNAME = 'ruepp/movienight'
    }
    triggers {
        URLTrigger(
            cronTabSpec: 'H/30 * * * *',
            entries: [
                URLTriggerEntry(
                    url: 'https://hub.docker.com/v2/namespaces/library/repositories/ubuntu/tags/24.04',
                    contentTypes: [
                        JsonContent(
                            [
                                JsonContentEntry(jsonPath: '$.last_updated')
                            ]
                        )
                    ]
                ),
                URLTriggerEntry(
                    url: 'https://api.github.com/repos/zorchenhimer/MovieNight/commits/master',
                    contentTypes: [
                        JsonContent(
                            [
                                JsonContentEntry(jsonPath: '$.commit.author.date')
                            ]
                        )
                    ]
                )
            ]
        )
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME
                url: env.GIT_URL
            }
        },
        stage('Clone remote repository') {
            steps {
                git branch: 'master'
                url: 'https://github.com/zorchenhimer/MovieNight.git'
            }
        }
        stage('Build') {
            steps {
                sh 'chmod +x scripts/*.sh'
                sh './scripts/start.sh'
            }
        }
    }
}