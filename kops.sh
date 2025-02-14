#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket harshitha.sai --region us-east-1
aws s3api put-bucket-versioning --bucket harshitha.sai --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://harshitha.sai
kops create cluster --name sai.k8s.local --zones us-east-1a  --master-size t2.medium --master-count 1 --master-volume-size 40 --node-size t2.medium --node-count 2 --node-volume-size 40
kops update cluster --name sai.k8s.local --yes --admin
