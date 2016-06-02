# OSS chat room
OSS_ROOM="oss@conference.rutgers.edu"
OSS_ROOM_PASS="__PASSWORD__"

# XMPP Credentials
export HUBOT_XMPP_USERNAME="hubot@rutgers.edu"
export HUBOT_XMPP_PASSWORD="__PASSWORD__"
export HUBOT_XMPP_ROOMS="$OSS_ROOM:$OSS_ROOM_PASS"

# Webhook config
export PORT="8081"

# GitHub notifier
export HUBOT_GITHUB_EVENT_NOTIFIER_ROOM="$OSS_ROOM"
export HUBOT_GITHUB_EVENT_NOTIFIER_TYPES="ping,commit_comment,create,delete,\
deployment,deployment_status,fork,gollum,issue_comment,issues,member,membership,\
page_build,public,pull_request_review_comment,pull_request,push,repository,release,\
status,team_add,watch"

# Google image search credentials
export HUBOT_GOOGLE_CSE_ID="__CSE_ID__"
export HUBOT_GOOGLE_CSE_KEY="__CSE_KEY__"
