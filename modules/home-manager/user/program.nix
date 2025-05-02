{
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "SpitfireGG";
      userEmail = "raambasnet02@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };

    bash.enable = true;
    direnv.enable = true;
    fzf.enable = true;
  };

}
