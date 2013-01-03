#! /bin/bash
# check if hidden files are visible and store result in a variable
 
isVisible="$(defaults read com.apple.finder AppleShowAllFiles)"
# toggle visibility based on variables value

if [ "$isVisible" = FALSE ]
then
defaults write com.apple.finder AppleShowAllFiles TRUE
else
defaults write com.apple.finder AppleShowAllFiles FALSE
fi
# force changes by restarting Finder
Killall Finder
