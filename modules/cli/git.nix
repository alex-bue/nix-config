{ ... }:
{
  flake.modules.homeManager.git = {
    programs = {
      gh.enable = true;
      git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
          core.editor = "nvim";
          alias = {
            a = "add";
            aa = "add --all";
            au = "add --update";
            b = "branch";
            c = "commit -v";
            ca = "commit -v -a";
            cam = "commit -a -m";
            cmsg = "commit -m";
            cf = "config --list";
            co = "checkout";
            sw = "switch";
            d = "diff";
            f = "fetch";
            p = "push";
            pom = "push origin main";
            pl = "pull";
            r = "remote";
            rs = "remote show";
            st = "status";
            log = "log --oneline --decorate --graph";
            lol = "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
            lols = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
          };
        };
        ignores = [
          ".DS_Store"
          "Thumbs.db"
          "*.swp"
          "*.swo"
          "*~"
          ".project"
          ".idea/"
          ".vscode/"
          "node_modules/"
          "dist/"
          "build/"
          "target/"
          "*.log"
          "npm-debug.log*"
          "yarn-debug.log*"
          "yarn-error.log*"
          "debug.log"
          "debug/"
          ".env"
          ".env.*"
          "package-lock.json"
          "*.class"
          "*.jar"
          "*.war"
          "*.ear"
          "*.dll"
          "*.exe"
          "*.so"
          "*.bak"
          "*.tmp"
          "*.iml"
          "*.ipr"
          "*.iws"
          ".ipynb_checkpoints/"
        ];
      };
    };
  };
}
