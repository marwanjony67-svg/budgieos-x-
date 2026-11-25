#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"
ISO_ROOT="$BUILD/iso"

for tool in nasm ld grub-file grub-mkrescue; do
  command -v "$tool" >/dev/null 2>&1 || {
    echo "Missing build tool: $tool" >&2
    exit 1
  }
done

mkdir -p "$BUILD" "$ISO_ROOT/boot/grub"
nasm -f elf32 "$ROOT/src/boot.asm" -o "$BUILD/boot.o"
nasm -f elf32 "$ROOT/src/kernel.asm" -o "$BUILD/kernel.o"
ld -m elf_i386 -T "$ROOT/linker.ld" -nostdlib \
  "$BUILD/boot.o" "$BUILD/kernel.o" -o "$BUILD/budgieosx.elf"

grub-file --is-x86-multiboot2 "$BUILD/budgieosx.elf"
cp "$BUILD/budgieosx.elf" "$ISO_ROOT/boot/budgieosx.elf"
cp "$ROOT/grub/grub.cfg" "$ISO_ROOT/boot/grub/grub.cfg"
grub-mkrescue -o "$BUILD/BudgieOS-X-1.0.iso" "$ISO_ROOT"

echo "Build complete: $BUILD/BudgieOS-X-1.0.iso"
