#! /bin/bash
          # Docker
          sudo apt-get update
          sudo apt install apt-transport-https
          curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
          sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
          sudo apt update
          sudo apt install docker-ce -y
          sudo usermod -aG docker $USER
          # Terraform
          wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
          echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
          sudo apt update && sudo apt install terraform
          # Net Tools
          sudo apt install net-tools
          sudo apt install inetutils-traceroute -y
          # Install Jenkins
          sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
          sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
	    sudo apt-get update
	    sudo apt-get install fontconfig openjdk-11-jre -y
	    sudo apt-get install jenkins -y
	    sudo systemctl enable jenkins
	    sudo usermod -aG docker ubuntu
	    sudo usermod -aG docker jenkins
          # Git
          sudo sudo apt install git
          # Copy Jenkins
          sudo touch jenkins_admin.txt
          sudo chmod 666 jenkins_admin.txt
          sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /home/ubuntu/jenkins_admin.txt
          # Install MySQL client
	    sudo apt-get install mysql-client -y
	    # Install Azure CLI
		  sudo apt-get update
		  sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
		  curl -sL https://packages.microsoft.com/keys/microsoft.asc |
		  gpg --dearmor |
		  sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
		  AZ_REPO=$(lsb_release -cs)
		  echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
		  sudo tee /etc/apt/sources.list.d/azure-cli.list
		  sudo apt-get update
		  sudo apt-get install azure-cli
		 