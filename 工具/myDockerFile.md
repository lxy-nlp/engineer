FROM centos
MAINTAINER lxy<3289930671@qq.com>
ENV MYPATH /usr/local
WORKDIR $MYPATH

RUN apt-get install update
RUN apt-get install vim
RUN apt-get install net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "----end-----"
CMD /bin/bash



