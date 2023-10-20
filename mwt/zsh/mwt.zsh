
# Aliases
alias mwtca='export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain code-artifact --domain-owner 022811506149 --query authorizationToken --output text --profile mwt-ecom`'
alias sso="aws sso login --sso-session mwt-sso"

# Custom path
export PATH="$HOME/.jenv/bin:$HOME/src/mwt/hoopla/hoopla-bin:$HOME/bin:$PATH"

# Java stuffs
# install jdks with: brew tap homebrew/cask-versions && brew install --cask temurin<jdk_version>
# add jdks with: jenv add "$(/usr/libexec/java_home -v <version>)"
alias j17="jenv shell 17.0"
alias j11="jenv shell 11.0"
alias j8="jenv shell 1.8"

# jenv
eval "$(jenv init -)"

# direnv
eval "$(direnv hook zsh)"

# Colima config
export DOCKER_HOST="unix:///Users/kevinhoutz/.colima/default/docker.sock"

# NVM *puke*
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"


# EC2 helper
alias ec2ip="aws ec2 describe-instances --profile mwt-hoopla --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text --instance-ids"

ec2-jstat() {
	privateIp=$(ec2ip $1)
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${privateIp}
	ssh -i ~/.ssh/alexandria-keypair.pem -D 9696 ec2-user@"${privateIp}"
}

ec2-ssh() {
	privateIp=$(aws ec2 describe-instances --profile mwt-hoopla --instance-ids $1 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${privateIp}
	ssh -i ~/.ssh/alexandria-keypair.pem ec2-user@"${privateIp}"
}

ec2-scp() {
	privateIp=$(aws ec2 describe-instances --profile mwt-hoopla --instance-ids $1 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
	ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${privateIp}
	scp -i ~/.ssh/alexandria-keypair.pem ec2-user@"${privateIp}":${2} ${3}
}


view_last_vendor_report() {
	BUCKET="com.hoopladigital.vendor.docs"
	
	ENVIRONMENT="production" # dev, DEV, development, local, LOCAL, production, staging, test
	REPORT="CIRCULATIONS_OVERVIEW" # AT_A_GLANCE, CIRCULATIONS_OVERVIEW, FLEX_CIRCULATIONS, INVENTORY, TITLE_PERFORMANCE, TITLE_REPORT
	CURRENT_YEAR=$(date +%Y)
	PREFIX="vendor_reports/${ENVIRONMENT}/${REPORT}/${CURRENT_YEAR}/"
	# KEY=$(aws s3api list-objects-v2 --profile mwt-hoopla --bucket $BUCKET --prefix $PREFIX --query 'reverse(sort_by(Contents, &LastModified))' --output text)

	aws s3api list-objects-v2 --profile mwt-hoopla --bucket $BUCKET --prefix $PREFIX --query 'reverse(sort_by(Contents, &LastModified))' --output text

	# aws s3 cp --profile mwt-hoopla s3://$BUCKET/$KEY - | \
	# 	tail -n +3 | \
	# 	vim -c 'set ft=csv | RainbowAlign'
}

get_first_months_reports() {
	BUCKET="com.hoopladigital.vendor.docs"
	
	ENVIRONMENT="production" # dev, DEV, development, local, LOCAL, production, staging, test
	REPORT="CIRCULATIONS_OVERVIEW" # AT_A_GLANCE, CIRCULATIONS_OVERVIEW, FLEX_CIRCULATIONS, INVENTORY, TITLE_PERFORMANCE, TITLE_REPORT
	CURRENT_YEAR=$(date +%Y)
	PREFIX="vendor_reports/${ENVIRONMENT}/${REPORT}/${CURRENT_YEAR}/"

	REPORT_DATE="${CURRENT_YEAR}-${1}-09"

	KEYS=$(aws s3api list-objects-v2 \
		--profile mwt-hoopla \
		--bucket $BUCKET \
		--prefix $PREFIX \
		--query "Contents[?contains(LastModified, '${REPORT_DATE}')].Key" \
		--output json | \
		jq '.[]' -r
	)

	while IFS= read -r key; do
		outfile=$(basename $key)
		aws s3api get-object \
			--profile mwt-hoopla \
			--bucket $BUCKET \
			--key $key \
			--range "bytes=0-500" \
			$outfile
	done <<< "$KEYS"
}

get_vendor_report() {
	BUCKET="com.hoopladigital.vendor.docs"
	
	ENVIRONMENT="production" # dev, DEV, development, local, LOCAL, production, staging, test
	REPORT="CIRCULATIONS_OVERVIEW" # AT_A_GLANCE, CIRCULATIONS_OVERVIEW, FLEX_CIRCULATIONS, INVENTORY, TITLE_PERFORMANCE, TITLE_REPORT
	CURRENT_YEAR=$(date +%Y)
	PREFIX="vendor_reports/${ENVIRONMENT}/${REPORT}/${CURRENT_YEAR}"

	aws s3api get-object \
		--profile mwt-hoopla \
		--bucket $BUCKET \
		--key "$PREFIX/$1" \
		$1
}

# Usage: $ get_eb_env_logs <environment name> (<path>)
get_eb_env_logs() {
	[ -z "$1" ] && echo "Usage: $0 <environment name> <path>\npath is option, the default is '/var/log/tomcat/catalina.out'" && return

	EB_ENV="$1"
	TARGET_FILE="${2:-/var/log/tomcat/catalina.out}"

	rm -rf "./${EB_ENV}" && mkdir -p "./${EB_ENV}"
	# echo "target: $TARGET_FILE"

	INSTANCES=$(aws elasticbeanstalk describe-environment-resources --profile mwt-hoopla --environment-name "$EB_ENV" --query "EnvironmentResources.Instances" --output text)

	while IFS= read -r instance; do
		mkdir -p "./${EB_ENV}/${instance}"
		privateIp=$(aws ec2 describe-instances --profile mwt-hoopla --instance-ids $instance --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
		ssh-keygen -f "${HOME}/.ssh/known_hosts" -R ${privateIp}

		scp -i ~/.ssh/alexandria-keypair.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ec2-user@"${privateIp}":${TARGET_FILE} "./${EB_ENV}/${instance}/"
	done <<< "$INSTANCES"
}
