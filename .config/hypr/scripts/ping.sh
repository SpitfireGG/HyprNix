#!/run/current-system/sw/bin/bash

ping -c 1 google.com > /dev/null

if [[ $? -eq 0 ]]; then
    echo "the internet is up and running";
else
    echo "the internet is not  working, Consider checking the connection manually";
fi
