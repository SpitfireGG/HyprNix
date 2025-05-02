{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-dark";
    };
    iconTheme = {
      package = pkgs.reversal-icon-theme;
      name = "Reversal-dark";
    };
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

}
