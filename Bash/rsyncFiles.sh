#! /bin/bash
# Synchronize files from one path to another (e.g. a local directory to/from a remote
# SMB share).

rsync -az --delete '/source/file/path' '/destination/file/path'