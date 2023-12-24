#!/bin/bash
# Created by - DARSHAN V on 18/02/2022

installNode() {
  echo "Latest Node lts and npm will be installed";
    sudo apt install npm -y
    npm -v
    npm update -g npm

    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    nvm install --lts

    echo "node version"
    node -v

    echo "npm version"
    npm -v
}

if [ -x "$(command -v node)" ]; then
  tput setaf 4;echo "Nodejs Verision : $(node -v) $(tput setaf 7;)" >&2
  tput setaf 5;read -p "Do you want to upgrade npm and node to latest LTS version ? (y/n): " bool;
  if [ $bool = y ];
    then
      installNode
    fi
else
    tput setaf 5;read -p "Nodejs is not installed. Do you want to install it ? (y/n): " bool;

    if [ $bool = y ];
    then
      installNode
    fi
fi

read -p "Enter project name : " name;

mkdir "$name"
cd "$name"
pwd

mkdir server
cd server

npm init -y
jq '.type = "module"' package.json > tmpfile && mv tmpfile package.json #add "type":"module" to package.json file

npm i express mongoose bcrypt cors cookie-parser
npm i --save-dev nodemon

cat <<EOF >server.js
import express from 'express'
import cors from 'cors'
import cookieParser from "cookie-parser";

const app = express()

app.use(cors({credentials: true, origin: true}));
app.use(cookieParser());

// Parse JSON bodies
app.use(express.json());

// Parse URL-encoded bodies
app.use(express.urlencoded({ extended: true }));
app.listen(8000)
EOF

cd ../

tput setaf 5;read -p "Install reat-app too ? (y/n): " bool;

    if [ $bool = y ]; then
      npx create-react-app client -y
    fi


if [ -x "$(command -v code)" ]; then
  code ../$name
else
    exit 1
fi