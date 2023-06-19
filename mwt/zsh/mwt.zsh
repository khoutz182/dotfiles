
# Aliases
alias mwtca='export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain code-artifact --domain-owner 022811506149 --query authorizationToken --output text --profile mwtca`'
alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias j8="export JAVA_HOME=~/Library/Java/JavaVirtualMachines/temurin-1.8.0_362/Contents/Home; java -version"

# Custom path
export PATH="$HOME/.jenv/bin:$HOME/src/hoopla-bin:$JAVA_HOME/bin:$HOME/bin:$PATH"

# Colima config
export DOCKER_HOST="unix:///Users/kevinhoutz/.colima/default/docker.sock"

# NVM *puke*
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"


# EC2 helper
ec2-ssh() {
	privateIp=$(aws ec2 describe-instances --profile mwt-hoopla --instance-ids $1 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
	echo "Private IP: $privateIp"
	ssh -i ~/.ssh/alexandria-keypair.pem ec2-user@"${privateIp}"
}

ec2-scp() {
	privateIp=$(aws ec2 describe-instances --profile mwt-hoopla --instance-ids $1 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
	scp -i ~/.ssh/alexandria-keypair.pem ec2-user@"${privateIp}":${2} ${3}
}

