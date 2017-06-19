{ config, pkgs, ... }:

{

  # services.physlock.enable = true;

  # services.dnscrypt-proxy = {
  #   enable = true;
  #   resolverName = "cs-ru";
  #   localPort = 4343;
  #   };
  # services.unbound = {
  #   enable = true;
  #   forwardAddresses = [ "127.0.0.1@4343" ];
  #   };

  # Opportunisticly encrypt TCP traffic
  # networking.tcpcrypt.enable = true;

  security = {
    rngd.enable = true; # feed hardware randomness to kernel when possible
    hideProcessInformation = true;
    wrappers = { slock = { source = "${pkgs.slock}/bin/slock"; }; };
  };
}
