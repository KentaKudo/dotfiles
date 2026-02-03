{ config, pkgs, inputs, ... }:

{
    home.username = "kentakudo";
    home.homeDirectory = "/Users/kentakudo";

    home.packages = with pkgs; [
        direnv
        gh
        ghq
        go
        jq
        peco
        ripgrep
        volta
    ];

    home.sessionVariables = {
        GOPATH = "${config.home.homeDirectory}/go";
        VOLTA_HOME = "${config.home.homeDirectory}/.volta";
    };

    home.sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
        "$GOPATH/bin"
        "${config.home.homeDirectory}/.volta/bin"
    ];

    programs.home-manager.enable = true;

    programs.zsh = {
        enable = true;

        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [ "git" ];
        };

        shellAliases = {
            hms = "home-manager switch --flake ${config.home.homeDirectory}/dotfiles";
            # ghq + peco https://gfx.hatenablog.com/entry/2017/07/26/104634
            g = "cd $(ghq root)/$(ghq list | peco)";
            v = "code $(ghq root)/$(ghq list | peco)";
            # b = "hub browse $(ghq list | peco | cut -d \"/\" -f 2,3)";
            # ssh + peco https://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
            # s = "ssh $(grep -iE \"^host[[:space:]]+[^*]\" ~/.ssh/config|peco|awk \"{print \\$2}\")";
        };

        initContent = ''
            # Load per-machine overrides if present
            if [ -f "$HOME/.zshrc.local" ]; then
                source "$HOME/.zshrc.local"
            fi
        '';
    };

    programs.tmux = {
        enable = true;

        extraConfig = builtins.readFile "${inputs.oh-my-tmux}/.tmux.conf";
    };
    home.file.".config/tmux/tmux.conf.local".text = (builtins.readFile "${inputs.oh-my-tmux}/.tmux.conf.local") + ''
        set -g mouse on
        set -g history-limit 100000
        set -s copy-command 'pbcopy'
    '';

    programs.git = {
        enable = true;

        settings = {
            user.name = "KentaKudo";
            user.email = "yd37574@gmail.com";
            push.autoSetupRemote = true;
            pull.rebase = true;
        };
    };

    home.stateVersion = "25.11";
}
