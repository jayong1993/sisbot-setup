FROM node:4.5.0
MAINTAINER Zhang Yong <yong.zhang@hpe.com>

ENV https_proxy http://proxy.atlanta.hp.com:8080

RUN npm install -g yo generator-hubot coffee-script && useradd hubot -m -s /bin/sh
USER hubot
WORKDIR /home/hubot

ENV HUBOT_NAME sisbot
ENV HUBOT_OWNER someone
ENV HUBOT_DESCRIPTION HP sitescope bot in mattermost
RUN echo no | yo hubot --adapter=mattermost --name=$HUBOT_NAME --owner=$HUBOT_OWNER --description=$HUBOT_DESCRIPTION && \
npm install git+https://github.hpe.com/hpe-sws-dev-ops/hubot-sitescope.git --save
#npm install git+https://github.com/jayong1993/hubot-sitescope.git --save
RUN sed -i /heroku/d ./external-scripts.json

#add HP SiteScope external-scripts
RUN sed '2i"hubot-sitescope",' -i ./external-scripts.json
RUN npm install git+https://git@github.hpe.com/hpe-sws-dev-ops/hubot-mattermost-attachment.git --save
#RUN npm install https://github.com/jayong1993/hubot-mattermost-attachment.git --save
RUN sed '2i"hubot-mattermost-attachment",' -i ./external-scripts.json

# listen endpoint
ENV MATTERMOST_ENDPOINT /hubot/incoming
# your mattermost token
ENV MATTERMOST_TOKEN oqwx9d4khjra8cw3zbis1w6fqy
# your mattermost income url
ENV MATTERMOST_INCOME_URL http://<your mattermost instance>:<port>/hooks/ncwc66caqf8d7c4gnqby1196qo
# optional: if you want to override hubot name
ENV MATTERMOST_HUBOT_USERNAME=
# optional: if you want to override your channel
ENV MATTERMOST_CHANNEL=
# optional: if you want to override hubot icon
ENV MATTERMOST_ICON_URL=
# optional: if you want to ignore self signed certificate
ENV MATTERMOST_SELFSIGNED_CERT=

RUN unset https_proxy 

EXPOSE 8080

ENTRYPOINT ["bin/hubot"]
CMD ["-a", "mattermost"]

