# YehanOS 🖥️

**YehanOS** is a custom, lightweight x86 operating system project built to explore low-level system architecture, boot processes, and direct hardware interaction.

This project focuses on understanding how software communicates with hardware beneath modern operating system abstractions.

## 🚀 Features

- **Custom x86 Kernel**  
  A minimal kernel developed using x86 Assembly.

- **MikeOS Bootloader Integration**  
  Uses the open-source **MikeOS bootloader** with a FAT12 floppy disk image for booting and storage.

- **Basic Command-Line Interface**  
  Provides a simple interactive CLI for communicating with the operating system.

- **Hardware Information Command**  
  Supports commands such as `info` to display basic system and hardware-related details.

- **Low-Level Input and Output Handling**  
  Manages essential screen output and keyboard input close to the hardware layer.

## 🛠️ Technology Stack

- **Language:** x86 Assembly
- **Assembler:** NASM
- **Disk Image Format:** FAT12 Floppy Image
- **Emulator:** QEMU
- **Development Environment:** Linux / Ubuntu / WSL

## 🧠 Project Purpose

The goal of YehanOS is to develop a stronger understanding of operating system fundamentals, including:

- Boot flow and kernel loading
- Low-level system initialization
- Hardware-level input and output
- Command-line interaction
- Basic kernel architecture

Instead of relying entirely on high-level abstractions, this project studies what happens closer to the machine level.

The **MikeOS bootloader** is used to handle the early boot process, allowing the project to focus more deeply on the custom kernel, CLI behavior, and low-level system interactions.

## 📁 Project Structure

```text
simple-os/
├── bootloader/
│   └── bootloader.asm
│
├── image/
│   ├── bootloader.bin
│   └── myos.flp
│
├── kernel/
│   ├── KERNEL.BIN
│   └── my_kernel.asm
│
└── tools/
    └── build_and_run.sh
```

### Directory Overview

- `bootloader/` — Contains the MikeOS bootloader source used for the project.
- `kernel/` — Contains the YehanOS kernel source and compiled kernel binary.
- `image/` — Stores the FAT12 floppy disk image and compiled bootloader binary.
- `tools/` — Contains helper scripts for building and running the OS.

## ⚙️ Prerequisites

To build and run YehanOS locally, a Linux-based environment is recommended. WSL is also supported.

Required tools:

- `nasm`
- `qemu-system-x86`
- `dosfstools`
- `mtools`

Install them on Ubuntu or Debian with:

```bash
sudo apt update
sudo apt install nasm qemu-system-x86 dosfstools mtools
```

## 🏗️ Quick Start

To quickly run YehanOS using the existing floppy disk image:

### 1. Clone the repository

```bash
git clone https://github.com/BGYKanishka/YehanOS.git
cd YehanOS
```

### 2. Launch YehanOS in QEMU

```bash
qemu-system-i386 -drive file=image/myos.flp,format=raw,if=floppy
```

> **Note:** The exact QEMU command may vary depending on the computer, QEMU version, operating system, or floppy image path.  
> The command above is the one used during development and testing of YehanOS.

## 🛠️ Build and Run from Source

YehanOS can be built manually using NASM, FAT12 image tools, and QEMU.

### 1. Compile the custom kernel

```bash
nasm -f bin kernel/my_kernel.asm -o kernel/KERNEL.BIN
```

### 2. Compile the MikeOS bootloader

```bash
nasm -f bin bootloader/bootloader.asm -o image/bootloader.bin
```

### 3. Create a 1.44 MB floppy disk image

```bash
dd if=/dev/zero of=image/myos.flp bs=512 count=2880
```

### 4. Format the floppy image as FAT12

```bash
mkfs.fat -F 12 image/myos.flp
```

### 5. Write the bootloader to the first sector

```bash
dd if=image/bootloader.bin of=image/myos.flp bs=512 count=1 conv=notrunc
```

### 6. Copy the kernel into the floppy image

```bash
mcopy -i image/myos.flp kernel/KERNEL.BIN ::KERNEL.BIN
```

### 7. Run YehanOS in QEMU

```bash
qemu-system-i386 -drive file=image/myos.flp,format=raw,if=floppy
```

> Depending on the system setup, another QEMU command may also work:
>
> ```bash
> qemu-system-i386 -fda image/myos.flp
> ```

## 💻 System Boot Output

When the operating system boots successfully, it displays:

```text
Welcome YehanOS Yehan>>
```

The system then waits for a command at the prompt:

```text
> _
```
## 📸 Preview

### YehanOS Boot Screen

The system boots into a simple command-line interface and displays a welcome message.

### Hardware Information Command

Running the `info` command displays detected system information such as memory, CPU vendor, serial port availability, and hard drive status.

## 📌 Project Status

YehanOS is an educational operating system project and is currently focused on:

- Expanding CLI commands
- Improving kernel structure
- Adding more low-level system functionality
- Strengthening understanding of OS internals

## 📖 Further Reading

Read more about the development process and technical details behind YehanOS:

- **Medium Article:** [Crafting Your Own Mini-OS](https://medium.com/@bgykanishka/crafting-your-own-mini-os-444e487784bf)
