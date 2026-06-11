{
  description = "macbook-air-m1";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-homebrew, darwin, nixpkgs, home-manager }: {
    darwinConfigurations."anuj-macbook" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = false;
            user = "anujpokhriyal";
            autoMigrate = true;
          };
        }
        
        ({ pkgs, ... }: {
          
          users.users.anujpokhriyal = {
            name = "anujpokhriyal";
            home = "/Users/anujpokhriyal";
          };

          system.primaryUser = "anujpokhriyal";

          environment.systemPackages = [
            pkgs.mas
          ];

          homebrew = {
            enable = true;
            onActivation.cleanup = "none";
            
            taps = [
              "kgarner7/feishin"
            ];

            masApps = {
              "Hand Mirror" = 1502839586;
            };

            casks = [
              "aerospace"
              "appcleaner"
              "blip"
              "feishin"
              "ghostty"
              "handbrake-app"
              "helium-browser"
              "iina"
              "imageoptim"
              "impactor"
              "keka"
              "localsend"
              "orbstack"
              "shottr"
              "signal"
              "tailscale-app"
              "telegram"
              "whatsapp"
              "zen"
              "zed"
            ];
          };

          system.defaults = {
            
            SoftwareUpdate = {
              AutomaticallyInstallMacOSUpdates = false;
            };

            loginwindow = {
              LoginwindowText = "Stay Away - Anuj Pokhriyal";
            };

            finder = {
              ShowStatusBar = true;
              ShowPathbar = true; 
              FXPreferredViewStyle = "Nlsv";
              AppleShowAllExtensions = true;
              AppleShowAllFiles = true;
              CreateDesktop = false;
              FXDefaultSearchScope = "SCcf";
              NewWindowTarget = "Home"; 
            };

            NSGlobalDomain = {
              ApplePressAndHoldEnabled = false; 
              InitialKeyRepeat = 15;
              KeyRepeat = 2; 
              "com.apple.trackpad.scaling" = 2.0;
              NSAutomaticCapitalizationEnabled = false;
              NSAutomaticSpellingCorrectionEnabled = false;
            };

            trackpad = {
              Clicking = true;
            };

            screencapture.location = "~/Pictures/Screenshots";
            screencapture.type = "jpg";

            dock = {
              autohide = true;
              tilesize = 57; 
              magnification = true;
              largesize = 67; 
              mineffect = "scale";
              minimize-to-application = true;
              launchanim = true;
              show-process-indicators = true;
              show-recents = false;
              
              persistent-apps = [
                "/Applications/Ghostty.app"
                "/Applications/Helium.app"
                "/Applications/Zen.app"
                "/Applications/Zed.app"
                "/Users/anujpokhriyal/Applications/Immich.app"
                "/Applications/Feishin.app"
                "/Applications/Signal.app"
                "/Applications/WhatsApp.app"
                "/Applications/Telegram.app"
                "/System/Applications/Notes.app"
                "/System/Applications/System Settings.app"
              ];
            };


            CustomUserPreferences = {
              "com.apple.Siri" = {
                StatusMenuVisible = false;
                UserHasDeclinedEnable = true;
              };
              "com.apple.desktopservices" = {
                DSDontWriteNetworkStores = true;
                DSDontWriteUSBStores = true;
              };
              "com.apple.TimeMachine" = {
                DoNotOfferNewDisksForBackup = true;
              };
            };
          };


          nix.settings.experimental-features = "nix-command flakes";
          system.stateVersion = 5;
        })

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.users.anujpokhriyal = { pkgs, ... }: {
            home.stateVersion = "24.05"; 

            home.packages = with pkgs; [
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
          };
        }
      ];
    };
  };
}
