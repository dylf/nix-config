{ config, pkgs, nvimConfig, ... }:

{
  home.username = "dylf";
  home.homeDirectory = "/home/dylf";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SpaceMono" ]; })
    clang
    go
    lazygit
    nodejs
    ripgrep
    unzip
  ];

  home.file = { 
    "${config.xdg.configHome}/nvim".source = "${nvimConfig}/";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "dylf";
    userEmail = "10430358+dylf@users.noreply.github.com";
    aliases = {
      cane = "commit --amend --no-edit";
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      { name = "z"; src = pkgs.fishPlugins.z.src; }
    ];
  };

  # TODO: Treesitter compilation issues
  programs.neovim.plugins = with pkgs; [
    vimPlugins.nvim-treesitter
    vimPlugins.nvim-treesitter.withAllGrammars
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = waybar

    monitor=eDP-1, 1920x1080, 0x0, 1

    $mod = SUPER

    bind = $mod, B, exec, firefox
    bind = $mod, T, exec, wezterm
    bind = $mod, Q, killactive
    bind = $mod, ;, exit,
    bind = $mod, G, togglefloating,

    # Move focus
    bind = $mod, left, movefocus, l
    bind = $mod, down, movefocus, d
    bind = $mod, up, movefocus, u
    bind = $mod, right, movefocus, r
    bind = $mod, h, movefocus, l
    bind = $mod, j, movefocus, d
    bind = $mod, k, movefocus, u
    bind = $mod, l, movefocus, r

    bindr = SUPER, SUPER_L, exec, rofi -show drun -show-icons

    input {
      kb_options=caps:swapescape
      natural_scroll = true
    }
  '';

}
