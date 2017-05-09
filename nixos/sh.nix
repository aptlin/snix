{ config, pkgs, ... }:

{
  imports = [];

  environment = {

    systemPackages = with pkgs; [
      direnv # automatically invoke/revoke a nix-shell
      fasd
      fish
    ];

    shellAliases = {
      amiconnected = "while true; do if curl google.com &> /dev/null; then echo \"$(date +%H:%M) ~~~GOOD~~~\"; else echo \"$(date +%H:%M) ---BAD---\"; fi; sleep 5; done";
      docker-gc = "sudo docker ps -a -q -f status=exited | xargs --no-run-if-empty sudo docker rm";
      docker-gc-images = "docker images -q | xargs --no-run-if-empty docker rmi || true";
      sys = "sudo systemctl";
      sysu = "systemctl --user";
      test-ssh = "ssh -T git@github.com";
      ls1 = "ls -1";
      reload = "source /etc/zshrc";
      # TODO: imagemagick
      # Convenience
      # TODO: nix function
      # work-algebra = ''
      #   cd ~/Dropbox/langston/tex/math332; \
      #     zathura dummit.djvu & disown; \
      #     zathura notes/tex/1-ring-theory.pdf & disown; \
      #     ${pkgs.emacs}/bin/emacsclient --create-frame & disown; \
      #     sleep 1; exit 0
      # '';

      # Git
      ga = "git add";
      gb = "git branch";
      gc = "git checkout";
      gcl = "git clone --depth 20";
      gcm = "git commit -m";
      gd = "git diff";
      gdc = "git diff --cached";
      gdm = "git diff master";
      gf = "git fetch";
      gm = "git merge";
      gp = "git checkout master && git pull && git checkout -";
      gpo = "git push origin";
      gr = "git reset";
      grhm = "git reset --hard origin/master";
      gri = "git rebase -i";
      gs = "git status";
      bud="ec $LEDGER_FILE";
      cp="cp -r";
      ec="emacsclient -c --alternate-editor=";
      sec="emacsclient -c --alternate-editor=";
      ce="emacsclient -nw --alternate-editor=";
      ecc="cd ~/.emacs.d && ec ~/.emacs.d/init.el";
      eco="ec ~/.emacs.d/lisp/init-org.el";
      emac="ec ~/.emacs.d/init.el";
      gdot="pushd ~/.zsh/ && ./gdot && popd";
      gt="git add .; git commit -am '$(date +%y%m%d)'; git push -u origin master";
      ll="ls -lahf --color=auto";
      lsl="ls -lhf --color=auto";
      lss="ls -hf --color=auto";
      mixer="alsamixer";
      mou="devmon -a";
      psef="ps -ef";
      pref="ec ~/ORG/pref.org";
      rbt="sudo reboot";
      rmrf="rm -rf";
      road="ec ~/ORG/road.org";
      scp="scp -r";
      sch="ec ~/ORG/schedule.org";
      fixtime="sudo ntpdate pool.ntp.org; sudo hwclock --systohc";
      sude="sudo -e";
      tempwatch="while :; do sensors; sleep 1 && clear; done;";
      term="urxvtc -hold -e "; #used for run menu;
      unm="devmon -u";
      up="cd ../";
      upd="sudo nixos-rebuild switch --upgrade";
      updk="sudo mkinitcpio -p linux-libre";
      xclip="xclip -selection c";
      xsel="xsel -b";
      za="zathura --fork";
      zz="quit";

      # Notes
      arb="ec $BLOG_DIR/stories/arbeit.org ";
      snts="pushd ~/DOTS/zsh/.scripts/;./notes;popd";
      pnts="pushd ~/DOTS/zsh/.scripts/;./scans;popd";
      spnts="snts; pnts";
      nte="ec ~/WERKE/sdll.github.io/stories/notes.org";
      gnts="gdir ORG/NOTES";
      lk="ec /home/aleph/WERKE/sdll.github.io/pages/trove.org";
             # Blog;
      dn="deploy 'added notes'";
      nbw="workon nikola; nikola auto; deactivate";
      nbb="nikola build";
      ng="workon nikola; cd $BLOG_DIR; nikola github_deploy -m 'Yet another weblog update.'; deactivate";
      nd="workon nikola; nikola github_deploy -m 'umu update'; deactivate";
      nna="cd $BLOG_DIR; workon nikola; nikola new_post -e -f orgmode; deactivate";
      nnp="cd $BLOG_DIR; workon nikola; nikola new_post -e -p -f orgmode; deactivate";
      na="workon nikola; nikola new_post -e -f orgmode; deactivate";
      np="workon nikola; nikola new_post -e -p -f orgmode; deactivate";
      nik="workon nikola";
      nli="ec $BLOG_DIR/stories/links_math.org";
      sw="stack build; stack exec site rebuild; stack exec site watch";

      # Haskell
      sb="stack build;";

      # Org
      tupd="~/DOTS/zsh/.scripts/telegram";
      sc="scrot '%Y-%m-%d_$wx$h.png' -s -e 'mv $f ~/TMP/SCR/'";
      le="~/DOTS/zsh/.scripts/letters";
      lat="latexmk -pvc -pdf";
      tse="ec ~/TMP/PROG/M/";
      i3c="ec ~/DOTS/i3/.config/i3/config";
      sty="ec $HOME/texmf/tex/latex/local/sdll.sty";
      sfs="ec $BLOG_DIR/files/assets/demos/sfscore.tsv";
      aug="ec $BLOG_DIR/stories/agenda.org";
      mik="ec $BLOG_DIR/stories/mikveh.org";
      hmu="pkill -2 -u $UID mu # send SIGINT";
      we="curl wttr.in";

      ni="ec ~/DOTS/nixos/configuration.nix; sudo nixos-rebuild switch";
      nb="sudo nixos-rebuild switch";


      zac="ec ~/.config/zathura/zathurarc";
  
      # umu
      
      uag="ec $UMU_DIR/stories/agenda.org";
      ut="ec $UMU_DIR/stories/utumu.org";
      uma="ec $DOTS/mutt/.mutt/es";

      #eless
      eless="/home/aleph/PROG/eless/eless";

    };

    variables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      PATH = "$PATH:$HOME/.scripts";
      EDITOR = "emacs";
      };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #enableSyntaxHighlighting = true;

    # custom prompt: "code > "
    promptInit = ''
      autoload -U promptinit && promptinit
      autoload -U colors && colors
      PROMPT="%{$fg_bold[0]%}%2~%  >%{$reset_color%} "
    '';

    # zshrc
    interactiveShellInit = ''
      # See NixOS/nix#1056
      if [ -n "$IN_NIX_SHELL" ]; then
        export TERMINFO=/run/current-system/sw/share/terminfo

        # Reload terminfo
        real_TERM=$TERM; TERM=xterm; TERM=$real_TERM; unset real_TERM
      fi

      eval "$(fasd --init posix-alias zsh-hook)"
      if [[ -z $IN_NIX_SHELL ]]; then
        eval "$(direnv hook zsh)"
      fi
      source_all() {[[ -d $1 ]] && for f in $1/*.zsh; do source "$f"; done; unset f;}
      source_all $HOME/.zsh
    '';
  };

  # programs.bash = {
  #   interactiveShellInit = ''
  #     if [[ -z $IN_NIX_SHELL ]]; then
  #       eval "$(direnv hook bash)"
  #     fi
  #     zsh; exit
  #   '';
  # };
}
