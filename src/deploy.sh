#!/bin/bash

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git remote rm origin
git remote add origin https://$GH_TOKEN@github.com/SpinW/$TRAVIS_REPO_NAME.git
git add $TRAVIS_REPO_NAME.pdf
git commit -m 'Presentation update [ci skip]'
git push origin HEAD:$TRAVIS_BRANCH

# Add to the homepage....
if [ $TRAVIS_BRANCH = "master" ]; then
   cd ../
   git clone https://github.com/SpinW/spinw.github.io.git
   cd spinw.github.io
   git remote rm origin
   git remote add origin https://$GH_TOKEN@github.com/SpinW/spinw.github.io.git
   cd pages/_presentations
   cat ../../Pres_Template | awk '{gsub(/AAAA/,"'$TRAVIS_REPO_NAME'")}1' | awk '{gsub(/BBBB/,"'$TRAVIS_REPO_NAME'")}1' > $TRAVIS_REPO_NAME.md
   echo "" >> $TRAVIS_REPO_NAME.md
   cat ../../../$TRAVIS_REPO_NAME/README.md >> $TRAVIS_REPO_NAME.md
   git add $TRAVIS_REPO_NAME.md
   git commit -m 'Added a presentation [ci skip]'
   git push origin HEAD:master
fi
