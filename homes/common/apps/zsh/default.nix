{pkgs, ...}: {
  imports = [
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      /*
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
          sha256 = "1m8yawj7skbjw0c5ym59r1y88klhjl6abvbwzy6b1xyx3vfb7qh7";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
          hash = "sha256-4rW2N+ankAH4sA6Sa5mr9IKsdAg7WTgrmyqJ2V1vygQ=";
        };
      }
      */
    ];

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    sessionVariables = {
      COLORTERM = "truecolor";
      TERM = "xterm-256color";
      EDITOR = "nvim";
    };

    shellAliases = rec {
      v = "nvim";
      ls = "lsd";
      lst = "${ls} --tree";
      tree = "${ls} --tree";
      la = "${ls} --all";
      k = "kubectl";
      shell = "nix-shell --run \"zsh\"";
      ":wq" = "exit";
      reload = "~/afs/setup.sh";

      # git
      ga="git add";
      gb="git branch -r";
      gc="source ~/.config/script/clone.sh";
      gcc="git clone";
      gd="git tag -d";
      gdff="git diff";
      gf="git fetch";
      gl="git log";
      gm="git commit -m";
      gmm="git commit -m \"commit pour demacia\"";
      gma="git commit --amend";
      gp="git push";
      gpf="git push --force-with-lease";
      gpll="git pull";
      gpt="git push --fol";
      gs="git status";
      gss="git switch";
      gt="git tag -ma";
      gtt="git push --tags";
      gur="source ~/.config/script/update_repo.sh";
      pci="pre-commit install";

      # make projects
      m="make";
      mt="make -j 10";
      tg="gcc git@gitlab.cri.epita.fr:lenny.chiadmi-delage/grrrrrrrrrrrrr.git && cd grrrrrrrrrrrrr && pci";
      lbc="libtoolize && ./bootstrap && ./configure";
      lbcm="libtoolize && ./bootstrap && ./configure && make -j 12";
      lbcg="libtoolize && ./bootstrap && ./configure CXXFLAGS=-g";
      lbcgm="libtoolize && ./bootstrap && ./configure CXXFLAGS=-g && make -j 12";

      # usefull for glouglou
      itar="mv ~/Downloads/*.tar . && tar -xf *.tar && rm *.tar";
      utar="source ~/.config/script/utar.sh";
      ka="source ~/.config/script/ka.sh";

      # term 
      c="clear";
      ccc="cd";
      cl="clear && ls -l";
      cli="clear && ls -la";
    };

    initExtra = ''
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)

      if [ $(($RANDOM%10)) -lt 1 ]; then
        ${pkgs.fortune}/bin/fortune | ${pkgs.cowsay}/bin/cowsay -r | ${pkgs.lolcat}/bin/lolcat
      fi
    '';
  };
}
