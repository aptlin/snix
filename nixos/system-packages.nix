{ config, pkgs, ... }:

{
  imports = [];          
  environment.systemPackages = with pkgs; [
    wget
    silver-searcher
    manpages
    autojump
    fzf
    shared_mime_info
    mc
    udevil
    stow
    curl

    #monitors	
    htop

    #networking
    iptables
    nmap
    tcpdump
    dhcp
    cmst            

    #sync
    syncthing        

    #editors
    vim
    emacs

    #git
    gitAndTools.gitFull        

    #devutils
    busybox
    psmisc
    gcc
    gnumake
    automake
    nix
    nox
    
    #files
    zip
    unzip
    rsync
    file
    pandoc
    libreoffice
    
    firefox
    w3m-nox
    html2text
    gcc #
    ghc #
    git
    gnupg
    imagemagick
    mpw
    ranger
    su
    unzip
    vim
    zip

    texlive.combined.scheme-full # lualatex, etc.
    zathura

    #screenshot
    gnome3.gnome-screenshot
  ];
}
