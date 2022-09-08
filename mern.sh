#!/bin/bash
# Created by - DARSHAN V on 18/02/2022

if [ -x "$(command -v node)" ]; then
  tput setaf 4;echo "Nodejs Verision : $(node -v) $(tput setaf 7;)" >&2
else
     tput setaf 5;read -p "Nodejs is not installed. Do you want to install it ? (y/n): " bool;

     if [ $bool = y ];
     then
        sudo apt update
        sudo apt install npm
        npm update -g npm
        sudo npm cache clean -f
        sudo npm install -g n
        sudo n latest
        npm -v
        node -v
    else
        exit 1
    fi
fi

read -p "Enter project name : " name;

mkdir "$name"
cd "$name"
pwd

mkdir server
cd server
npm init -y
npm i express mongoose body-parser bcryptjs validation
npm i --save-dev nodemon

cat <<EOF >server.js
const express = require('express')
const  app = express()

// code

app.listen(3000)
EOF

cd ../

npx create-react-app client -y


if [ -x "$(command -v code)" ]; then
  code ../$name
else
    exit 1
fi