@echo off

echo # game_assistant >> README.md

REM Initialize a new Git repo
git init

REM Add README.md file
git add README.md

REM Commit changes
git commit -m "initial commit"

REM Rename branch to main
git branch -M main

REM Add remote repository
set REPO_URL=https://github.com/thinhtran122000/game_assistant.git
git remote add origin %REPO_URL%

REM Push to GitHub
git push -u origin main

pause