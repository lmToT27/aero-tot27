{ config, pkgs, ... }:

{
    home.username = "lmtot27";
    home.homeDirectory = "/home/lmtot27";
    home.stateVersion = "26.05";
    home.enableNixpkgsReleaseCheck = false;

    # ============================================
    # SYSTEM PACKAGES
    # ============================================ 
    home.packages = with pkgs; [
        # UI & Terminal utils
        kitty waybar rofi swaybg swaynotificationcenter
        grim slurp wl-clipboard wlr-randr

        # Python packages
        (python3.withPackages (ps: with ps; [
            numpy pandas scikit-learn torch torchvision opencv4 ortools matplotlib
        ]))
        kaggle visidata ruff pyright

        # Compilers & Runtimes
        gcc clang-tools nodejs pnpm jdk21 maven

        # Applications
        godot_4
        obsidian
        (brave.override {
            commandLineArgs = [
                "--enable-features=UseOzonePlatform"
                "--ozone-platform=wayland"
                "--enable-gpu-rasterization"
                "--enable-zero-copy"
                "--process-per-site"
            ];
        })
    ];


    # ============================================
    # SHELL
    # ============================================ 
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            cls = "clear";
            rebuild-os = "sudo nixos-rebuild switch --flake ~/aero-tot27#nixos";
        };
    };


    # ============================================
    # TERMINAL NAVIGATION & CLI TOOLS
    # ============================================ 
    programs = {
        fzf = {
            enable = true;
            enableZshIntegration = true;
            enableNushellIntegration = false;
        };

        zoxide = {
            enable = true;
            enableZshIntegration = true;
            options = [ "--cmd cd "];
        };
        
        eza = {
            enable = true;
            enableZshIntegration = true;
            icons = "auto";
        };

        bat.enable = true;
    };

    # ============================================
    # GIT
    # ============================================ 
    programs.git = {
        enable = true;
        settings = {
            user.name = "lmToT27";
            user.email = "168084827+lmToT27@user.noreply.github.com";
        };
    };

    
    # ============================================
    # SYMLINK
    # ============================================ 
    home.file = {
        ".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink 
          "${config.home.homeDirectory}/aero-tot27/dotfiles/niri/config.kdl";
    };
}
