#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=$SCRIPT_NAME-$TIMESTAMP

R="\e[31m"
G="\e[32m"
N="\e[0m"


if [ $USERID -ne 0 ]
then
    echo -e "$R Please run the script with root access $N"
    exit 1
else
    echo -e "$G You are Super User $N"
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2...$R FAILED $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
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