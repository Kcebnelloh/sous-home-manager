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

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
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
