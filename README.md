# sisbot-setup
Sisbot is based on the hubot-sitescope implementation provide by HPESoftware R&D.

Prerequisites
ChatOps integration of HPESoftware hubot-sitescope (https://github.com/HPSoftware/hubot-sitescope) is supported starting from Sitescope 11.32.

Docker image
The bot is running inside a docker container. The image is created using the Dockerfile and issuing a docker build command on the

docker build -t sisbot .
Configuration

The connection parameters to Sitescope are stored
