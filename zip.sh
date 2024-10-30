cp out/arch/arm64/boot/Image.gz-dtb ./AnyKernel3/

cd AnyKernel3 && zip -r tucana-kernel-A13-AOSP-KSU-$(date +"%d-%m-%Y"-%H%M).zip * && mv tucana-kernel-A13-AOSP-KSU-$(date +"%d-%m-%Y-%H%M").zip ../out/

cd ..

rm AnyKernel3/Image.gz-dtb
