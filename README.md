Hubot Yardmaster
=============
This is a fork of Yardmaster, a Hubot plugin that allows you to interact with Jenkins instance remotely. It removes quite a lot of functionality, and only really builds, watches, and lists jobs. 

### Environment Variables Required:
* HUBOT_JENKINS_URL - Jenkins base URL
* HUBOT_JENKINS_USER - Jenins admin user
* HUBOT_JENKINS_USER_API_KEY - Admin user API key. Not your password. Find at "{HUBOT_JENKINS_URL}/{HUBOT_JENKINS_USER}/configure" 
* HUBOT_JENKINS_JOB_NAME - Hubot job name on Jenkins (optional)
* GITHUB_TOKEN - Github API Auth token (optional)
* MONITOR_JENKINS - true | false : If true, hubot will monitor the jenkins queue and start nodes when job queue is greater than 2.

### Commands:
* hubot list jobs|jenkins list|all jobs|jobs {job} - Shows all jobs in Jenkins. Filters by job if provided.
* hubot build|rebuild {job} - [Re]builds job.
* hubot build|rebuild {job} with {param1,param2}  - [Re]builds job with a comma separated list of parameters.
* hubot build|rebuild {job1,job2,jobN} - [Re]builds a comma separated list of jobs.
* hubot build|rebuild {job1,job2,jobN} with {param1,param2}  - [Re]builds a comma separated list of jobs with a comma separated list of parameters.
* hubot show|show last|last (build|failure|output) for {job} - show output for last job
* hubot show|show output|output for {job} {number} - show output job output for number given
* hubot show|show last|last (build|failure|output) for {job} - show output for last job.
* hubot show|show output|output for {job} {number} - show output job output for number given.
* hubot {job} status - show current build status and percent compelete of job and its dependencies.
* hubot watch job {job-url} - Will check job every minute and notify you on completion
* hubot (show|show last|last) (build) (date|time) for {job} - shows the last build date and time for a job
 
#### Author: 
#### @riveramj, with modifications by @jalev
