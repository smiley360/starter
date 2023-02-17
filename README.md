# starter
This is a starter project to have ruby on rails and postgresDB running in docker container


# once you get the latest code, run the command to build the docker images
docker compose up

Once all the start up commands are completed, you should see the following message when it is ready.

starter-web-1  | ***********************************************************
starter-web-1  | *  It is about to ready to rock and roll                  *
starter-web-1  | ***********************************************************

if you receive a docker daemon error, you're docker service is likely not running.
from command line run `sudo systemctl start docker` or if you have the docker desktop app `open -a Docker`
