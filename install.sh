#!/bin/bash

# clone and install config files
if [ ! -d ~/dotfiles ]; then
    if ! dpkg-query -W git; then
        echo "installing git"
        sudo apt-get install -q git
    fi

    echo "cloning dotfiles repo"
    mkdir -p ~/dotfiles ~/.pms
    git clone git@github.com:mwhite/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles/xsessions
for f in *; do
    sudo cp -f ~/dotfiles/xsessions/$f /usr/share/xsessions/$f
done

sudo cp -f ~/dotfiles/bin/compiz-session /usr/local/bin/compiz-session

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/pmsrc ~/.pms/rc
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.compiz-session ~/.compiz-session

source ~/.bashrc

# A list of repos that can be added with add-apt-repository
repos=(
    # Firefox Aurora builds (stable pre-beta)
    ppa:ubuntu-mozilla-daily/firefox-aurora

    # Indicator applet clone of GNOME 2 system monitor panel applet
    ppa:indicator-multiload/stable-daily

    # Elementary PPAs
    ppa:elementary-os/daily
    ppa:marlin-devs/marlin-daily

    'deb http://apt.last.fm/ debian testing'
);

# Packages to install
install=(
    ## Elementary
    elementary-theme
    elementary-icon-theme
    marlin marlin-plugin-dropbox

    ## Multimedia
    ubuntu-restricted-extras non-free-codecs w32codecs libdvdcss2   # from Medibuntu
    vlc gnome-media-player
    mpd mpdscribble pms ario sonata
    lastfm
    picard
    cheese
    gtkpod
    gimp

    ## Office/Productivity
    pandoc
    texlive-latex-base texlive-latex-extra texlive-fonts-recommended
    bibclean
    abiword
    gnumeric
    qalculate
    catdoc

    ## Development
    build-essential
    ddd
    vim vim-gnome
    git
    mercurial
    subversion
    bzr
    geany geany-plugins

    ## Internet
    curl
    chromium-browser
    midori
    mozplugger mozilla-plugin-vlc
    pidgin pidgin-facebookchat pidgin-skype pidgin-otr pidgin-plugin-pack
    skype
    openssh-server
    ddclient
    nautilus-dropbox

    ## Misc
    synaptic
    gdebi
    gconf-editor
    gnome-tweak-tool
    htop
    ack-grep

    nautilus-open-terminal
    compizconfig-settings-manager
    compiz-plugins-extra
    kupfer
    indicator-multiload
    indicator-applet-complete
    dconf-tools
    gnuplot
    scrot
    wordplay

    ## Packages to remove
    #indicator-messages-
    #thunderbird-
);

function join() {
    local array=("${@}")
    local glue=" "
    echo ${array[*]}
}

# enable all ubuntu repositories except cd-rom
sudo sed -i "s/# deb http/deb http/g" /etc/apt/sources.list

# add apt repositories
for r in "${repos[@]}"; do
    ppa=$(echo $r | sed -e 's/ppa://')
    if [[ ! $(sudo grep -r "$ppa" /etc/apt/) ]]; then 
        echo "adding $r"
        sudo add-apt-repository -y "$r" &> /dev/null
    fi
done

# Add last.fm key
if [[ ! $(sudo apt-key list | grep "last.fm") ]]; then
    echo "adding last.fm key"
    wget -q http://apt.last.fm/last.fm.repo.gpg -O- | sudo apt-key add - > /dev/null
fi

# install mendeley
if ! dpkg-query -W mendeleydesktop > /dev/null; then
    echo "installing mendeley"
    wget -q http://www.mendeley.com/repositories/ubuntu/stable/mendeleydesktop.key -O- | sudo apt-key add - > /dev/null
    wget -q http://www.mendeley.com/repositories/ubuntu/stable/i386/mendeleydesktop-latest --output-document=/tmp/mendeley.deb
    sudo dpkg -i /tmp/mendeley.deb
fi

# Add Medibuntu
if [ ! -f /etc/apt/sources.list.d/medibuntu.list ]; then
    echo "adding medibuntu"
    sudo -E wget -q --output-document=/etc/apt/sources.list.d/medibuntu.list \
        http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list > /dev/null
    sudo apt-get -q update
    sudo apt-get -q --allow-unauthenticated install medibuntu-keyring > /dev/null
fi

# Update packages
sudo apt-get -q update
sudo apt-get -y install $(join "${install[@]}") | sed '/already the newest version/d'
sudo apt-get -q autoremove
#sudo apt-get dist-upgrade


