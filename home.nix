{ config, pkgs, ... }:

{
  home.username = "hollenbe";
  home.homeDirectory = "/home/hollenbe";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes"];
  };

  home.packages = [

    pkgs.hello # friendly hello message when used in terminal

  ];

  home.file = {
  };
  home.sessionVariables = {
     EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    userEmail = "hollenbeckfl@tutanota.com";
    userName = "Finn Hollenbeck";
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
        {
            plugin = gruvbox-nvim;
            config = "colorscheme gruvbox";
        }
    ];

    extraLuaConfig = ''
        -- Write lua code here

        -- or inter polate files like this:

        ${builtins.readFile ./nvim/options.lua}

    '';
  };
  
  home.stateVersion = "23.05"; # Please read the comment before changing.
  targets.genericLinux.enable = true;

}
