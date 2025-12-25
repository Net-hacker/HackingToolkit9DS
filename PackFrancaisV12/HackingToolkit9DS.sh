#!/bin/bash
echo -e '\033]2;HackingToolkit9DS\007'

TitleMenu() {
  clear
  echo ""
  echo "   ##################################################"
  echo "   #                                                #"
  echo "   #          HackingToolkit9DS par Asia81          #"
  echo "   #               Ported by Nethack                #"
  echo "   #          Mis � jour le 20/02/2018 (V12)        #"
  echo "   #                                                #"
  echo "   ##################################################"
  echo ""
  echo ""
  echo "- Entrez D pour extraire un fichier .3DS"
  echo "- Entrez R pour compiler un fichier .3DS"
  echo "- Entrez CE pour extraire un fichier .CIA"
  echo "- Entrez CR pour compiler un fichier .CIA"
  echo "- Entrez ME pour utiliser un extracteur de masse"
  echo "- Entrez MR pour utiliser un reconstructeur de masse"
  echo "- Entrez CXI pour extraire un fichier .CXI"
  echo "- Entrez B1 pour extraire une banni�re"
  echo "- Entrez B2 pour compiler une banni�re"
  echo "- Entrez FS1 pour extraire une partition ncch"
  echo "- Entrez FS2 pour extraire les donn�es d'une partition"
  echo "- Entrez E pour sortie"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  read -p "Entrez votre s�lection: " Menu
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
    echo "Pas une option valide!"
  fi
}

Extract3DS() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier .3DS (sans extension): " Rom3DS
  echo ""
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
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
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

Rebuild3DS() {
  clear
  echo ""
  read -p "Entrez le nom de sortie de votre fichier .3DS (sans extension): " OutputRom3DS
  clear
  echo ""
  echo "Veuillez patienter, compilation en cours..."
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
  echo "Compilation termin�e!"
  echo ""
  read a
  TitleMenu
}

ExtractCIA() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier .CIA (sans extension): " RomCIA
  echo ""
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
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
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

RebuildCIA() {
  clear
  echo ""
  read -p "Entrez le nom de sortie de votre fichier .CIA (sans extension): " OutputRomCIA
  read -p "Version minor originelle (entrez 0 si vous ne savez pas): " MinorVer
  read -p "Version micro originelle (entrez 0 si vous ne savez pas): " MicroVer
  clear
  echo ""
  echo "Veuillez patienter, compilation en cours..."
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
  echo "Compilation termin�e!"
  echo ""
  read a
  TitleMenu
}

DecryptedCXI() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier .CXI (sans extension): " RomCXI
  echo ""
  read -p "D�compresser le fichier code.bin (n/o): " DecompressCode
  if [ DecompressCode = "O" || DecompressCode = "o" ]; then
    DC="--decompresscode"
  else
    DC=""
  fi
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  echo ""
  ./ctrtool --ncch=0 --exheader=DecryptedExHeader.bin $RomCXI.cxi > /dev/null
  ./ctrtool --ncch=0 --exefs=DecryptedExeFS.bin $RomCXI.cxi > /dev/null
  ./ctrtool --ncch=0 --romfs=DecryptedRomFS.bin $RomCXI.cxi > /dev/null
  ./ctrtool -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null
  ./ctrtool -t exefs --exefsdir=./ExtractedExeFS DecryptedExeFS.bin $DC > /dev/null
  echo "Extraction termin�e!"
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
  echo "Banni�re extraite"
  echo ""
  read a
  TitleMenu
}

RebuildBanner() {
  clear
  echo ""
  mv ExtractedBanner/banner.cgfx ExtractedBanner/banner0.bcmdl > /dev/null
  ./3dstool -c -t banner -f banner.bin --banner-dir ExtractedBanner/ > /dev/null
  mv ExtractedBanner/banner0.bcmdl ExtractedBanner/banner.cgfx > /dev/null
  echo "Banni�re compil�e!"
  echo ""
  read a
  TitleMenu
}

ExtractNcchPartition() {
  clear
  echo ""
  echo "1 = Extraire DecryptedExHeader.bin de la partition NCCH0"
  echo "2 = Extraire DecryptedExeFS.bin de la partition NCCH0"
  echo "3 = Extraire DecryptedRomFS.bin de la partition NCCH0"
  echo "4 = Extraire DecryptedManual.bin de la partition NCCH1"
  echo "5 = Extraire DecryptedDownloadPlay.bin de la partition NCCH2"
  echo "6 = Extraire DecryptedN3DSUpdate.bin de la partition NCCH6"
  echo "7 = Extraire DecryptedO3DSUpdate.bin de la partition NCCH7"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  read -p "Entrez votre choix (1/2/3/4/5/6/7): " NcchPartition
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
    echo "Pas une option valide!"
  fi
}

