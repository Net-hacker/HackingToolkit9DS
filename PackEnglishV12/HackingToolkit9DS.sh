#!/bin/bash
echo -e '\033]2;HackingToolkit9DS\007'

TitleMenu() {
  clear
  echo ""
  echo "   ##################################################"
  echo "   #                                                #"
  echo "   #          HackingToolkit9DS by Asia81           #"
  echo "   #               Ported by Nethack                #"
  echo "   #           Updated: 02/20/2018 (V12)            #"
  echo "   #                                                #"
  echo "   ##################################################"
  echo ""
  echo ""
  echo "- Write D for extract a .3DS file"
  echo "- Write R for rebuild a .3DS file"
  echo "- Write CE for extract a .CIA file"
  echo "- Write CR for rebuild a .CIA file"
  echo "- Write ME for use a Mass Extractor"
  echo "- Write MR for use a Mass Rebuilder"
  echo "- Write CXI for extract a .CXI file"
  echo "- Write B1 for extract a decrypted banner"
  echo "- Write B2 for rebuild a decrypted banner"
  echo "- Write FS1 for extract a ncch partition"
  echo "- Write FS2 for extract a file partition"
  echo "- Write E for Exit"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  read -p "Write your choice: " Menu
  if [ $Menu = "D" ]; then
    Extract3DS
  elif [ $Menu = "R" ]; then
    Rebuild3DS
  elif [ $Menu = "CE" ]; then
    ExtractCIA
  elif [ $Menu = "CR" ]; then
    RebuildCIA
  elif [ $Menu = "ME" ]; then
    MassExtractor
  elif [ $Menu = "MR" ]; then
    MassRebuilder
  elif [ $Menu = "CXI" ]; then
    DecryptedCXI
  elif [ $Menu = "B1" ]; then
    ExtractBanner
  elif [ $Menu = "B2" ]; then
    RebuildBanner
  elif [ $Menu = "FS1" ]; then
    ExtractNcchPartition
  elif [ $Menu = "FS2" ]; then
    ExtractFilePartition
  elif [ $Menu = "E" ]; then
    clear
    exit 0
  else
    echo "Not a valid Option!"
  fi
}

Extract3DS() {
  clear
  echo ""
  read -p "Write your input .3DS filename (without extension): " Rom3DS
  echo ""
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  echo ""
  ./3dstool -xvt01267f cci DecryptedPartition0.bin DecryptedPartition1.bin DecryptedPartition2.bin DecryptedPartition6.bin DecryptedPartition7.bin $Rom3DS.3DS --header HeaderNCSD.bin > /dev/null
  ./3dstool -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null
  ./3dstool -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key > /dev/null
  ./3dstool -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null
  ./3dstool -xvtf cfa DecryptedPartition6.bin --header HeaderNCCH6.bin --romfs DecryptedN3DSUpdate.bin --romfs-auto-key > /dev/null
  ./3dstool -xvtf cfa DecryptedPartition7.bin --header HeaderNCCH7.bin --romfs DecryptedO3DSUpdate.bin --romfs-auto-key > /dev/null
  rm DecryptedPartition0.bin > /dev/null
  rm DecryptedPartition1.bin > /dev/null
  rm DecryptedPartition2.bin > /dev/null
  rm DecryptedPartition6.bin > /dev/null
  rm DecryptedPartition7.bin > /dev/null
  ./3dstool -xvtfu exefs DecryptedExeFS.bin --exefs-dir ExtractedExeFS --header HeaderExeFS.bin > /dev/null
  ./3dstool -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS > /dev/null
  ./3dstool -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual > /dev/null
  ./3dstool -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null
  ./3dstool -xvtf romfs DecryptedN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate > /dev/null
  ./3dstool -xvtf romfs DecryptedO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate > /dev/null
  mv ExtractedExeFS/banner.bnr ExtractedExeFS/banner.bin > /dev/null
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null
  cp ExtractedExeFS/banner.bin banner.bin > /dev/null
  ./3dstool -xv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null
  rm banner.bin
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

Rebuild3DS() {
  clear
  echo ""
  read -p "Write your output .3DS file (without extension): " OutputRom3DS
  clear
  echo ""
  echo "Please wait, rebuild in progress..."
  echo ""
  mv ExtractedBanner/banner.cgfx ExtractedBanner/banner0.bcmdl > /dev/null
  ./3dstool -cv -t banner -f banner.bin --banner-dir ExtractedBanner/ > dev/null
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  mv banner.bin ExtractedExeFS/banner.bin > /dev/null
  mv ExtractedExeFS/banner.bin ExtractedExeFS/banner.bnr > /dev/null
  mv ExtractedExeFS/icon.bin ExtractedExeFS/icon.icn > /dev/null
  ./3dstool -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS > /dev/null
  ./3dstool -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual > /dev/null
  ./3dstool -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null
  ./3dstool -cvtf romfs CustomN3DSUpdate.bin --romfs-dir ExtractedN3DSUpdate > /dev/null
  ./3dstool -cvtf romfs CustomO3DSUpdate.bin --romfs-dir ExtractedO3DSUpdate > /dev/null
  ./3dstool -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null
  ./3dstool -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key > /dev/null
  ./3dstool -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key > /dev/null
  ./3dstool -cvtf cfa CustomPartition6.bin --header HeaderNCCH6.bin --romfs CustomN3DSUpdate.bin --romfs-auto-key > /dev/null
  ./3dstool -cvtf cfa CustomPartition7.bin --header HeaderNCCH7.bin --romfs CustomO3DSUpdate.bin --romfs-auto-key > /dev/null
  for file in Custom*.bin; do
    if [ $(stat -c %s "$file") -le 20000 ]; then
      rm "$file"
    fi
  done
  ./3dstool -cvt01267f cci CustomPartition0.bin CustomPartition1.bin CustomPartition2.bin CustomPartition6.bin CustomPartition7.bin $OutputRom3DS.3DS --header HeaderNCSD.bin > /dev/null
  rm CustomPartition0.bin > /dev/null
  rm CustomPartition1.bin > /dev/null
  rm CustomPartition2.bin > /dev/null
  rm CustomPartition6.bin > /dev/null
  rm CustomPartition7.bin > /dev/null
  echo "Creation done!"
  echo ""
  read a
  TitleMenu
}

TitleMenu
