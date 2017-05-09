{ config, pkgs, ... }:

{
  imports = [];          
  environment.systemPackages = with pkgs; [   
  	#python
                
	pythonFull
	python3Full
	python35Packages.setuptools
	python35Packages.pyperclip
	python35Packages.ipython
	python35Packages.jupyter 

  ];
}
