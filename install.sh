#!/bin/bash

# clone and install config files
if [ ! -d ~/dotfiles ]; then
    if ! dpkg-query -W git > /dev/null; then
        sudo apt-get install -q git
    fi

    git clone git@github.com:mwhite/dotfiles.git ~/dotfiles
    cd ~/dotfiles && git submodule update --init --recursive

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

cd ~/dotfiles/xsessions
for f in *; do
    sudo cp -f ~/dotfiles/xsessions/$f /usr/share/xsessions/$f
done

sudo cp -f ~/dotfiles/bin/compiz-session /usr/local/bin/compiz-session
sudo chmod 755 /usr/local/bin/compiz-session

mkdir -p ~/.pms ~/.mpd/playlists \
    ~/.vim/tmp/backup ~/.vim/tmp/swap ~/.vim/undodir

cd ~/.mpd && touch playlists mpd.db mpd.log sticker.sqlite

ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/.compiz-session ~/.compiz-session
ln -sf ~/dotfiles/.gitignore ~/.gitignore
ln -sf ~/dotfiles/.mpdconf ~/.mpdconf
ln -sf ~/dotfiles/pmsrc ~/.pms/rc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

source ~/.bashrc

git config --global user.name "$(getent passwd $USER | cut -d: -f5 | cut -d, -f1)"
git config --global color.ui true
git config --global core.excludesfile ~/.gitignore

# A list of repos that can be added with add-apt-repository
repos=(
    # Firefox Aurora builds (stable pre-beta)
    ppa:ubuntu-mozilla-daily/firefox-aurora

    # Indicator applet clone of GNOME 2 system monitor panel applet
    ppa:indicator-multiload/stable-daily

    'deb http://linux.dropbox.com/ubuntu precise main'

    'deb http://apt.last.fm/ debian testing'
);

# Packages to install
install=(
    ## Essentials
    kupfer
    vim-gnome vim-gtk exuberant-ctags
    dropbox
    gnome-tweak-tool
    compizconfig-settings-manager
    compiz-plugins-extra
    indicator-multiload
    indicator-applet-complete

    ## Multimedia
    ubuntu-restricted-extras non-free-codecs w32codecs libdvdcss2   # from Medibuntu
    vlc
    mpd mpdscribble pms ario
    lastfm
    cheese

    ## Office/Productivity
    pandoc
    pdftk
    abiword
    gnumeric
    qalculate
    catdoc

    ## Internet
    curl
    chromium-browser
    midori
    mozplugger mozilla-plugin-vlc
    pidgin pidgin-skype pidgin-otr pidgin-plugin-pack
    skype
    openssh-server

    ## Misc
    synaptic gdebi
    gconf-editor dconf-tools
    htop
    ack-grep
    nautilus-open-terminal
    qt4-qtconfig
);

function join() {
    local array=("${@}")
    local glue=" "
    echo ${array[*]}
}

# enable all ubuntu repositories except cd-rom
sudo sed -i "s/# deb http/deb http/g" /etc/apt/sources.list
sudo sed -i "s/\ndeb-src/\r# deb-src/g" /etc/apt/sources.list

# add repos
for r in "${repos[@]}"; do
    ppa=$(echo $r | sed -e 's/ppa://')
    if [[ ! $(sudo grep -r "$ppa" /etc/apt/) ]]; then 
        sudo add-apt-repository -y "$r"
    fi
done

# add keys
if [[ ! $(sudo apt-key list | grep "dropbox") ]]; then
    sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
fi

if [[ ! $(sudo apt-key list | grep "google") ]]; then
    wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -
fi

if [[ ! $(sudo apt-key list | grep "last.fm") ]]; then
    wget -q http://apt.last.fm/last.fm.repo.gpg -O- | sudo apt-key add -
fi

# add Medibuntu and update package list
if [[ ! $(dpkg -s medibuntu-keyring > /dev/null 2>&1) ]]; then
    sudo -E wget -q --output-document=/etc/apt/sources.list.d/medibuntu.list \
        http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list
    sudo apt-get -q update
    sudo apt-get -q --allow-unauthenticated install medibuntu-keyring
else
    sudo apt-get -q update
fi

# update packages
sudo apt-get -y --force-yes install $(join "${install[@]}") | sed '/already the newest version/d'
#sudo apt-get dist-upgrade
sudo apt-get -y autoremove
