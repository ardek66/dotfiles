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
      extensions = with firefox-addons.packages.${pkgs.system}; [ plasma-integration ublock-origin tree-style-tab ];
    };

    lf.enable = true;
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
