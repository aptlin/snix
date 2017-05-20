{ config, pkgs, ... }:

{
  imports = [
      ./audio.nix
      ./browsing.nix
      ./communication.nix
      ./haskell-packages.nix
      ./python-packages.nix
      ./image-editing-packages.nix
      ./hardware-configuration.nix
      ./mail.nix
      ./networking.nix
      ./security.nix
      ./system-packages.nix
      ./users.nix
      ./user-packages.nix
      ./x.nix
      ./sh.nix
  ];

  # Use the gummiboot efi boot loader.
  boot = {
    earlyVconsoleSetup = true;
    supportedFilesystems = ["exfat" "ntfs" "vfat"];    
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices = [
    {
     name = "root";
     device = "/dev/sda4";
     preLVM = true;
     }
    ];
    loader.grub.device = "/dev/sda";
    kernelModules = [ "coretemp" "applesmc" "hid_apple" "kvm-intel" ];
    cleanTmpDir = true;
    blacklistedKernelModules = [ "snd_pcsp" "hp_wmi"];
    extraModprobeConfig = ''
    options snd slots=snd-hda-intel
    options hid_apple fnmode=2
    '';
    kernelParams = [ "hid_apple.fnmode=2" ];
  };

  i18n = {
    # Use a bigger font for HiDPI displays
    consoleFont = "ter-132n";
    consolePackages = [ pkgs.terminus_font ];
    consoleKeyMap = /home/aleph/DOTS/keymap/dvorak+.map.gz;
    defaultLocale = "en_US.UTF-8";
  };

    system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable/";

  services = {
    mbpfan.enable = true;
    emacs.enable = true;
    redshift.enable = true;
    redshift.latitude = "55.75";
    redshift.longitude = "37.52";
    colord.enable = true;
    printing = {
      enable = true;
      gutenprint = true;
      drivers = [ pkgs.foo2zjs ];
      };    
  };
  
  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = false;
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  
  
  #services.chrony.enable = true;
  time.timeZone = "Europe/Moscow";

  nix = {
    maxJobs = 16;
    buildCores = 0;    
    useSandbox = true;
    gc = {
      automatic = true;
      dates = "weekly";
    };
    extraOptions = ''
      auto-optimise-store = true
    '';
  };
}
