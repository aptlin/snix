{ config, pkgs, ... }:

{
  imports = [];

  environment.systemPackages = with pkgs; [
      compton
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

      #xmonad
      dmenu
      compton
      rofi
      haskellPackages.xmonad
      haskellPackages.xmobar
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      # fira-code
      noto-fonts-emoji
      hack-font
      #ubuntu-font-family
      opensans-ttf
      overpass
      oxygenfonts
      helvetica-neue-lt-std
    ];
    fontconfig = { dpi = 227;
		   defaultFonts.monospace = [ "Hack Regular" ];
		 };
  };

  services.xserver = {
    enable = true;
    # enable = false;
    layout = "dvorak,ru";
    xkbOptions = "ctrl:nocaps,grp:alt_space_toggle";
    #windowManager.xmonad.enable = false;
    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    desktopManager.default = "none";
    windowManager.xmonad.enableContribAndExtras = true;
    # windowManager.xmonad.enableContribAndExtras = false;
    displayManager = {
      auto = {
        enable = true;
    	user = "aleph";
      };
    xserverArgs = [ "-dpi 227" ];
    sessionCommands = with pkgs; lib.mkAfter ''
        xbindkeys &
	compton -b &
	unclutter -idle 2
	xautolock -time 10 -locker slock
        '';
    };
       
    libinput.enable = true;
    libinput.naturalScrolling = false;
    libinput.middleEmulation = true;
    libinput.tapping = true;
  
                                   
    # TODO: get rid of ~/.xmodmap and see if this works
    xkbOptions = "ctrl:nocaps";

    #slock

    security.wrappers.slock.source = "${pkgs.slock}/bin/slock";
    services.udev.extraRules =
    ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="/run/current-system/sw/bin/chgrp input /sys/class/leds/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/leds/%k/brightness"
    '';
  };
}