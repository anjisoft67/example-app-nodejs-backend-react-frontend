# example-app-nodejs-backend-react-frontend


                DevOps Assignment
Exercise: Setting Up CI/CD and Kubernetes Deployment using Terraform

Prerequisites:
AWS cloud account
Github account
Docker hub account.,
building an efficient CI/CD pipeline for a microservices application and deploying it to a Kubernetes cluster.
Requirements:
1. Version Control and Repository Setup.
2. Create a Git repository to host your microservices(Eg. Hello world, nginx, etc)
application code.
3. Choose a suitable branching strategy (e.g., Gitflow) for your repository.
4. CI/CD Pipeline.
5. Choose a CI/CD tool (e.g., Jenkins, GitLab CI/CD) and set it up.
6. Configure a webhook or integration between the repository and the CI/CD tool.
7. Create a pipeline that triggers on code commits or pull requests.
8. Implement build steps for your microservices, including running tests, code
quality checks, and creating Docker images.



Building an example-app-nodejs-backend-react-frontend microservices application.


By Creating Instances in AWS cloud.
Jenkins master (t2.large)
Installed jenkins and configured the all necessary plugins
K8s master (t2.medium)
Install kubeadm
K8s node (t2.medium)
Install kubeadm.
Prometheus (t2.medium)
Grafana (t2.medium)


Configured the Plugins in jenkins;
 NodeJs
Sonarqube scanner
Docker
Kubernetes
Eclipse Tumerin Installer
Prometheus
Step by step configuration:


Step-1: Jenkins master installed jenkins in it.

Jenkins: install plugins nodejs, Eclipse Temurin Installer


Installed docker on host machine.

     
step-2) Run the sonar container after that login to sonar by taking credentials
install plugin SonarQube Scanner
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community (created container in jenkins master)



Configured the webhook to sonar to the jenkins and
Created project examplenodejs in sonar and webhook configuration to jenkins

Created kubenetes cluster by installing kubeadm both master and node..setup cluster up




