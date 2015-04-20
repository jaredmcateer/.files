My dot files
============

This repository contains my best version of dot files to date.

Setup
-----

### Prerequites

There is some preambulatory stuff I install (some of it necessary for this to
work and some of it not.) Mostly everythign is included in the system-setup.sh 
file.

Basically it breaks down to

* Essenstial depenencies and libs to build stuff
* htop (it's 2015 people)
* git
* tmux
* SilverSearcher AG
* Ack
* Chrome Stable
* Neovim (it's stable enough and very nice.)
* Node Version Manager
* Rbenv (Ruby version manager)
* Fzf (ctrl-p for bash, it's amazing)
* [Synergy](http://synergy-project.org/download/) (KVM for multiple computers)
* Virtual Box

Note: Don't forget to setup your SSH keys

```
ssh-keygen -t rsa -C "<your email>"
cat ~/.id_rsa.pub
```

And update your remote repos that need it:

* https://github.com/settings/ssh
* https://bitbucket.org/account/user/jmcateer/ssh-keys/
* Internal company, etc

### Install

Once you've done all that to setup your dot files clone this repo:

```
git clone https://github.com/jaredmcateer/dotfiles.git ~/.files
cd ~/.files
./install
```

### Misc

This also installs powerline modified fonts for your airline bar. Switch your
terminal font to one of them for a more beautify experiences

Notes
-----

My vimrc is HEAVILY copied from [slj's 
dotfiles](https://bitbucket.org/sjl/dotfiles/overview).
If you want a good overview of what's going on there he posted a [great
video](https://www.youtube.com/watch?v=xZuy4gBghho).

I recommend you watch it because there's a lot of useful information there.
