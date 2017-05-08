# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ];

  hardware = {
    pulseaudio.enable = true;          
    };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
   {
     name = "root";
     device = "/dev/sda4";
     preLVM = true;
   }
  ];
  boot.loader.grub.device = "/dev/sda";
  boot.kernelModules = [ "coretemp" "applesmc" "hid_apple" "kvm-intel" ];
  boot.cleanTmpDir = true;
  boot.blacklistedKernelModules = [ "snd_pcsp" "hp_wmi"];
  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
    options hid_apple fnmode=2
  '';
  boot.kernelParams = [
  "hid_apple.fnmode=2"
  ];


  services.mbpfan.enable = true;
  
   networking = {
     hostName = "zeta";     
     wireless.enable = true; 
     networkmanager.enable = false;
     wicd.enable = false;
     connman.enable = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
  i18n = {
        consoleFont = "ter-132n";
	consolePackages = [ pkgs.terminus_font ];
	consoleKeyMap = /home/aleph/DOTS/keymap/dvorak+.map.gz;
  };


   fonts = {
       # enableFontDir = true;
           # enableGhostscriptFonts = true;
	       fonts = with pkgs; [
	       	              	cm_unicode
				xits-math
				hack-font
				dejavu_fonts
				source-code-pro
				noto-fonts
				noto-fonts-cjk
				emojione
				];
	fontconfig = { 
			dpi = 227;
			defaultFonts.monospace = [ "Hack Regular" ];
			};
				};
      
      environment.systemPackages = with pkgs; [

	sudo

	#monitors	
	htop
	
        #zsh
	zsh
	oh-my-zsh
	nix-zsh-completions

	#fish
	fish

	#fonts
	terminus_font

	#sysutils
	ansible
	wget
	silver-searcher
	manpages
	autojump
	fzf
	shared_mime_info
	mc
	udevil

	#sync
	syncthing

	#networking
	iptables
	nmap
	tcpdump
	dhcp
	cmst        

	#audio
	alsaUtils
	alsa-firmware
	
	#video
	ffmpeg
	vlc
	
	#editors
	vim
	emacs
	
        #terminals
	st
	rxvt_unicode-with-plugins
	tmux

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
	
	#xorg
	xlibs.xmessage
	xlibs.xev
	xlibs.xmodmap
	xorg.xbacklight
	xbindkeys
	xfontsel
	xclip
	unclutter
	slock
	xautolock

	#wayland

	wayland
	xwayland
	libinput
	weston

	#haskell
	haskellPackages.ghc
	haskellPackages.hlint
	haskellPackages.stylish-haskell
	haskellPackages.hindent
	stack

	#rust

	rustc

	#python

	pythonFull
	python3Full
	python35Packages.setuptools
	python35Packages.ipython
	python35Packages.jupyter 

	#xmonad
	dmenu
	compton
	rofi
	haskellPackages.xmonad
	haskellPackages.xmobar

	#sway
	sway
	#gnupg
	gnupg1

	#config management
	stow

	#budgeting
	haskellPackages.hledger
	haskellPackages.hledger-web

	#www
	w3m
	chromium
	firefox
	qutebrowser
	torbrowser

	#docs
	libreoffice
	gimp
	inkscape
	krita
	zathura
	poppler_utils
	calibre
	evince

	#latex
	auctex
        (texlive.combine {
          inherit (texlive)
            collection-basic
            metafont
            xits
            collection-bibtexextra
            collection-binextra
            collection-context
            collection-formatsextra
            collection-fontutils
            collection-genericextra
            collection-genericrecommended
            collection-langcyrillic
            collection-langenglish
            collection-latex
            collection-latexextra
            collection-latexrecommended
            collection-mathextra
            collection-pictures
            collection-plainextra
            collection-pstricks
            collection-science
            collection-xetex;
	})

	#mail
	mu
	notmuch
	msmtp
	offlineimap

	#chat
	tdesktop
];

  # environment.etc.wicd = rec {
  #   target = "encryption/templates/eduroam";
  #   text = ''
  #       name = PEAP with MSCHAPv2
  # 	author = .
  # 	version = 1
  # 	require identity *Identity password *Password
  # 	-----
  # 	ctrl_interface=/var/run/wpa_supplicant
  # 	network={
  # 			ssid="$_ESSID"
  # 		        scan_ssid=$_SCAN
  # 			key_mgmt=WPA-EAP
  # 			eap=PEAP
  # 			phase2="auth=MSCHAPV2"
  # 			identity="$_IDENTITY"
  # 			password="$_PASSWORD"
  # 			}
  # 			'';
  #   };
  nixpkgs.overlays = [ (self: super: {
  st = super.st.override {
    patches = builtins.map super.fetchurl [
        { url = "http://st.suckless.org/patches/st-no_bold_colors-20160727-308bfbf.diff";
          sha256 = "2e8cdbeaaa79ed067ffcfdcf4c5f09fb5c8c984906cde97226d4dd219dda39dc";
          } 
        { url = "http://st.suckless.org/patches/st-solarized-both-20160727-308bfbf.diff";
          sha256 = "b7b25ba01b7ae87ec201ebbb1bf82742d5979788ecc6773a356eebe7d90a9703";
          }

	{ url = "http://st.suckless.org/patches/st-clipboard-20160727-308bfbf.diff";
	  sha256 = "1fgzppdzv28pmp88rnlsspx9axlkn2m20yw3b9w429cbd1kqw9fy";
	  }
      	];
      };
  }) ];

  

  security.wrappers.slock.source = "${pkgs.slock}/bin/slock";
  #udev
  services.udev.extraRules =
  ''
  ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chgrp video /sys/class/backlight/%k/brightness"
  ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/backlight/%k/brightness"
  ACTION=="add", SUBSYSTEM=="leds", RUN+="/run/current-system/sw/bin/chgrp input /sys/class/leds/%k/brightness"
  ACTION=="add", SUBSYSTEM=="leds", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/leds/%k/brightness"
  '';
  # journald
  services.journald.extraConfig = "SystemMaxUse=50M";

  # mlocate
  services.locate.enable = true;
  
  users.extraUsers = {
	aleph = {
		description = "Alexander Illarionov";
		uid = 1000;
		extraGroups = [
		"audio"
		"git"
		"networkmanager"
		"video"
		"input"
		"wheel"
		];
		isNormalUser = true;
		subUidRanges = [
		        { startUid = 100000; count = 65536; }
			    ];
                subGidRanges = [
		    { startGid = 100000; count = 65536; }
		        ];
        };
  };

  services.xserver.enable = true;
  # services.xserver.enable = false;
  services.xserver.layout = "dvorak,ru";
  services.xserver.xkbOptions = "ctrl:nocaps,grp:alt_space_toggle";
  #services.xserver.windowManager.xmonad.enable = false;
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.desktopManager.default = "none";
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  # services.xserver.windowManager.xmonad.enableContribAndExtras = false;
  services.xserver.displayManager = {
    auto = {
        enable = true;
  	user = "aleph";
    };
    xserverArgs = [ "-dpi 227" ];
    sessionCommands = with pkgs; lib.mkAfter ''
      xbindkeys &
      '';
  };
     
  services.xserver.libinput.enable = true;
  services.xserver.libinput.naturalScrolling = false;
  services.xserver.libinput.middleEmulation = true;
  services.xserver.libinput.tapping = true;

  #required for some gtk apps
  #services.gnome3.at-spi2-core.enable = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  programs.zsh.interactiveShellInit = ''
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    ZSH_THEME="robbyrussell"
    COMPLETION_WAITING_DOTS="true"

    # Customize your oh-my-zsh options here
    source $ZSH/oh-my-zsh.sh
    for config (/home/aleph/.zsh/*.zsh) source $config
  '';
  programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh      
}
