{ config, pkgs, expr, ... }:
let
  iconTheme = pkgs.breeze-icons.out;
  themeEnv = ''
    # QT: remove local user overrides (for determinism, causes hard to find bugs)
    rm -f ~/.config/Trolltech.conf
    # GTK3: remove local user overrides (for determinisim, causes hard to find bugs)
    rm -f ~/.config/gtk-3.0/settings.ini
    # GTK3: add breeze theme to search path for themes
    # (currently, we need to use gnome-breeze because the GTK3 version of kde5.breeze is broken)
    export XDG_DATA_DIRS="${pkgs.gnome-breeze}/share:$XDG_DATA_DIRS"
    # GTK3: add /etc/xdg/gtk-3.0 to search path for settings.ini
    # We use /etc/xdg/gtk-3.0/settings.ini to set the icon and theme name for GTK 3
    export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
    # GTK2 theme + icon theme
    export GTK2_RC_FILES=${pkgs.writeText "iconrc" ''gtk-icon-theme-name="breeze"''}:${pkgs.breeze-gtk}/share/themes/Breeze/gtk-2.0/gtkrc:$GTK2_RC_FILES
    # SVG loader for pixbuf (needed for GTK svg icon themes)
    export GDK_PIXBUF_MODULE_FILE=$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)
  '';

in
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
      xsel
      unclutter
      slock

      #terminal emulators
      sakura
      #xmonad
      dmenu
      compton
      rofi
      haskellPackages.xmobar

      # Qt theme
      breeze-qt5
      breeze-qt4

      # Icons (Main)
      iconTheme

      # Icons (Fallback)
      gnome3.adwaita-icon-theme
      hicolor_icon_theme
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
      source-han-sans-japanese
      source-han-sans-korean
      source-han-sans-simplified-chinese
      source-han-sans-traditional-chinese
      ubuntu_font_family
      noto-fonts-emoji
      hack-font
      opensans-ttf
      overpass
      oxygenfonts
    ];
    fontconfig = { dpi = 227;
           defaultFonts.monospace = [ "Hack Regular" ];
         };
  };

  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbVariant = "dvorak,";
    xkbOptions = "ctrl:nocaps,grp:win_space_toggle";
    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    desktopManager.default = "none";
    windowManager.xmonad.enableContribAndExtras = true;
    displayManager = {
      logToJournal = true;
      auto = {
        enable = true;
        user = "aleph";
      };
    xserverArgs = [ "-dpi 227" ];
    sessionCommands = with pkgs; lib.mkAfter ''
        xbindkeys &
        compton --benchmark -b --config /home/aleph/.config/compton.conf &
        unclutter -idle 2 &
        #xautolock -time 10 -locker slock
        '';
    };

    libinput.enable = true;
    libinput.naturalScrolling = false;
    libinput.middleEmulation = true;
    libinput.tapping = true;

    wacom.enable = true;
  };
  environment.extraInit = ''
  ${themeEnv}
  # these are the defaults, but some applications are buggy so we set them
  # here anyway
  export XDG_CONFIG_HOME=$HOME/.config
  export XDG_DATA_HOME=$HOME/.local/share
  export XDG_CACHE_HOME=$HOME/.cache
  '';

  # QT4/5 global theme
  environment.etc."xdg/Trolltech.conf" = {
  text = ''
    [Qt]
    style=Breeze
  '';
  mode = "444";
  };

  # GTK3 global theme (widget and icon theme)
  environment.etc."xdg/gtk-3.0/settings.ini" = {
  text = ''
    [Settings]
    gtk-icon-theme-name=breeze
    gtk-theme-name=Breeze-gtk
  '';
  mode = "444";
  };
    #slock

    # security.wrappers.slock.source = "${pkgs.slock}/bin/slock";
    # services.udev.extraRules =
    # ''
    # ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chgrp video /sys/class/backlight/%k/brightness"
    # ACTION=="add", SUBSYSTEM=="backlight", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/backlight/%k/brightness"
    # ACTION=="add", SUBSYSTEM=="leds", RUN+="/run/current-system/sw/bin/chgrp input /sys/class/leds/%k/brightness"
    # ACTION=="add", SUBSYSTEM=="leds", RUN+="/run/current-system/sw/bin/chmod g+w /sys/class/leds/%k/brightness"
    # '';
}
