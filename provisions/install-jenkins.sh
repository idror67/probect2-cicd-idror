#set timezone to be jerusalem:
sudo timedatectl set-timezone Asia/Jerusalem

# install java v17
sudo apt update
sudo apt-get upgrade -y
sudo apt install fontconfig git openjdk-17-jre  -y

java -version




# install jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

# This line allows the jenkins user to run any command (ALL) as any user ((ALL)) without being prompted for a password (NOPASSWD).
# need to add this to sudo file (sudo visudo)  # jenkins ALL=(ALL) NOPASSWD: ALL
# add jenkins to sudo group
sudo usermod -aG sudo jenkins  
sudo usermod -aG vagrant jenkins  
# start jenkins
sudo systemctl start jenkins

# enable jenkins (to start on boot)
sudo systemctl enable jenkins

# check jenkins status
sudo systemctl status jenkins

# script to copy the initial admin password to the root user's home directory
echo "# $(date) Copy the initial admin password to the root user's home directory..."
cp /var/lib/jenkins/secrets/initialAdminPassword ~
echo "Installation is complete."

echo "# Open the URL for this server in a browser and log in with the following credentials:"
echo
echo
echo "    Username: admin"
echo "    Password: $(cat /var/lib/jenkins/secrets/initialAdminPassword)"
echo
echo


# Install Docker
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add Jenkins user to the Docker group
sudo usermod -aG docker jenkins

# Restart Jenkins to apply changes
sudo systemctl restart jenkins