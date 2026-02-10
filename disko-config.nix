{
  disko.devices.disk.main = {
    device = "/dev/nvme0n1";  # CHANGE THIS after checking lsblk
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "cryptroot";
            settings.allowDiscards = true;
            passwordFile = "/tmp/disk-password";
            content = {
              type = "btrfs";
              extraArgs = [ "-L" "nixos" ];
              subvolumes = {
                "@"          = { mountpoint = "/";          mountOptions = [ "compress=zstd" "noatime" ]; };
                "@home"      = { mountpoint = "/home";      mountOptions = [ "compress=zstd" "noatime" ]; };
                "@nix"       = { mountpoint = "/nix";       mountOptions = [ "compress=zstd" "noatime" ]; };
                "@log"       = { mountpoint = "/var/log";   mountOptions = [ "compress=zstd" "noatime" ]; };
                "@snapshots" = { mountpoint = "/.snapshots"; mountOptions = [ "compress=zstd" "noatime" ]; };
              };
            };
          };
        };
      };
    };
  };
}
