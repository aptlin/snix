{ config, pkgs, ... }:

{
  imports = [];          
  environment.systemPackages = with pkgs; [   
	#haskell
	haskellPackages.ghc
	haskellPackages.hlint
	haskellPackages.stylish-haskell
	haskellPackages.hindent
	stack
  ];
}
