{ config, pkgs, ... }:

{
  imports = [
      ./audio.nix
      ./hardware-configuration.nix
      ./mail.nix
      ./networking.nix
      ./packages.nix
      ./security.nix
      ./ssh.nix
      ./steam.nix
      ./systemd.nix
      ./users.nix
      ./x.nix
      ./zsh.nix
  ];

  # Use the gummiboot efi boot loader.
  boot = {
    supportedFilesystems = ["exfat" "btrfs" "ntfs" "vfat"];
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

  services = {
    mbpfan.enable = true;
    emacs.enable = true;
  };
  
  hardware = {
    bluetooth.enable = false;
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  
  
  #services.chrony.enable = true;
  time.timeZone = "USA/Los_Angeles";

  nix = {
    maxJobs = 4;
    buildCores = 4;
    gc.automatic = true;
    useSandbox = true;
    # Use a local clone of nixpkgs at /etc/nixpkgs
    #nixPath = [ "nixos-config=/etc/nixos/configuration.nix" "/home/siddharthist/code" ];
  };
}
