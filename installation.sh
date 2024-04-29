#!/bin/bash

USERID=$(id -u)

if [$USERID -ne 0]
then
    echo "Please run this script with root access"
    exit 1 # manuvally exit if error comes
else
    echo "you are super user"
fi

dnf install mysql -y

if [$? -eq 0]
then
    echo "Installation of mysql ...SUCCESS"
else
    echo "Installation of mysql ...FAILED"
    exit 1
fi
echo "testin"