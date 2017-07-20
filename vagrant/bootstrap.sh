#!/usr/bin/env bash

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb

apt-get -y update
apt-get -y upgrade
apt-get install -y esl-erlang elixir