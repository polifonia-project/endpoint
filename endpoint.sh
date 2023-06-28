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

    # Check if the ontology path is given
    if [ -z "$4" ]; then
        echo "Error: ontology path argument is missing! Using the default ontology..."
    else
        if [ ! -f "$4" ]; then
            echo "Error: ontology file does not exist! Using the default ontology..."
        else
            echo "Ontology path: $4"
            rm -rf ./ontology/*
            cp $4 ./ontology/ontology.owl
        fi
    fi

    # Check if the data path is given
    if [ -z "$5" ]; then
        echo "Error: data path argument is missing! Using the default data..."
    else
        if [ -d "$5" ]; then
            echo "Data path: $5"
            rm -rf ./data/*
            cp -r $5/. ./data/
        elif [ -f "$5" ]; then
            echo "Data path: $5"
            rm -rf ./data/*
            cp $5 ./data/.
        else
            echo "Error: data file does not exist! Using the default data..."
        fi
    fi


    # Replace the <endpoint_name> placeholder in the config.env file
    echo "Setting up the enpoint variables..."
    sed -i "s/<endpoint_name>/$2/" .docker/yasgui_index.html
    sed -i "s/<endpoint_name>/$2/" .docker/conf.lodview.ttl
    sed -i "s/<endpoint_name>/${2^}/" .docker/main_index.html

    # Start the endpoint
    echo "Starting the endpoint..."
    PORT=$3 docker compose build 
    PORT=$3 docker compose up -d


elif [ "$1" == "end" ]; then
    echo "Shutting down the endpoint..."
    docker compose down
else
    echo "Error: Invalid argument! Usage: ./endpoint.sh [start|end] <endpoint_name> <port>"
    exit 1
fi