ExtractNCCH-ExHeader() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  ./ctrtool --ncch=0 --exheader=DecryptedExHeader.bin $FileName > /dev/null
  echo ""
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

ExtractNCCH-ExeFS() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool --ncch=0 --exefs=DecryptedExeFS.bin $FileName > /dev/null
  echo ""
  read -p "Extraction termin�e ! Souhaitez-vous l'extraire (n/o): " Ask2Extract
  if [ $Ask2Extract = "O" || $Ask2Extract = "o" ]; then
    ExtractExeFS
  else
    TitleMenu
  fi
}

ExtractNCCH-RomFS() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool --ncch=0 --romfs=DecryptedRomFS.bin $FileName > /dev/null
  echo ""
  read -p "Extraction termin�e ! Souhaitez-vous l'extraire (n/o): " Ask2Extract
  if [ $Ask2Extract = "O" || $Ask2Extract = "o" ]; then
    ExtractRomFS
  else
    TitleMenu
  fi
}

ExtractNCCH-Manual() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool --ncch=1 --romfs=DecryptedManual.bin $FileName > /dev/null
  echo ""
  read -p "Extraction termin�e ! Souhaitez-vous l'extraire (n/o): " Ask2Extract
  if [ $Ask2Extract = "O" || $Ask2Extract = "o" ]; then
    ExtractManual
  else
    TitleMenu
  fi
}

ExtractNCCH-DownloadPlay() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool --ncch=2 --romfs=DecryptedDownloadPlay.bin $FileName > /dev/null
  echo ""
  read -p "Extraction termin�e ! Souhaitez-vous l'extraire (n/o): " Ask2Extract
  if [ $Ask2Extract = "O" || $Ask2Extract = "o" ]; then
    ExtractDownloadPlay
  else
    TitleMenu
  fi
}

ExtractNCCH-N3DSUpdate() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool --ncch=6 --romfs=DecryptedN3DSUpdate.bin $FileName > /dev/null
  echo ""
  read -p "Extraction termin�e ! Souhaitez-vous l'extraire (n/o): " Ask2Extract
  if [ $Ask2Extract = "O" || $Ask2Extract = "o" ]; then
    ExtractN3DSUpdate
  else
    TitleMenu
  fi
}

ExtractNCCH-O3DSUpdate() {
  clear
  echo ""
  read -p "Entrez le nom de votre fichier 3DS|CXI (extension comprise): " FileName
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool --ncch=7 --romfs=DecryptedO3DSUpdate.bin $FileName > /dev/null
  echo ""
  read -p "Extraction termin�e ! Souhaitez-vous l'extraire (n/o): " Ask2Extract
  if [ $Ask2Extract = "O" || $Ask2Extract = "o" ]; then
    ExtractO3DSUpdate
  else
    TitleMenu
  fi
}

ExtractFilePartition() {
  clear
  echo ""
  echo "1 = Extraire le contenu du fichier DecryptedExeFS.bin"
  echo "2 = Extraire le contenu du fichier DecryptedRomFS.bin"
  echo "3 = Extraire le contenu du fichier DecryptedManual.bin"
  echo "4 = Extraire le contenu du fichier DecryptedDownloadPlay.bin"
  echo "5 = Extraire le contenu du fichier DecryptedN3DSUpdate.bin"
  echo "6 = Extraire le contenu du fichier DecryptedO3DSUpdate.bin"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  read -p "Entrez votre choix (1/2/3/4/5/6): " Partition
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
    echo "Pas une option valide!"
  fi
}

ExtractExeFS() {
  clear
  echo ""
  read -p "D�compresser le fichier code.bin (n/o)): " DecompressCode
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  if [ $DecompressCode = "O" || $DecompressCode = "o" ]; then
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
  echo "Extraction termin�e"
  echo ""
  read a
  TitleMenu
}

ExtractedRomFS() {
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool -t romfs --romfsdir=./ExtractedRomFS DecryptedRomFS.bin > /dev/null
  echo ""
  echo "Extraction termin�e"
  echo ""
  read a
  TitleMenu
}

ExtractManual() {
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool -t romfs --romfsdir=./ExtractedManual DecryptedManual.bin > /dev/null
  echo ""
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

ExtractDownloadPlay() {
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool -t romfs --romfsdir=./ExtractedDownloadPlay DecryptedDownloadPlay.bin > /dev/null
  echo ""
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

ExtractN3DSUpdate() {
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool -t romfs --romfsdir=./ExtractedN3DSUpdate DecryptedN3DSUpdate.bin > /dev/null
  echo ""
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

ExtractO3DSUpdate() {
  clear
  echo ""
  echo "Veuillez patienter, extraction en cours..."
  ./ctrtool -t romfs --romfsdir=./ExtractedO3DSUpdate DecryptedO3DSUpdate.bin > /dev/null
  echo ""
  echo "Extraction termin�e!"
  echo ""
  read a
  TitleMenu
}

TitleMenu
