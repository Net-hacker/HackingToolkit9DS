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
      rm "$file" > /dev/null
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

ExtractCIA() {
  clear
  echo ""
  read -p "Write you input .CIA filename (without extension): " RomCIA
  echo ""
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  echo ""
  ./crtool --content=DecryptedApp $RomCIA.cia > /dev/null
  mv DecryptedApp.000.* DecryptedPartition0.bin > /dev/null
  mv DecryptedApp.001.* DecryptedPartition1.bin > /dev/null
  mv DecryptedApp.002.* DecryptedPartition2.bin > /dev/null
  ./3dstool -xvtf cxi DecryptedPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs DecryptedExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs DecryptedRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null
  ./3dstool -xvtf cfa DecryptedPartition1.bin --header HeaderNCCH1.bin --romfs DecryptedManual.bin --romfs-auto-key > /dev/null
  ./3dstool -xvtf cfa DecryptedPartition2.bin --header HeaderNCCH2.bin --romfs DecryptedDownloadPlay.bin --romfs-auto-key > /dev/null
  rm DecryptedPartition0.bin > /dev/null
  rm DecryptedPartition1.bin > /dev/null
  rm DecryptedPartition2.bin > /dev/null
  ./3dstool -xvtfu exefs DecryptedExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS > /dev/null
  ./3dstool -xvtf romfs DecryptedRomFS.bin --romfs-dir ExtractedRomFS > /dev/null
  ./3dstool -xvtf romfs DecryptedManual.bin --romfs-dir ExtractedManual > /dev/null
  ./3dstool -xvtf romfs DecryptedDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null
  mv ExtractedExeFS/banner.bnr ExtractExeFS/banner.bin > /dev/null
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null
  cp ExtractExeFS/banner.bin banner.bin > /dev/null
  ./3dstool -xv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null
  rm banner.bin > /dev/null
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

RebuildCIA() {
  clear
  echo ""
  read -p "Write your output .CIA filename (without extension): " OutputRomCIA
  read -p "Original minor version (write 0 if you don't know): " MinorVer
  read -p "Original micro version (write 0 if you don't know): " MicroVer
  clear
  echo ""
  echo "Please wait, rebuild in progress..."
  echo ""
  mv ExtractedBanner/banner.cgfx ExtractedBanner/banner0.bcmdl > /dev/null
  ./3dstool -cv -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  mv banner.bin ExtractedExeFS/banner.bin > /dev/null
  mv ExtractedExeFS/banner.bin ExtractedExeFS/banner.bnr > /dev/null
  mv ExtractedExeFS/icon.bin ExtractedExeFS/icon.icn > /dev/null
  ./3dstool -cvtfz exefs CustomExeFS.bin --header HeaderExeFS.bin --exefs-dir ExtractedExeFS > /dev/null
  mv ExtractedExeFS/banner.bnr ExtractedExeFS/banner.bin > /dev/null
  mv ExtractedExeFS/icon.icn ExtractedExeFS/icon.bin > /dev/null
  ./3dstool -cvtf romfs CustomRomFS.bin --romfs-dir ExtractedRomFS > /dev/null
  ./3dstool -cvtf romfs CustomManual.bin --romfs-dir ExtractedManual > /dev/null
  ./3dstool -cvtf romfs CustomDownloadPlay.bin --romfs-dir ExtractedDownloadPlay > /dev/null
  ./3dstool -cvtf cxi CustomPartition0.bin --header HeaderNCCH0.bin --exh DecryptedExHeader.bin --exh-auto-key --exefs CustomExeFS.bin --exefs-auto-key --exefs-top-auto-key --romfs CustomRomFS.bin --romfs-auto-key --logo LogoLZ.bin --plain PlainRGN.bin > /dev/null
  ./3dstool -cvtf cfa CustomPartition1.bin --header HeaderNCCH1.bin --romfs CustomManual.bin --romfs-auto-key > /dev/null
  ./3dstool -cvtf cfa CustomPartition2.bin --header HeaderNCCH2.bin --romfs CustomDownloadPlay.bin --romfs-auto-key
  for file in Custom*.bin; do
    if [ $(stat -c %s "$file") -le 20000 ]; then
      rm "$file" > /dev/null
    fi
  done
  if [ -f "CustomPartition0.bin" ]; then
    ARG0="-content CustomPartition0.bin:0:0x00"
  fi
  if [ -f "CustomPartition1.bin" ]; then
    ARG1="-content CustomPartition1.bin:1:0x01"
  fi
  if [ -f "CustomPartition2.bin" ]; then
    ARG2="-content CustomPartition2.bin:2:0x02"
  fi
  ./makerom -target p -ignoresign -f cia $ARG0 $ARG1 $ARG2 -minor $MinorVer -micro $MicroVer -o $OutputRomCIA.cia > /dev/null
  echo "Creation done!"
  echo ""
  read a
  TitleMenu
}

DecryptedCXI() {
  clear
  echo ""
  read -p "Write your input .CXI filename (without extension): " RomCXI
  echo ""
  read -p "Decompress the code.bin file (n/y): " DecompressCode
  if [ DecompressCode = "Y" || DecompressCode = "y" ]; then
    DC="--decompresscode"
  else
    DC=""
  fi
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  echo ""
  ./ctrtool --ncch=0 --exheader=DecryptedExHeader.bin $RomCXI.cxi > /dev/null
  ./ctrtool --ncch=0 --exefs=DecryptedExeFS.bin $RomCXI.cxi > /dev/null
  ./ctrtool --ncch=0 --romfs=DecryptedRomFS.bin $RomCXI.cxi > /dev/null
  ./ctrtool -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null
  ./ctrtool -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin $DC > /dev/null
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

MassExtractor() {
  clear
  echo ""
  for x in *.3ds *.cci; do
    ./Unpack3DS.sh "$x"
  done
  for x in *.cia; do
    ./UnpackCIA.sh "$x"
  done
  TitleMenu
}

MassRebuilder() {
  clear
  echo ""
  for D in *.3ds *.cci; do
    if [ -d "$D" ]; then
        ./Repack3DS.sh "$(basename "$D")"
    fi
  done
  for D in *.cia; do
    if [ -d "$D" ]; then
        ./RepackCIA.sh "$(basename "$D")"
    fi
  done
  TitleMenu
}

ExtractBanner() {
  clear
  echo ""
  ./3dstool -x -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  echo "Banner created"
  echo ""
  read a
  TitleMenu
}

ExtractNcchPartition() {
  clear
  echo ""
  echo "1 = Extract DecryptedExHeader.bin from NCCH0"
  echo "2 = Extract DecryptedExeFS.bin from NCCH0"
  echo "3 = Extract DecryptedRomFS.bin from NCCH0"
  echo "4 = Extract DecryptedManual.bin from NCCH1"
  echo "5 = Extract DecryptedDownloadPlay.bin from NCCH2"
  echo "6 = Extract DecryptedN3DSUpdate.bin from NCCH6"
  echo "7 = Extract DecryptedO3DSUpdate.bin from NCCH7"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  read -p "Write your choice (1/2/3/4/5/6/7): " NcchPartition
  if [ $NcchPartition = "1" ]; then
    ExtractNCCH-ExHeader
  elif [ $NcchPartition = "2" ]; then
    ExtractNCCH-ExeFS
  elif [ $NcchPartition = "3" ]; then
    ExtractNCCH-RomFS
  elif [ $NcchPartition = "4" ]; then
    ExtractNCCH-Manual
  elif [ $NcchPartition = "5" ]; then
    ExtractNCCH-DownloadPlay
  elif [ $NcchPartition = "6" ]; then
    ExtractNCCH-N3DSUpdate
  elif [ $NcchPartition = "7" ]; then
    ExtractNCCH-O3DSUpdate
  else
    echo "Not a valid Option!"
  fi
}

ExtractNCCH-ExHeader() {
  clear
  echo ""
  read -p "Write your 3DS|CXI filename (with extension): " FileName
  clear
  ./ctrtool --ncch=0 --exheader=DecryptedExHeader.bin $FileName > /dev/null
  echo ""
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

ExtractNCCH-ExeFS() {
  clear
  echo ""
  read -p "Write your 3DS|CXI filename (with extension): " FileName
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool --ncch=0 --exefs=DecryptedExeFS.bin $FileName > /dev/null
  echo ""
  read -p "Extraction done! Would you extract it now (n/y): " Ask2Extract
  if [ $Ask2Extract = "Y" || $Ask2Extract = "y" ]; then
    ExtractExeFS
  else
    TitleMenu
  fi
}

ExtractNCCH-RomFS() {
  clear
  echo ""
  read -p "Write your 3DS|CXI filename (with extension): " FileName
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool --ncch=0 --romfs=DecryptedRomFS.bin $FileName > /dev/null
  echo ""
  if [ $Ask2Extract = "Y" || $Ask2Extract = "y" ]; then
    ExtractRomFS
  else
    TitleMenu
  fi
}

ExtractNCCH-Manual() {
  clear
  echo ""
  read -p "Write your 3DS|CXI filename (with extension): " FileName
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool --ncch=0 --romfs=DecryptedManual.bin $FileName > /dev/null
  echo ""
  if [ $Ask2Extract = "Y" || $Ask2Extract = "y" ]; then
    ExtractManual
  else
    TitleMenu
  fi
}

ExtractNCCH-N3DSUpdate() {
  clear
  echo ""
  read -p "Write your 3DS|CXI filename (with extension): " FileName
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool --ncch=0 --romfs=DecryptedN3DSUpdate.bin $FileName > /dev/null
  echo ""
  if [ $Ask2Extract = "Y" || $Ask2Extract = "y" ]; then
    ExtractN3DSUpdate
  else
    TitleMenu
  fi
}

ExtractNCCH-O3DSUpdate() {
  clear
  echo ""
  read -p "Write your 3DS|CXI filename (with extension): " FileName
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool --ncch=0 --romfs=DecryptedO3DSUpdate.bin $FileName > /dev/null
  echo ""
  if [ $Ask2Extract = "Y" || $Ask2Extract = "y" ]; then
    ExtractO3DSUpdate
  else
    TitleMenu
  fi
}

ExtractFilePartition() {
  clear
  echo ""
  echo "1 = Extract contents from DecryptedExeFS.bin"
  echo "2 = Extract contents from DecryptedRomFS.bin"
  echo "3 = Extract contents from DecryptedManual.bin"
  echo "4 = Extract contents from DecryptedDownloadPlay.bin"
  echo "5 = Extract contents from DecryptedN3DSUpdate.bin"
  echo "6 = Extract contents from DecryptedO3DSUpdate.bin"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  read -p "Write your choice (1/2/3/4/5/6): " Partition
  if [ $Partition = "1" ]; then
    ExtractExeFS
  elif [ $Partition = "2" ]; then
    ExtractRomFS
  elif [ $Partition = "3" ]; then
    ExtractManual
  elif [ $Partition = "4" ]; then
    ExtractDownloadPlay
  elif [ $Partition = "5" ]; then
    ExtractN3DSUpdate
  elif [ $Partition = "6" ]; then
    ExtractO3DSUpdate
  else
    echo "Not a valid Option!"
  fi
}

ExtractExeFS() {
  clear
  echo ""
  read -p "Decompress the code.bin file (n/y): " DecompressCode
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  if [ $DecompressCode = "Y" || $DecompressCode = "y" ]; then
    DC="--decompresscode"
  else
    DC=""
  fi
  ./ctrtool -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin $DC > /dev/null
  rm ExtractedExeFS/.bin > /dev/null
  cp ExtractedExeFS/banner.bin banner.bin > /dev/null
  ./3dstool -x -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  rm banner.bin > /dev/null
  echo ""
  echo "Extraction done"
  echo ""
  read a
  TitleMenu
}

ExtractedRomFS() {
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null
  echo ""
  echo "Extraction done"
  echo ""
  read a
  TitleMenu
}

ExtractManual() {
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin > /dev/null
  echo ""
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

ExtractDownloadPlay() {
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin > /dev/null
  echo ""
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

ExtractN3DSUpdate() {
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin > /dev/null
  echo ""
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

ExtractO3DSUpdate() {
  clear
  echo ""
  echo "Please wait, extraction in progress..."
  ./ctrtool -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin > /dev/null
  echo ""
  echo "Extraction done!"
  echo ""
  read a
  TitleMenu
}

TitleMenu
