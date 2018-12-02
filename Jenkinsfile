node {

    // Variable declaration:

        env = Deploy_to
        logstash_dockerfile      = "/var/jenkins_home/workspace/123-logstash/logstash/Dockerfile"
        logstash_dockerfile_context  = "/var/jenkins_home/workspace/123-logstash/logstash"
        jenkins_docker_connect      = "tcp://jenkinsci.xxxxxxxx123.com:2375"
        123dev_docker_connect       = "tcp://123dev.xxxxxxxx123.com:2375"
        123qa_docker_connect        = "tcp://123qa.xxxxxxxx123.com:2375"
        123stg_docker_connect       = "tcp://123stg.xxxxxxxx123.com:2375"
        pass                        = "abcdef@123"

  if (((Deploy_to == "dev")|| (Deploy_to == "qa")) && (Service == "create")) {

        stage ("Checkout the feature branch") {
            checkout([$class: 'GitSCM',
          branches: [[name: branch]],
          doGenerateSubmoduleConfigurations: false,
          extensions: [[$class: 'CleanCheckout']],
          //extensions: [],
          submoduleCfg: [],
          userRemoteConfigs: [[credentialsId: '3d33e519-0aab-4567-9487-xxxxxxxxxxxx', url: 'https://gitlab.xxxxxxxx123.com/123/123-logstash.git']]
        ])
    }

     stage ('Build Docker Image') {
            sh "docker -H $jenkins_docker_connect build -t 123-logstash -f $logstash_dockerfile $logstash_dockerfile_context"
     }

     stage ('Store Docker images to Nexus') {
          sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $jenkins_docker_connect tag 123-logstash:latest nexusci.xxxxxxxx123.com/123-logstash:latest && docker -H $jenkins_docker_connect push nexusci.xxxxxxxx123.com/123-logstash:latest"
     }

         stage ("Deploy to $env") {
         // sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123dev_docker_connect service create --env environment=dev --limit-memory 2048m --with-registry-auth --name 123-logstash --publish 5044:5044 --publish 12201:12201/udp --hostname 123dev-logstash.xxxxxxxx123.com --mount type=volume,source=123dev-etc-logstash-confd,destination=/etc/logstash/conf.d,volume-label=123dev-etc-logstash-confd --mount type=bind,source=logstash/logstash_dev.conf,destination=/etc/logstash/conf.d/logstash.conf nexusci.xxxxxxxx123.com/123-logstash:latest"
		 sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H tcp://123${env}.xxxxxxxx123.com:2375 service create --env environment=$env --limit-memory 2048m --with-registry-auth --name 123-logstash --publish 5044:5044 --publish 12201:12201/udp --hostname 123$env-logstash.xxxxxxxx123.com --mount type=volume,source=123$env-etc-logstash-confd,destination=/etc/logstash/conf.d,volume-label=123$env-etc-logstash-confd nexusci.xxxxxxxx123.com/123-logstash:latest"
     }
  }

  else if (((Deploy_to == "dev")|| (Deploy_to == "qa")) && (Service == "update")) {

         stage ("Checkout the feature branch") {
            checkout([$class: 'GitSCM',
          branches: [[name: branch]],
          doGenerateSubmoduleConfigurations: false,
          extensions: [[$class: 'CleanCheckout']],
          submoduleCfg: [],
          userRemoteConfigs: [[credentialsId: '3d33e519-0aab-4567-9487-xxxxxxxxxxxx', url: 'https://gitlab.xxxxxxxx123.com/123/123-logstash.git']]
        ])
    }

        stage ('Cleanup docker image') {
           sh "docker -H $jenkins_docker_connect rmi 123-logstash"
        }

                stage ('Build Docker Image') {
                   sh "docker -H $jenkins_docker_connect build -t 123-logstash -f $logstash_dockerfile $logstash_dockerfile_context"
        }

                stage ('Store Docker images to Nexus') {
                   sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $jenkins_docker_connect tag  123-logstash:latest nexusci.xxxxxxxx123.com/123-logstash:latest && docker -H $jenkins_docker_connect push nexusci.xxxxxxxx123.com/123-logstash:latest"
                }

            stage ("Deploy to $env") {
               sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H tcp://123${env}.xxxxxxxx123.com:2375 service update --env-add environment=$env --with-registry-auth --image nexusci.xxxxxxxx123.com/123-logstash:latest 123-logstash"
        }
   }

  if ((Deploy_to == "DEV_QA_STG") && (Service == "create") && (branch == "master")) {

      stage ("Checkout the feature branch") {
            checkout([$class: 'GitSCM',
          branches: [[name: branch]],
          doGenerateSubmoduleConfigurations: false,
          extensions: [[$class: 'CleanCheckout']],
          submoduleCfg: [],
          userRemoteConfigs: [[credentialsId: '3d33e519-0aab-4567-9487-xxxxxxxxxxxx', url: 'https://gitlab.xxxxxxxx123.com/123/123-logstash.git']]
        ])
    }

     stage ('Build Docker Image') {
          sh "docker -H $jenkins_docker_connect build -t 123-logstash -f $logstash_dockerfile $logstash_dockerfile_context"
     }

     stage ('Store Docker images to Nexus') {
          sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $jenkins_docker_connect tag  123-logstash:latest nexusci.xxxxxxxx123.com/123-logstash:latest && docker -H $jenkins_docker_connect push nexusci.xxxxxxxx123.com/123-logstash:latest"
     }

     stage ('Deploy to Dev') {
          sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123dev_docker_connect service create --env environment=dev --limit-memory 2048m --with-registry-auth --name 123-logstash --publish 5044:5044 --publish 12201:12201/udp --hostname 123dev-logstash.xxxxxxxx123.com --mount type=volume,source=123dev-etc-logstash-confd,destination=/etc/logstash/conf.d,volume-label=123dev-etc-logstash-confd nexusci.xxxxxxxx123.com/123-logstash:latest"
     }

         stage ('Deploy to qa') {
         input 'Do you approve deployment?'
                 sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123qa_docker_connect service create --env environment=qa --limit-memory 2048m --with-registry-auth --name 123-logstash --publish 5044:5044 --publish 12201:12201/udp --hostname 123qa-logstash.xxxxxxxx123.com --mount type=volume,source=123qa-etc-logstash-confd,destination=/etc/logstash/conf.d,volume-label=123qa-etc-logstash-confd nexusci.xxxxxxxx123.com/123-logstash:latest"
         }

         stage ('Deploy to stg') {
        input 'Do you approve deployment?'
                sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123stg_docker_connect service create --env environment=stg --limit-memory 2048m --with-registry-auth --name 123-logstash --publish 5044:5044 --publish 12201:12201/udp --hostname 123stg-logstash.xxxxxxxx123.com --mount type=volume,source=123stg-etc-logstash-confd,destination=/etc/logstash/conf.d,volume-label=123stg-etc-logstash-confd nexusci.xxxxxxxx123.com/123-logstash:latest"
         }
  }

 else if ((Deploy_to == "DEV_QA_STG") && (Service == "update") && (branch == "master")) {

      stage ("Checkout the feature branch") {
            checkout([$class: 'GitSCM',
          branches: [[name: branch]],
          doGenerateSubmoduleConfigurations: false,
          extensions: [[$class: 'CleanCheckout']],
          submoduleCfg: [],
          userRemoteConfigs: [[credentialsId: '3d33e519-0aab-4567-9487-xxxxxxxxxxxx', url: 'https://gitlab.xxxxxxxx123.com/123/123-logstash.git']]
        ])
    }

        stage ('Cleanup docker image') {
           sh "docker -H $jenkins_docker_connect rmi 123-logstash"
        }

                stage ('Build Docker Image') {
                   sh "docker -H $jenkins_docker_connect build -t 123-logstash -f $logstash_dockerfile $logstash_dockerfile_context"
        }

                stage ('Store Docker images to Nexus') {
                   sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $jenkins_docker_connect tag  123-logstash:latest nexusci.xxxxxxxx123.com/123-logstash:latest && docker -H $jenkins_docker_connect push nexusci.xxxxxxxx123.com/123-logstash:latest"
                }

            stage ('Deploy to Dev') {
               sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123dev_docker_connect service update --env-add environment=dev --with-registry-auth --image nexusci.xxxxxxxx123.com/123-logstash:latest 123-logstash"
        }

            stage ('Deploy to qa') {
           input 'Do you approve deployment?'
                   sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123qa_docker_connect service update --env-add environment=qa --with-registry-auth --image nexusci.xxxxxxxx123.com/123-logstash:latest 123-logstash"
        }

            stage ('Deploy to stg') {
           input 'Do you approve deployment?'
                   sh "docker -H $jenkins_docker_connect login -u admin -p $pass nexusci.xxxxxxxx123.com && docker -H $123stg_docker_connect service update --env-add environment=stg --with-registry-auth --image nexusci.xxxxxxxx123.com/123-logstash:latest 123-logstash"
            }
  }
}
