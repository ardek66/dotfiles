{ config, pkgs, lan-mouse, firefox-addons, ... }:

{

  imports = [lan-mouse.homeManagerModules.default];

  home.username = "idf";
  home.homeDirectory = "/home/idf";
  home.stateVersion = "24.11";
  home.packages = [ 
    pkgs.wezterm 
    pkgs.keepassxc 
    pkgs.telegram-desktop
    pkgs.discord
    pkgs.meld
    pkgs.nerd-fonts.geist-mono
    pkgs.klassy-qt6
  ];

  home.file = {
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/idf/dotfiles/tmux/.tmux.conf";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/idf/dotfiles/nvim/.config/nvim";
    ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "/home/idf/dotfiles/wezterm/.config/wezterm";
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    neovim.enable = true;
    neovim.withNodeJs = true;
    neovim.extraLuaPackages = luajitPackages: [ luajitPackages.fennel ];
    neovim.extraPackages = [ pkgs.gcc pkgs.unzip pkgs.go pkgs.cargo ];

    floorp.enable = true;
    floorp.profiles.hm-profile = {
      isDefault = true;
      extensions.packages = with firefox-addons.packages.${pkgs.system}; [ plasma-integration ublock-origin tree-style-tab ];
    };

    xplr.enable = true;
    xplr.plugins = {
      fennel = "${pkgs.fennel}/share/lua/5.2/?.lua";

      dysh-style = pkgs.fetchFromGitHub {
        owner = "dy-sh";
        repo = "dysh-style.xplr";
        rev = "12dab25f9410e1c67f09f60c0af030ea5210ea0d";
        sha256 = "sha256-Neh9Rbr6kFqEFQsdOQUutqZeVTJ5ELP7DzY7f4GXyZk=";
      };

      web-devicons = pkgs.fetchFromGitLab {
        owner = "hartan";
        repo = "web-devicons.xplr";
        rev = "9183a0cc146a29e4f25749463d293be920c6691e";
        sha256 = "sha256-qzibWL5tOWmXAMaxhUO5jFUdD6k7wsG3Mdhz/elngKQ=";
      };
    };

    xplr.extraConfig = ''
      require("dysh-style").setup()
      require("web-devicons").setup()
      require("fennel").install()
    '';

    mpv.enable = true;
    lan-mouse.enable = true;
    keychain.enable = true;
    keychain.enableFishIntegration = true;
    tmux.enable = true;
    git.enable = true;
    git.userEmail = "ardek66@tutanota.com";
    git.userName = "idf";
    lazygit.enable = true;


    fish.enable = true;
    bash.enable = true;
    bash.initExtra = "[ -x ${pkgs.fish}/bin/fish ] && SHELL=${pkgs.fish}/bin/fish exec fish";
  };

}
