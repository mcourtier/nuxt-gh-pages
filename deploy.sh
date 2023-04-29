#!/bin/bash

# Check if there are any uncommitted changes in the current branch
if [ -n "$(git status --porcelain)" ]; then
  echo "There are uncommitted changes in the current branch. Aborting deployment."
  exit 1
fi

# Switch to the gh-pages branch
git checkout gh-pages

# Move into the dist folder
cd dist

# Copy the contents of the dist folder to the root directory
cp -r . ..

# Move back up to the root directory
cd ..

# Remove all files and directories except the .git folder and the dist folder
ls | grep -v ".git\|dist" | xargs rm -rf

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Push the changes to the gh-pages branch
git push origin gh-pages

# Switch back to the previous branch
git checkout -
