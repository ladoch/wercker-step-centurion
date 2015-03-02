#!/bin/bash

if [ ! -n "$WERCKER_CENTURION_PROJECT" ]; then
  error 'Please specify the project property'
  exit 1
fi

if [ ! -n "$WERCKER_CENTURION_ENVIRONMENT" ]; then
  error 'Please specify the environment property'
  exit 1
fi

if [ ! -n "$WERCKER_CENTURION_ACTION" ]; then
  error 'Please specify the action property'
  exit 1
fi

gem install centurion
rbenv rehash

command = "bundle exec centurion -p $WERCKER_CENTURION_PROJECT -e $WERCKER_CENTURION_ENVIRONMENT -a $WERCKER_CENTURION_ACTION"

if [ -n "$WERCKER_CENTURION_REGISTRY_USER" ]; then
  command = "$command --registry-user=$WERCKER_CENTURION_REGISTRY_USER"
fi

if [ -n "$WERCKER_CENTURION_REGISTRY_PASSWORD" ]; then
  command = "$command --registry-password=$WERCKER_CENTURION_REGISTRY_PASSWORD"
fi

RESULT = `$command`
