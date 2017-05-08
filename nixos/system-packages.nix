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
    psmisc
    gcc
    gnumake
    automake
    autoconf
    libtool
    zlib
    binutils
    nix
    nox
    lsof

    #files
    zip
    unzip
    rsync
    file
    
    firefox
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
  ];
}
