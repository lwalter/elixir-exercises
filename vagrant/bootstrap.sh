#!/usr/bin/env bash

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

apt-get -y update
apt-get install -y esl-erlang nodejs elixir

#mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
