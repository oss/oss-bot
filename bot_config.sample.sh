OSS_ROOM="oss@conference.rutgers.edu"
OSS_ROOM_PASS="password"

# XMPP Credentials
export HUBOT_XMPP_USERNAME="hubot@rutgers.edu"
export HUBOT_XMPP_PASSWORD="password"
export HUBOT_XMPP_ROOMS="$OSS_ROOM:$OSS_ROOM_PASS"

# Webhook config
export PORT="8081"

# GitHub notifier
export HUBOT_GITHUB_EVENT_NOTIFIER_ROOM="$OSS_ROOM"
export HUBOT_GITHUB_EVENT_NOTIFIER_TYPES="ping,commit_comment,create,delete,\
deployment,deployment_status,fork,gollum,issue_comment,issues,member,membership,\
page_build,public,pull_request_review_comment,pull_request,push,repository,release,\
status,team_add,watch"
