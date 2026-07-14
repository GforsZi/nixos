{ ... }:

{
  programs.git = {
    enable = true;
    userName = "GforsZi";
    userEmail = "givaldigumelarsetiawan@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
