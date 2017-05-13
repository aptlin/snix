{ config, pkgs, ... }:

{
  imports = [];          
  environment.systemPackages = with pkgs; [   
    firefox
    w3m-nox
    torbrowser
  ];
}
