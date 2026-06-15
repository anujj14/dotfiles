{ pkgs, ... }: {
  
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    android-tools
    btop
    cmatrix
    eza
    fastfetch
    fzf
    neovim
    pass
    tmux
    tree
    yazi
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.git = {
    enable = true;
    settings = {
    user = {
      name = "Your Name";
      email = "your.email@example.com";
    };
  };
    ignores = [
      ".DS_Store"
      "**/.DS_Store"
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "--height 40%" "--border" ];
  };
  
  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ./dotfiles/ghostty/config;
  xdg.configFile."aerospace".source = ./dotfiles/aerospace;
}
