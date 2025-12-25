echo -e '\033]2;CleanTool9 par Asia81 ported by Nethack\007'
clear
echo ""
echo -e "\e[1;31m!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!"
echo "!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!"
echo ""
echo "Ce fichier va effacer les fichiers suivants de ce dossier:"
echo ""
echo "- Tous les fichiers .xorpad"
echo "- Tous les fichiers .3ds"
echo "- Tous les fichiers .cci"
echo "- Tous les fichiers .cxi"
echo "- Tous les fichiers .cia"
echo "- Tous les fichiers .app"
echo "- Tous les fichiers .out"
echo "- Tous les fichiers .cfa"
echo "- Tous les fichiers .sav"
echo "- Tous les fichiers .tmd"
echo "- Tous les fichiers .cmd"
echo "- Tous les fichiers .bin"
echo "- Tous les fichiers .lz"
echo "- Tous les dossiers Extracted*"
echo ""
echo "!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!"
echo "!! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !! ATTENTION !!"
echo -e "\e[0m"
read a
rm *.xorpad > /dev/null
rm *.3ds > /dev/null
rm *.cci > /dev/null
rm *.cxi > /dev/null
rm *.cia > /dev/null
rm *.app > /dev/null
rm *.out > /dev/null
rm *.cfa > /dev/null
rm *.sav > /dev/null
rm *.tmd > /dev/null
rm *.cmd > /dev/null
rm *.bin > /dev/null
rm *.lz > /dev/null
rm -r ExtractedExeFS > /dev/null
rm -r ExtractedRomFS > /dev/null
rm -r ExtractedBanner > /dev/null
rm -r ExtractedManual > /dev/null
rm -r ExtractedDownloadPlay > /dev/null
rm -r ExtractedN3DSUpdate > /dev/null
rm -r ExtractedO3DSUpdate > /dev/null
