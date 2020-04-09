# CI-CD-Docker
CI-CD Process Using Docker, Jenkins SonarQube

Project to automatically manage the process of building, testing with the highest coverage, and deployment phases.

Our goal is to ensure our pipeline works well after each code being pushed. The processes we want to auto-manage:
* Code checkout
* Run tests
* Compile the code
* Run Sonarqube analysis on the code
* Create Docker image
* Push the image to Docker Hub
* Pull and run the image

# Setup the services
one of our goals is to obtain the sonarqube report of our project, we should be able to access sonarqube from the jenkins service. Docker compose is a best choice to run services working together. We configure our application services in a yaml file as below.

``docker-compose.yml``
```yml
version: '3.2'
services:
  sonarqube:
    build:
      context: sonarqube/
    ports:
      - 9000:9000
      - 9092:9092
    container_name: sonarqube
  jenkins:
    build:
      context: jenkins/
    privileged: true
    user: root
    ports:
      - 8080:8080
      - 50000:50000
    container_name: jenkins
    volumes:
      - /tmp/jenkins:/var/jenkins_home #tmp directory is designed to be wiped on system reboot.
      - /var/run/docker.sock:/var/run/docker.sock
    depends_on:
      - sonarqube
```

Paths of docker files of the containers are specified at context attribute in the docker-compose file. Content of these files as follows.

``sonarqube/Dockerfile``
```
FROM sonarqube:6.7-alpine
```

``jenkins/Dockerfile``
```
FROM jenkins:lts
```

# run the script run.sh to start docker containers:
```
docker ps -a

CONTAINER ID        IMAGE                                     COMMAND                  CREATED             STATUS              PORTS                                              NAMES
4872f0c2f577        sivakumarvunnam/jenkins-pipeline:latest   "java -jar /pipeline…"   3 hours ago         Up 3 hours          0.0.0.0:8090->8090/tcp                             jenkins-pipeline
2ba8dd91d251        ci-cd-docker_jenkins                      "/sbin/tini -- /usr/…"   6 hours ago         Up 6 hours          0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp   jenkins
a444f3dddeb3        ci-cd-docker_sonarqube                    "./bin/run.sh"           6 hours ago         Up 6 hours          0.0.0.0:9000->9000/tcp, 0.0.0.0:9092->9092/tcp     sonarqube
```

