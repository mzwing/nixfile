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
      # 强制 nixos-cn 和该 flake 使用相同版本的 nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # snowflakeos software
    nix-software-center.url = "github:vlinkz/nix-software-center";
    nixos-conf-editor.url = "github:vlinkz/nixos-conf-editor";
    snow.url = "github:snowflakelinux/snow";
    # nix-alien
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = { self, nixpkgs, nur, nixos-cn, nix-software-center, nixos-conf-editor, snow, nix-alien }:
    let
      system = "x86_64-linux";
    in
    {
      # VMware NixOS
      nixosConfigurations."vmware" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self system; };
        modules = [
          ({ self, system, ... }: {
            environment.systemPackages = with self.inputs; [
              nix-software-center.packages.${system}.nix-software-center
              nix-alien.packages.${system}.nix-alien
              nixos-conf-editor.packages.${system}.nixos-conf-editor
              snow.packages.${system}.snow
              # rest of your packages
            ];
          })
          nur.nixosModules.nur
          # 将nixos-cn flake提供的registry添加到全局registry列表中
          # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
          nixos-cn.nixosModules.nixos-cn-registries
          # 引入nixos-cn flake提供的NixOS模块
          nixos-cn.nixosModules.nixos-cn
          ./hosts/vmware/configuration.nix
        ];
      };
      # WSL NixOS
      nixosConfigurations."wsl" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nur.nixosModules.nur
          # 将nixos-cn flake提供的registry添加到全局registry列表中
          # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
          nixos-cn.nixosModules.nixos-cn-registries
          # 引入nixos-cn flake提供的NixOS模块
          nixos-cn.nixosModules.nixos-cn
          ./hosts/wsl/configuration.nix
        ];
      };
      # ddp-us openvz
      nixosConfigurations."ddp-us" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nur.nixosModules.nur
          # 将nixos-cn flake提供的registry添加到全局registry列表中
          # 可在`nixos-rebuild switch`之后通过`nix registry list`查看
          nixos-cn.nixosModules.nixos-cn-registries
          # 引入nixos-cn flake提供的NixOS模块
          nixos-cn.nixosModules.nixos-cn
          ./hosts/ddp-us/configuration.nix
        ];
      };
    };
}
