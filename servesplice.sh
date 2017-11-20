#!/bin/sh
read -p "Enter the version to build (doc, docstest, docsdev)      [docstest]: " version
version=${version:-docstest}
read -p "Enter the branch to build (2.7.0, 2.6.1, 2.6.0, 2.5)     [2.6.1]: " branch
branch=${branch:-2.6.1}
jekyll serve --config=_config.yml,_config_$version.yml,_config_$branch.yml
