#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=$SCRIPT_NAME-$TIMESTAMP

if [ $USERID -ne 0 ]
then
    echo "Please run the script with root access"
    exit 1
else
    echo "You are Super User"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2...FAILED"
        exit 1
    else
        echo "$2...SUCCESS"
    fi
}

dnf install mysql-server -y &>>$LOGFILE
VALIDATE "$?" "Installation of Mysql"

systemctl enable mysqld &>>$LOGFILE
VALIDATE "$?" "Enabling Mysql"

systemctl start mysqld &>>$LOGFILE
VALIDATE "$?" "Starting Mysql"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE "$?" "Settingup Password for DB"