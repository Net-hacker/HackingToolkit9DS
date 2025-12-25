clear
echo ""
CiaName=${1%.*}
CiaExt=.cia
CiaFull=$CiaName$CiaExt
echo "Veuillez patienter, compilation de $CiaFull en cours..."
echo ""
mv {$CiaFull}_Unpacked/ExtractedBanner/banner.cgfx {$CiaFull}_Unpacked/ExtractedBanner/banner0.bcmdl > /dev/null
./3dstool -cv -t banner -f {$CiaFull}_Unpacked/banner.bin --banner-dir {$CiaFull}_Unpacked/ExtractedBanner/
mv {$CiaFull}_Unpacked/ExtractedExeFS/banner.bin {$CiaFull}_Unpacked/ExtractedExeFS/banner.bnr > /dev/null
mv {$CiaFull}_Unpacked/ExtractedExeFS/banner.bin {$CiaFull}_Unpacked/ExtractedExeFS/banner.bin > /dev/null
mv {$CiaFull}_Unpacked/ExtractedExeFS/banner.bin {$CiaFull}_Unpacked/ExtractedExeFS/banner.bnr > /dev/null
mv {$CiaFull}_Unpacked/ExtractedExeFS/icon.bin {$CiaFull}_Unpacked/ExtractedExeFS/icon.icn > /dev/null
./3dstool -cvtfz exefs {$CiaFull}_Unpacked/CustomExeFS.bin --header {$CiaFull}_Unpacked/HeaderExeFS.bin --exefs-dir {$CiaFull}_Unpacked/ExtractedExeFS > /dev/null
mv {$CiaFull}_Unpacked/ExtractedExeFS/banner.bnr {$CiaFull}_Unpacked/ExtractedExeFS/banner.bin > /dev/null
mv {$CiaFull}_Unpacked/ExtractedExeFS/icon.icn {$CiaFull}_Unpacked/ExtractedExeFS/icon.bin > /dev/null
./3dstool -cvtf romfs {$CiaFull}_Unpacked/CustomRomFS.bin --romfs-dir {$CiaFull}_Unpacked/ExtractedRomFS > /dev/null
./3dstool -cvtf romfs {$CiaFull}_Unpacked/CustomManual.bin --romfs-dir {$CiaFull}_Unpacked/ExtractedManual > /dev/null
./3dstool -cvtf romfs {$CiaFull}_Unpacked/CustomDownloadPlay.bin --romfs-dir {$CiaFull}_Unpacked/ExtractedDownloadPlay > /dev/null
./3dstool -cvtf cxi {$CiaFull}_Unpacked/CustomPartition0.bin --header {$CiaFull}_Unpacked/HeaderNCCH0.bin --exh {$CiaFull}_Unpacked/DecryptedExHeader.bin --exh-auto-key --exefs {$CiaFull}_Unpacked/CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs {$CiaFull}_Unpacked/CustomRomFS.bin --romfs-auto-key --logo {$CiaFull}_Unpacked/LogoLZ.bin --plain {$CiaFull}_Unpacked/PlainRGN.bin > /dev/null
./3dstool -cvtf cfa {$CiaFull}_Unpacked/CustomPartition1.bin --header {$CiaFull}_Unpacked/HeaderNCCH1.bin --romfs {$CiaFull}_Unpacked/CustomManual.bin --romfs-auto-key > /dev/null
./3dstool -cvtf cfa {$CiaFull}_Unpacked/CustomPartition2.bin --header {$CiaFull}_Unpacked/HeaderNCCH2.bin --romfs {$CiaFull}_Unpacked/CustomDownloadPlay.bin --romfs-auto-key > /dev/null
for j in "${CiaFull}_Unpacked"/Custom*.bin; do
  [ -e "$j" ] || continue
  size=$(stat -c%s "$j")
  if [ "$size" -le 20000 ]; then
    rm "$j"
  fi
done
if [ -f "${CiaFull}_Unpacked/CustomPartition0.bin" ]; then
  ARG0="-content ${CiaFull}_Unpacked/CustomPartition0.bin:0:0x00"
fi

if [ -f "${CiaFull}_Unpacked/CustomPartition1.bin" ]; then
  ARG1="-content ${CiaFull}_Unpacked/CustomPartition1.bin:1:0x01"
fi

if [ -f "${CiaFull}_Unpacked/CustomPartition2.bin" ]; then
  ARG2="-content ${CiaFull}_Unpacked/CustomPartition2.bin:2:0x02"
fi
./makerom -target p -ignoresign -f cia $ARG0 $ARG1 $ARG2 -o {$CiaName}_Edited.cia
