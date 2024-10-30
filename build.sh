#!/bin/bash
#
# Compile script for Kernel

SECONDS=0 # builtin bash timer
CLANG_DIR="$HOME/toolchains/neutron-clang-18"
DEFCONFIG="tucana_defconfig"

MAKE_PARAMS="O=out ARCH=arm64 CC=clang LLVM=1 LLVM_IAS=1 \
	AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy \
	OBJDUMP=llvm-objdump STRIP=llvm-strip \
	CROSS_COMPILE=aarch64-linux-gnu-"

export PATH="$CLANG_DIR/bin:$PATH"

if [[ $1 = "-c" || $1 = "--clean" ]]; then
	make mrproper
	echo "Cleaned output folder"
fi

mkdir -p out
make $MAKE_PARAMS $DEFCONFIG

echo -e "\nStarting compilation...\n"
make -j$(nproc) $MAKE_PARAMS || exit $?

kernel="out/arch/arm64/boot/Image.gz-dtb"

if [ ! -f "$kernel" ]; then
	echo -e "\nCompilation failed!"
	exit 1
fi

echo -e "\nKernel compiled succesfully!\n"
echo -e "\nCompleted in $((SECONDS / 60)) minutes ve $((SECONDS % 60)) seconds."
