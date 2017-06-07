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
    gnupg1

    #monitors	
    htop
    ncdu

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

    #view helpers
    atool
    highlight
    mediainfo
    
    #git
    gitAndTools.gitFull        

    #devutils
    
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

    pass
    
    html2text
    gcc #
    ghc #
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
