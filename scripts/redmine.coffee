# Interface to Redmine
#
# redmine <num> projects - show the first <num> projects
# redmine project <id> - show details of project <id>
# redmine tickets - show a list of issues
# redmine tickets <id> - show details of issue <id>
#

key = '1abe02272c6c3b1ee01ef17febca2249e15dbb3f'

module.exports = (robot) ->
  robot.respond /redmine (.*)project(|s)$/i, (msg) ->
    url = "https://css-projects.rutgers.edu/projects.json?key=#{key}&limit=#{msg.match[1]}"
    msg.http(url).get() (err, res, body) ->
      try
        json = JSON.parse(body)
	#projects = ("\t#{p.name}\n".join(' ') for p in json.projects)
        projects = "#{("Project: " + p.name +
	    "\nDescription: " + p.description +
	    "\nCreated: " + p.created_on +
	    "\nIdentifier: " + p.identifier +
	    "\nID: " +  p.id for p in json.projects).join("\n\n")}"
        msg.send "\n"+projects
      catch error
        console.log(error)
        msg.send "I could not get the projects"

  robot.respond /redmine project (.+)/i, (msg) ->
    url = "https://css-projects.rutgers.edu/projects/#{msg.match[1]}.json?key=#{key}"
    msg.http(url)
      .query(key: key)
      .get() (err, res, body) ->
        switch res.statusCode
          when 404
            msg.send "I could not find that project"
          when 403
            msg.send "I do not have permission to that project!"
          else
            try
              json = JSON.parse(body)
              project = json.project
              info  = "#{("\nProject: " + project.name +
	          "\nDescription: " + project.description +
	          "\nIdentifier: " + project.identifier +
                  "\nID: " + project.id +
	          "\nCreated: " + project.created_on +
	          "\nUpdated: " + project.updated_on)}"
              msg.send info
            catch error
              console.log(error)
              msg.send "I could not get that project"

  robot.respond /redmine (tickets|issues)$/i, (msg) ->
    url = "https://css-projects.rutgers.edu/issues.json?key=#{key}"
    msg.http(url)
      .get() (err, res, body) ->
        switch res.statusCode
          when 404
            msg.send "No issues. Yay!"
          when 500
            msg.send "I broke Redmine :o"
          else
            try
              json = JSON.parse(body)
              issues = formatIssues json.issues
              msg.send if issues then issues else "No #{msg.match[1]}. Yay!"
            catch error
              console.log(error)
              msg.send "I could not get any #{msg.match[1]}."

  robot.respond /redmine (tickets|issues) ((?!closed|opened|today).+)/i, (msg) ->
    url = "https://css-projects.rutgers.edu/issues.json?project_id=#{msg.match[2]}&key=#{key}"
    console.log(msg.match)
    console.log(url)
    msg.http(url)
    .get() (err, res, body) ->
      switch res.statusCode
        when 404
          msg.send "I could not find that project"
        when 403
          msg.send "I don't have permission for that project"
        when 500
          msg.send "I broke Redmine :o"
        else
          try
            json = JSON.parse(body)
            issues = formatIssues json.issues
            msg.send if issues then issues else "No #{msg.match[1]}. Yay!"
          catch error
            console.log(error)
            msg.send "I could not get any #{msg.match[1]} for that project :( "

  robot.respond /redmine (tickets|issues) (closed|opened) today$/i, (msg) ->
    date = new Date()
    day = date.getDate()
    month = date.getMonth()
    year = date.getFullYear()
    url = "https://css-projects.rutgers.edu/issues.json?key=#{key}&status_id=#{msg.match[2]}&updated_on=#{year}-#{month}-#{day}"
    msg.http(url)
    .get() (err, res, body) ->
      try
        json = JSON.parse(body)
        issues = formatIssues json.issues
        if issues
          msg.send issues
        else
          if msg.match[2] is 'closed'
            msg.send "No #{msg.match[1]} closed today. Oh man."
          else
            msg.send "No #{msg.match[1]} opened today. Hooray!"
       catch error
         console.log(error)
         msg.send "I could not get the #{msg.match[1]} :("

formatIssues = (issues) ->
  s = ''
  for issue in issues
    s += "\nSubject: #{issue.subject}" +
      "\nDescription: #{issue.description}" +
      "\nProject: #{issue.project.name}" +
      "\nPriority: #{issue.priority.name}" +
      "\nStatus: #{issue.status.name}" +
      "\nTracker: #{issue.tracker.name}" +
      "\nAuthor: #{issue.author.name}"
    if 'assigned_to' of issue
      s += "\nAssigned: #{issue.assigned_to.name}"
    s += "\nID: #{issue.id}\n"
  return s
