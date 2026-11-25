# BudgieOS X 1.0

**BudgieOS X** is an independent BudgieOS-family operating-system project. Its planned desktop has a macOS-inspired visual direction with original BudgieOS branding; it does not use Apple's proprietary system files or assets.

## Current architecture

- **Boot:** GRUB Multiboot2, BIOS/Legacy-compatible x86 boot path
- **Kernel:** NASM Assembly, 32-bit protected-mode starter
- **Linker:** `linker.ld`
- **Desktop concept:** `index.html` (separate browser-based UI preview)

## Build a bootable ISO

On Debian/Ubuntu/Kali Linux, install the tools:

```bash
sudo apt update
sudo apt install nasm binutils grub-pc-bin grub-common xorriso mtools
```

Build:

```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

The output is:

```
build/BudgieOS-X-1.0.iso
```

Test the ISO in a virtual machine such as QEMU or VirtualBox. Do not write it to a real disk; this is an early development build.

## GitHub Actions

Every push to `main`, or a manual run from the **Actions** tab, builds the ISO. Download the `BudgieOS-X-1.0-ISO` artifact after the workflow succeeds.

## Important project status

This is an **early bootable Assembly kernel starter**, not a finished desktop operating system. The kernel currently writes a boot message to VGA text memory. It does not yet have a graphical desktop, drivers, USB, Wi-Fi, audio, multitasking, user accounts, a filesystem, or an installer. The browser desktop in `index.html` is only a visual concept and is not connected to the kernel yet.

## Source layout

- `src/boot.asm` — Multiboot2 entry point and stack
- `src/kernel.asm` — minimal Assembly kernel
- `linker.ld` — kernel memory layout
- `grub/grub.cfg` — boot menu
- `scripts/build.sh` — ISO build script
- `.github/workflows/build-iso.yml` — CI build

BudgieOS X is an independent project and is not affiliated with Apple.
