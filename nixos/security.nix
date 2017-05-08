{ config, pkgs, ... }:

{
  # Encrypted DNS queries
  services.physlock.enable = true;
  services.dnscrypt-proxy = {
    enable = true;
    resolverName = "cs-cawest"; # in California
  };

  # Opportunisticly encrypt TCP traffic
  networking.tcpcrypt.enable = true;

  security = {
   # Can't be enabled in virtual guests
    rngd.enable = true; # feed hardware randomness to kernel when possible
    hideProcessInformation = true;
  };
}
