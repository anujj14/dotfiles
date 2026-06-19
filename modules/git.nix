{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Anuj Pokhriyal";
        email = "77380156+anujj14@users.noreply.github.com";
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519_signing.pub";
    };
    ignores = [
      ".DS_Store"
      "**/.DS_Store"
    ];
  };
}
