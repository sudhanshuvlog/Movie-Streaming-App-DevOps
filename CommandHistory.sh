[root@ip-172-31-33-128 MovieStreamingApp]# history
    1  cd /
    2  yum install docker -y
    3  systemctl start docker
    4  docker run -p 8080:8080 -p 50000:50000 -dit --name jenkins --restart=on-failure jenkins:lts-jdk17
    5  docker run -p 8080:8080 -p 50000:50000 -dit --name jenkins --restart=on-failure jenkins/jenkins:lts-jdk17
    6  docker ps
    7  docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
    1  clear
    2  cd /
    3  docker ps
    4  wget https://download.oracle.com/java/17/archive/jdk-17.0.10_linux-x64_bin.rpm
    5  yum install jdk-17.0.10_linux-x64_bin.rpm -y
    6  mkdir data
    7  curl -sO http://65.0.182.45:8080/jnlpJars/agent.jar
    8  java -jar agent.jar -url http://65.0.182.45:8080/ -secret 481fde92a41e39e57d60a16235e6e8c5f85cb8b0d0a54a0f16838eec0ce37755 -name ec2 -webSocket -workDir "/data" &
    9  yum install git -y
   10  history
    8  curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    9  sudo mv /tmp/eksctl /usr/local/bin
   10  eksctl version
   11  curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
   12  chmod +x ./kubectl
   13  sudo mv ./kubectl /usr/local/bin
   14  kubectl version --short --client
   15  eksctl create cluster --name EKS2109 --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed
   16  aws configure
   17  clear
   18  eksctl create cluster --name EKS2109 --region ap-south-1 --vpc-public-subnets=subnet-0e64ffc947ac8929c,subnet-04c1ed6ba9c55ffd7 --nodegroup-name default-ng --node-type t3.medium --nodes=2 --nodes-min=2 --nodes-max=2 --node-volume-size=20 --ssh-access --ssh-public-key DevOps --managed
   19  mysql
   20  yum whatprovides mysql
   21  yum install mariadb105-3:10.5.29-1.amzn2023.0.1.x86_64
   22  mysql
   23  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   24  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   25  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   26  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   27  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p
   28  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p 
   29  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p 
   30  ls
   31  kubectl get pod
   32  cd data/
   33  ls
   34  cd workspace/
   35  ls
   36  cd MovieStreamingApp
   37  ls
   38  docker images
   39  kubectl get pods
   40  kubectl get pods
   41  kubectl describe pod node-app-59c6d9cbf6-txkh5
   42  kubectl get pods
   43  kubectl get secret
   44  kubectl describe secret
   45  kubectl get configmap
   46  kubectl describe configmap webapp-config
   47  kubectl get svc
   48  kubectl get pods
   49  kubectl logs node-app-59c6d9cbf6-s6w2q
   50  mysql -h database-1.cbaw4kes2epe.ap-south-1.rds.amazonaws.com -u admin -p 
   51  kubectl get pods
   52  kubectl delete node-app-59c6d9cbf6-s6w2q node-app-59c6d9cbf6-txkh5
   53  kubectl delete pod node-app-59c6d9cbf6-s6w2q node-app-59c6d9cbf6-txkh5
   54  kubectl get pod
   55  history