echo -e '\033]2;CleanTool9 by Asia81 ported by Nethack\007'
clear
echo ""
echo -e "\e[1;31m!! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!"
echo "!! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!"
echo ""
echo "This file will erase the following files in this folder:"
echo ""
echo "- All .xorpad files"
echo "- All .3ds files"
echo "- All .cci files"
echo "- All .cxi files"
echo "- All .cia files"
echo "- All .app files"
echo "- All .out files"
echo "- All .cfa files"
echo "- All .sav files"
echo "- All .tmd files"
echo "- All .cmd files"
echo "- All .bin files"
echo "- All .lz files"
echo "- All Extracted* folders"
echo ""
echo "!! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!"
echo "!! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !! WARNING !!"
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
