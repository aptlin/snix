{ config, pkgs, ... }:

{
  imports = [];          
  environment.systemPackages = with pkgs; [   
    gimp
    inkscape
  ];
}
