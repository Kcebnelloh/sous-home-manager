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
    pkgs.ripgrep

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

    aliases = {
        s = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        df = "diff";
        lg = "log --oneline --graph --decorate --all";
    };

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
            
    extraLuaConfig = ''
        -- Write lua code here

        -- or inter polate files like this:

        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/mappings.lua}

    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = tokyonight-nvim;
        config = "colorscheme tokyonight";
      }

      {
        plugin = vim-fugitive;
        config = toLuaFile ./nvim/plugin/fugitive.lua;
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

  };
  
  home.stateVersion = "23.05"; # Please read the comment before changing.
  targets.genericLinux.enable = true;

}
