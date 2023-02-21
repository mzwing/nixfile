{
  description = "Mzwing's NixOS Flake";

  inputs = {
    # Nix Offical Mirror
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # NUR
    nur.url = "github:nix-community/NUR";
    # NixOS-cn
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, nixos-cn }: {
    # VMware NixOS
    nixosConfigurations."vmware" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nur.nixosModules.nur
        ./hosts/vmware/configuration.nix
        ({ ... }: {
          nix.settings = {
            substituters = [ "https://nixos-cn.cachix.org" ];
            trusted-public-keys = [ "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg=" ];
          };
          imports = [
            # 将nixos-cn flake提供的registry添加到全局registry列表中
            # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
            nixos-cn.nixosModules.nixos-cn-registries
            # 引入nixos-cn flake提供的NixOS模块
            nixos-cn.nixosModules.nixos-cn
          ];
        })
      ];
    };
    # WSL NixOS
    nixosConfigurations."wsl" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nur.nixosModules.nur
        ./hosts/wsl/configuration.nix
        ({ ... }: {
          nix.settings = {
            substituters = [ "https://nixos-cn.cachix.org" ];
            trusted-public-keys = [ "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg=" ];
          };
          imports = [
            # 将nixos-cn flake提供的registry添加到全局registry列表中
            # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
            nixos-cn.nixosModules.nixos-cn-registries
            # 引入nixos-cn flake提供的NixOS模块
            nixos-cn.nixosModules.nixos-cn
          ];
        })
      ];
    };
  };
}
