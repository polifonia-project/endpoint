#!/bin/bash

if [ "$1" == "start" ]; then

    # Check if the endpoint_name argument is provided
    if [ -z "$2" ]; then
        echo "Error: endpoint_name argument is missing!"
        exit 1
    else
        echo "Endpoint name: $2"
    fi

    # Check if the port argument is provided
    if [ -z "$3" ]; then
        echo "Error: port argument is missing!"
        exit 1
    else
        echo "Port: $3"
    fi

    # Replace the <endpoint_name> placeholder in the config.env file
    echo "Setting up the enpoint variables..."
    sed -i "s/<endpoint_name>/$2/" .docker/yasgui_index.html
    sed -i "s/<endpoint_name>/$2/" .docker/conf.lodview.ttl

    # Start the endpoint
    echo "Starting the endpoint..."
    



elif [ "$1" == "end" ]; then
    echo "end"
else
    echo "Error: Invalid argument!"
    exit 1
fi
