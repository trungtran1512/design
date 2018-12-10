FROM centos:7

# Environmental variables
# ENV APP_NAME webapp
# ENV APP_USER $APP_NAME
# ENV APP_GROUP $APP_NAME
# ENV HOME_PATH /$APP_NAME
ENV APP_PATH $HOME_PATH/app
ENV PACKAGES curl vim git-core zlib zlib-devel gcc gcc-c++ patch readline readline-devel \
libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake \
libtool bison sqlite-devel libxml2 libxml2-devel mariadb-devel libxslt-devel \
ImageMagick ImageMagick-devel epel-release yum-utils pygpgme iconv-devel \
python-software-properties nodejs

RUN yum -y update

# Install rbenv system dependencies
RUN yum install -y $PACKAGES

# Clean up yum cache
RUN yum clean all

# Create the unprivileged application user, group and directory, and switch user
# Install rbenv
# Install rbenv and ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN cd /root/.rbenv/plugins/ruby-build && git pull && cd -
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh # or /etc/profile
RUN echo 'eval "$(rbenv init -)"' >> .bashrc



# install ruby-build

ENV RUBY_VERSION 2.5.3
RUN rbenv install $RUBY_VERSION && rbenv local $RUBY_VERSION
RUN /bin/bash -l -c "gem install --no-ri --no-rdoc bundler"
RUN rbenv rehash
RUN /bin/bash -l -c "gem install rails -v '>= 5.2.1' --no-ri --no-rdoc" && \
rbenv rehash

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN echo "export PATH=$PATH" >> /root/.bashrc

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"
RUN yum -y install nodejs


RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

RUN rbenv local $RUBY_VERSION
ADD . /myapp
RUN rbenv rehash
RUN /bin/bash -l -c "bundle install"
CMD ["/usr/sbin/init"]

EXPOSE 3000