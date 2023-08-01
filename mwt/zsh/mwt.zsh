
# Aliases
alias mwtca='export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain code-artifact --domain-owner 022811506149 --query authorizationToken --output text --profile mwtca`'
alias j17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias j8="export JAVA_HOME=~/Library/Java/JavaVirtualMachines/temurin-1.8.0_362/Contents/Home; java -version"
alias sso="aws sso login --sso-session mwt-sso"

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

	REPORT_DATE="${CURRENT_YEAR}-${1}-01"

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
