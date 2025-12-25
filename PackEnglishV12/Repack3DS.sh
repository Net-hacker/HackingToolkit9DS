clear
echo ""
CciName=${1%.*}
CciExt=.3ds
CciFull=$CciName$CciExt
echo "Please wait, rebuild of $CciFull in progress..."
echo ""
mv {$CciFull}_Unpacked/ExtractedBanner/banner.cgfx {$CciFull}_Unpacked/ExtractedBanner/banner0.bcmdl > /dev/null
./3dstool -cv -t banner -f {$CciFull}_Unpacked/banner.bin --banner-dir {$CciFull}_Unpacked/ExtractedBanner/
mv {$CciFull}_Unpacked/ExtractedBanner/banner0.bcmdl {$CciFull}_Unpacked/ExtractedBanner/banner.cgfx > /dev/null
mv {$CciFull}_Unpacked/banner.bin {$CciFull}_Unpacked/ExtractedExeFS/banner.bin > /dev/null
mv {$CciFull}_Unpacked/ExtractedExeFS/banner.bin {$CciFull}_Unpacked/ExtractedExeFS/banner.bnr > /dev/null
mv {$CciFull}_Unpacked/ExtractedExeFS/icon.bin {$CciFull}_Unpacked/ExtractedExeFS/icon.icn > /dev/null
./3dstool -cvtfz exefs {$CciFull}_Unpacked/CustomExeFS.bin --header {$CciFull}_Unpacked/HeaderExeFS.bin --exefs-dir {$CciFull}_Unpacked/ExtractedExeFS > /dev/null
mv {$CciFull}_Unpacked/ExtractedExeFS/banner.bnr {$CciFull}_Unpacked/ExtractedExeFS/banner.bin > /dev/null
mv {$CciFull}_Unpacked/ExtractedExeFS/icon.icn {$CciFull}_Unpacked/ExtractedExeFS/icon.bin > /dev/null
./3dstool -cvtf romfs {$Cci_Full}_Unpacked/CustomRomFS.bin --romfs-dir {$Cci_Full}_Unpacked/ExtractedRomFS > /dev/null
./3dstool -cvtf romfs {$Cci_Full}_Unpacked/CustomManual.bin --romfs-dir {$Cci_Full}_Unpacked/ExtractedManual > /dev/null
./3dstool -cvtf romfs {$Cci_Full}_Unpacked/CustomDownloadPlay.bin --romfs-dir {$Cci_Full}_Unpacked/ExtractedDownloadPlay > /dev/null
./3dstool -cvtf romfs {$Cci_Full}_Unpacked/CustomN3DSUpdate.bin --romfs-dir {$Cci_Full}_Unpacked/ExtractedN3DSUpdate > /dev/null
./3dstool -cvtf romfs {$Cci_Full}_Unpacked/CustomO3DSUpdate.bin --romfs-dir {$Cci_Full}_Unpacked/ExtractedO3DSUpdate > /dev/null
./3dstool -cvtf cxi {$Cci_Full}_Unpacked/CustomPartition0.bin --header {$Cci_Full}_Unpacked/HeaderNCCH0.bin --exh {$Cci_Full}_Unpacked/DecryptedExHeader.bin --exh-auto-key --exefs {$Cci_Full}_Unpacked/CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs {$Cci_Full}_Unpacked/CustomRomFS.bin --romfs-auto-key --logo {$Cci_Full}_Unpacked/LogoLZ.bin --plain {$Cci_Full}_Unpacked/PlainRGN.bin
./3dstool -cvtf cfa {$Cci_Full}_Unpacked/CustomPartition1.bin --header {$Cci_Full}_Unpacked/HeaderNCCH1.bin --romfs {$Cci_Full}_Unpacked/CustomManual.bin --romfs-auto-key > /dev/null
./3dstool -cvtf cfa {$Cci_Full}_Unpacked/CustomPartition2.bin --header {$Cci_Full}_Unpacked/HeaderNCCH2.bin --romfs {$Cci_Full}_Unpacked/CustomDownloadPlay.bin --romfs-auto-key > /dev/null
./3dstool -cvtf cfa {$Cci_Full}_Unpacked/CustomPartition6.bin --header {$Cci_Full}_Unpacked/HeaderNCCH6.bin --romfs {$Cci_Full}_Unpacked/CustomN3DSUpdate.bin --romfs-auto-key > /dev/null
./3dstool -cvtf cfa {$Cci_Full}_Unpacked/CustomPartition7.bin --header {$Cci_Full}_Unpacked/HeaderNCCH7.bin --romfs {$Cci_Full}_Unpacked/CustomO3DSUpdate.bin --romfs-auto-key > /dev/null
for j in "${CciFull}_Unpacked"/Custom*.bin; do
  [ -f "$j" ] || continue
  if [ "$(stat -c %s "$j")" -le 20000 ]; then
    rm "$j" > /dev/null
  fi
done
./3dstool -cvt01267f cci {$Cci_Full}_Unpacked/CustomPartition0.bin {$Cci_Full}_Unpacked/CustomPartition1.bin {$Cci_Full}_Unpacked/CustomPartition2.bin {$Cci_Full}_Unpacked/CustomPartition6.bin {$Cci_Full}_Unpacked/CustomPartition7.bin %CciName%_Edited.3ds --header {$Cci_Full}_Unpacked/HeaderNCSD.bin
