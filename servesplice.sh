#!/bin/sh
printf "Enter the version to build (doc, docstest, docsdev): "
read VERS
printf "Enter the branch to build (current, 2.7, 2.6, 2.5): "
read BRANCH
jekyll serve --config=_config.yml,_config_$VERS.yml,_config_$BRANCH.yml
