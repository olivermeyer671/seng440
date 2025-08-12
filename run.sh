#!/bin/bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
ROOT_DIR=$(cd "$SCRIPT_DIR" && pwd)

KERNEL="$ROOT_DIR/vm/vmlinuz-4.18.16-300.fc29.armv7hl"
INITRAMFS="$ROOT_DIR/vm/initramfs-4.18.16-300.fc29.armv7hl.img"
DISK="$ROOT_DIR/vm/Fedora-Minimal-armhfp-29-1.2-sda.qcow2"

qemu-system-arm \
  -M virt \
  -cpu cortex-a15 \
  -m 512M \
  -kernel "$KERNEL" \
  -initrd "$INITRAMFS" \
  -drive if=none,file="$DISK",id=hd0,format=qcow2 \
  -device virtio-blk-device,drive=hd0 \
  -append "console=ttyAMA0 root=/dev/vda3 rw loglevel=3" \
  -netdev user,id=net0,hostfwd=tcp::2222-:22,dns=1.1.1.1 \
  -device virtio-net-device,netdev=net0 \
  -fsdev local,id=fsdev0,path=$ROOT_DIR/project,security_model=none \
  -device virtio-9p-device,fsdev=fsdev0,mount_tag=shared_project \
  -nographic
