clear
echo ""
CiaName=${1%.*}
CiaExt="${1##*.}"
CiaFull=$CiaName$CiaExt
clear
echo ""
echo "Veuillez patienter, extraction de $CiaFull en cours..."
echo ""
mkdir ${1}_Unpacked > /dev/null
./ctrtool --content=${1}_Unpacked/DecryptedApp ${1} > /dev/null
mv ${1}_Unpacked/DecryptedApp.0000.* ${1}_Unpacked/DecryptedPartition0.bin > /dev/null
mv ${1}_Unpacked/DecryptedApp.0001.* ${1}_Unpacked/DecryptedPartition1.bin > /dev/null
mv ${1}_Unpacked/DecryptedApp.0002.* ${1}_Unpacked/DecryptedPartition2.bin > /dev/null
./3dstool -xvtf cxi ${1}_Unpacked/DecryptedPartition0.bin --header ${1}_Unpacked/HeaderNCCH0.bin --exh ${1}_Unpacked/DecryptedExHeader.bin --exh-auto-key --exefs ${1}_Unpacked/DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs ${1}_Unpacked/DecryptedRomFS.bin --romfs-auto-key --logo ${1}_Unpacked/LogoLZ.bin --plain ${1}_Unpacked/PlainRGN.bin > /dev/null
./3dstool -xvtf cfa ${1}_Unpacked/DecryptedPartition1.bin --header ${1}_Unpacked/HeaderNCCH1.bin --romfs ${1}_Unpacked/DecryptedManual.bin --romfs-auto-key > /dev/null
./3dstool -xvtf cfa ${1}_Unpacked/DecryptedPartition2.bin --header ${1}_Unpacked/HeaderNCCH2.bin --romfs ${1}_Unpacked/DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null
./3dstool -xvtf cfa ${1}_Unpacked/DecryptedPartition6.bin --header ${1}_Unpacked/HeaderNCCH6.bin --romfs ${1}_Unpacked/DecryptedN3DSUpdate.bin --romfs-auto-key > /dev/null
./3dstool -xvtf cfa ${1}_Unpacked/DecryptedPartition7.bin --header ${1}_Unpacked/HeaderNCCH7.bin --romfs ${1}_Unpacked/DecryptedO3DSUpdate.bin --romfs-auto-key > /dev/null
rm ${1}_Unpacked/DecryptedPartition0.bin > /dev/null
rm ${1}_Unpacked/DecryptedPartition1.bin > /dev/null
rm ${1}_Unpacked/DecryptedPartition2.bin > /dev/null
rm ${1}_Unpacked/DecryptedPartition6.bin > /dev/null
rm ${1}_Unpacked/DecryptedPartition7.bin > /dev/null
./3dstool -xvtfu exefs ${1}_Unpacked/DecryptedExeFS.bin --header ${1}_Unpacked/HeaderExeFS.bin --exefs-dir ${1}_Unpacked/ExtractedExeFS > /dev/null
./3dstool -xvtf romfs ${1}_Unpacked/DecryptedRomFS.bin --romfs-dir ${1}_Unpacked/ExtractedRomFS > /dev/null
./3dstool -xvtf romfs ${1}_Unpacked/DecryptedManual.bin --romfs-dir ${1}_Unpacked/ExtractedManual > /dev/null
./3dstool -xvtf romfs ${1}_Unpacked/DecryptedDownloadPlay.bin --romfs-dir ${1}_Unpacked/ExtractedDownloadPlay > /dev/null
./3dstool -xvtf romfs ${1}_Unpacked/DecryptedN3DSUpdate.bin --romfs-dir ${1}_Unpacked/ExtractedN3DSUpdate > /dev/null
./3dstool -xvtf romfs ${1}_Unpacked/DecryptedO3DSUpdate.bin --romfs-dir ${1}_Unpacked/ExtractedO3DSUpdate > /dev/null
mv ${1}_Unpacked/ExtractedExeFS/banner.bnr ${1}_Unpacked/ExtractedExeFS/banner.bin > /dev/null
mv ${1}_Unpacked/ExtractedExeFS/icon.icn ${1}_Unpacked/ExtractedExeFS/icon.bin > /dev/null
cp ${1}_Unpacked/ExtractedExeFS/banner.bin ${1}_Unpacked/banner.bin > /dev/null
./3dstool -xv -t banner -f ${1}_Unpacked/banner.bin --banner-dir ${1}_Unpacked/ExtractedBanner/ > /dev/null
rm ${1}_Unpacked/banner.bin > /dev/null
mv ${1}_Unpacked/ExtractedBanner/banner0.bcmdl ${1}_Unpacked/ExtractedBanner/banner0.cgfx > /dev/null
