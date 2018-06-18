# Copy Tool

A macOS Copy script that allows for the easy copy and transfer of files and folders. Using Rsync

![Alt Text](https://media.giphy.com/media/6bdhbLDA8Iuk1IFcx4/giphy.gif)

This tool can be run as root to avoid potential issues with user file permissions and destination directory access. However this is not essential. If being run as root and the Change user file permissions is selected it will not use the ROOT user but the current logged in user that began the copy. **Keep this in mind for SSH and remote copies**


*Note: Rsync is the copy manager that is used. Which means this tool can also be used across LAN connections and servers.*
