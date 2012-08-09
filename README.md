Purpose
=============

This little script deals with the issue in PHPstorm, that nexted git reporsitories are not detected / added automatically to you project.
Basically, all it does is doing a recursive search for git controled folders in your project root and register them to phpstorm into the configuraiton file.

Finally, no need to add VCS folders by hand yourself..

You need
--------------

* PHPstorm
* ruby

Installation
--------------

* Symlink the reggit.rb executable into /usr/local/bin or whereever you like to (add it to yout $PATH, whatever)

Usage (Short)
--------------
<blockquote>reggit.rb path-to-PHPstorm-project-root </blockquote>

(you can ease things up by changing into your project root and just writing reggit.rb)

Hints
--------------
 - Be aware, you first need to create a PHPstorm project, then run this script
 - This scripts recreates all git-vcs entrys, means, if you customize the list by hand, those will be deleted. Feel free to patch the script for this purpose :)
