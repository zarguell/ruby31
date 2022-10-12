# Overview

Ruby 3.1 was released on 12-25-2021 and has no end of life yet.

# Environment Variables

Name | Description | Default Value
--- | --- | ---
RUBY_MAJOR | The major version of Ruby. | 3
RUBY_MINOR | The minor version of Ruby. | 1
HOME | The path to the home folder for the default user (UID 1001). | /opt/app-root/src
GEM_HOME | The default path to GEM files. | /usr/local/bundle
BUNDLE_SILENCE_ROOT_WARNING |  Silence the warning Bundler prints when installing gems as root. | 1
BUNDLE_APP_CONFIG | Location of the Gem bundle to install. | Value of $GEM_HOME

# Documentation

Documentation for this version of Ruby can be found [here](https://docs.ruby-lang.org/en/3.1/).

# Basis

This applicaiton is based on the following:
- https://hub.docker.com/_/ruby
- https://github.com/docker-library/ruby