#!/usr/bin/env zsh

JIRA_HOST="https://unifyd.atlassian.net"
SEARCH_ENDPOINT="/rest/api/3/search"

USER="kevin.houtz@unifydinsights.com"

jira() {
	#################################################
	################## QUERIES ######################
	#################################################
	# Only in-progress tickets
	jql='assignee = currentUser()  AND status = "In Progress" ORDER BY created DESC'

	# All except epics
	all_jql='assignee = currentUser() AND type IN ("Bug","Story","Task","Subtask","Sub-task") ORDER BY type DESC'

	if [[ $1 = "all" ]]; then
		jql=$all_jql
	fi

	payload=$(jo jql=$jql startAt=0 maxResults=15 fields=$(jo -a summary status))
	url="${JIRA_HOST}${SEARCH_ENDPOINT}"

	response=$(curl -X POST \
		-s \
		$url \
		--json $payload \
		--user ${USER}:${JIRA_TOKEN})

	# echo $response | jq . > temp.json
	# '^' is used as a separator, presumably not too many ticket descriptions have that character in them
	echo $response | jq -r '[.issues[]] |
		sort_by(.fields.status.name) |
		.[] |
		.fields.status.name + "^" + .key + "^" + .fields.summary' | \
		column -t -s '^'
}

