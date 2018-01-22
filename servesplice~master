#!/bin/sh
read -p "Enter the version to build (doc, docstest, docsdev)      [docsdev]: " version
version=${version:-docsdev}
if [ $version = 'doc' ]
then
    read -p "Enter the branch to build (2.7.0, 2.6.1, 2.6.0, 2.5)     [2.7.0]: " branch
branch=${branch:-2.7.0}
    jekyll build --config=_config.yml,_config_$version.yml,_config_$branch.yml
    mv _site/sitemap.xml sitemap.$version.$branch.xml
    echo "Generated sitemap file: sitemap.$version.$branch.xml"
else
    branch='2.7.0'
fi
jekyll serve --config=_config.yml,_config_$version.yml,_config_$branch.yml
