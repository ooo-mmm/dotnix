{
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "vg";
    userEmail = "vaibhav7garg@gmail.com";
    extraConfig = {
      core = {
        askPass = "";
      };
    };
  };
}
