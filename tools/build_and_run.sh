# Make sure you are in the 'your_project/' directory

# 1. Assemble your custom kernel
nasm -f bin kernel/my_kernel.asm -o kernel/KERNEL.BIN

# 2. Assemble the bootloader
nasm -f bin bootloader/bootloader.asm -o image/bootloader.bin
# This command should now succeed without the "TIMES value negative" error!

# 3. Create the floppy disk image file (ensure correct size 2880)
dd if=/dev/zero of=image/myos.flp bs=512 count=2880

# 4. Format the floppy image with FAT12 filesystem
mkfs.fat -F 12 image/myos.flp

# 5. Install the bootloader onto the floppy image
dd if=image/bootloader.bin of=image/myos.flp bs=512 count=1 conv=notrunc

# 6. Copy your kernel to the floppy image
mcopy -i image/myos.flp kernel/KERNEL.BIN ::KERNEL.BIN

# 7. Boot the OS with QEMU
qemu-system-i386 -fda image/myos.flp