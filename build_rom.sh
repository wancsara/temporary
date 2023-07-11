# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/hsx02/Local-Manifests.git --depth 1 -b pixelAOSP-13n .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rommmmmm

. build/envsetup.sh
lunch aosp_spes-userdebug
export TZ=Asim bg.ca/Kolkata #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
