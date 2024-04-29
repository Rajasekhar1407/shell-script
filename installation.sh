#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2...FAILLED"
    else
        echo "$2...SUCCESS"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access"
    exit 1 # manuvally exit if error comes
else
    echo "you are super user"
fi

dnf instal mysql -y &>>$LOGFILE
VALIDATE "$?" "Installation of MySQL"

dnf install git -y &>>$LOGFILE
VALIDATE "$?" "Installation of GIT"

echo "testing"