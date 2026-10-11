[root@ip-172-31-14-91 gfg48-movie-streaming-app]# history
    1  cd /
    2  yum install docker -y
    3  systemctl start docker
    4  docker run -p 8080:8080 -p 50000:50000 --name jenkins -dit --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21
    5  docker ps
    6  docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
    7  aws configure
    8  clear
    9  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   10  sudo mv /tmp/eksctl /usr/local/bin
   11  eksctl version
   12  curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.36.2/2026-07-05/bin/linux/amd64/kubectl
   13  chmod +x ./kubectl
   14  cp ./kubectl /usr/local/bin/
   15  eksctl create cluster --name EKS21 --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed 
   16  docker ps
   17  systemctl status docker
   18  vi /usr/lib/systemd/system/docker.service 
   19  vi /usr/lib/systemd/system/docker.service 
   20  systemctl daemon-reload
   21  systemctl restart docker
   22  docker ps
   23  mkdir /data
   24  wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.rpm
   25  yum install jdk-21_linux-x64_bin.rpm -y
   26   yum install git -y
   27  curl -sO http://13.233.255.219:8080/jnlpJars/agent.jar
   28  java -jar agent.jar -url http://13.233.255.219:8080/ -secret 03217b7f3eb3872ab0dca77c743267070d8efdba766d35daec541751edfb344d -name ec2 -webSocket -workDir "/data" &
   29  sudo yum install -y https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm
   30  dnf install -y mysql-community-client
   31  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
   32  docker ps
   33  docker ps
   34  docker ps
   35  cd /data
   36  ls
   37  cd workspace/
   38  ls
   39  cd gfg48-movie-streaming-app/
   40  ps -aux | grep java
   41  kubectl get pods
   42  kubectl get pods
   43  kubectl get svc
   44  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
   45  kubectl get pods
   46  kubectl get pods
   47  kubectl get pods
   48  kubectl get pods
   49  kubectl get pods
   50  kubectl get pods
   51  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -P 3306 -u admin -p
   52  history
   53 eksctl delete cluster --name EKS21
