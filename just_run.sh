#!/usr/bin/env sh

# Enviroment variables
NERDFONTVERS=v2.1.0

# Prepare original fonts from official release
unzip ./berkeley*.zip
rm -R -f ./*typeface*.zip
rm -R -f ./*variable*
mv ./*/TTF ./ttf
rm -R -f ./*berkeley*

# Get and prepare NerdFonts Patcher
curl -L https://raw.githubusercontent.com/ryanoasis/nerd-fonts/${NERDFONTVERS}/font-patcher --output font-patcher
patch font-patcher 0001*.patch

# Download source fonts for NerdFonts
mkdir -p src/glyphs
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/FontAwesome.otf?raw=true --output src/glyphs/FontAwesome.otf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/NerdFontsSymbols%201000%20EM%20Nerd%20Font%20Complete%20Blank.sfd?raw=true --output "src/glyphs/NerdFontsSymbols 1000 EM Nerd Font Complete Blank.sfd"
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/NerdFontsSymbols%202048%20EM%20Nerd%20Font%20Complete%20Blank.sfd?raw=true --output "src/glyphs/NerdFontsSymbols 2048 EM Nerd Font Complete Blank.sfd"
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/Pomicons.otf?raw=true --output src/glyphs/Pomicons.otf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/PowerlineExtraSymbols.otf?raw=true --output src/glyphs/PowerlineExtraSymbols.otf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/PowerlineSymbols.otf?raw=true --output src/glyphs/PowerlineSymbols.otf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/Symbols%20Template%201000%20em.ttf?raw=true --output "src/glyphs/Symbols Template 1000 em.ttf"
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/Symbols%20Template%202048%20em.ttf?raw=true --output "src/glyphs/Symbols Template 2048 em.ttf"
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/Symbols-1000-em%20Nerd%20Font%20Complete.ttf?raw=true --output "src/glyphs/Symbols-1000-em Nerd Font Complete.ttf"
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf?raw=true --output "src/glyphs/Symbols-2048-em Nerd Font Complete.ttf"
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/Unicode_IEC_symbol_font.otf?raw=true --output src/glyphs/Unicode_IEC_symbol_font.otf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/devicons.ttf?raw=true --output src/glyphs/devicons.ttf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/font-awesome-extension.ttf?raw=true --output src/glyphs/font-awesome-extension.ttf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/font-logos.ttf?raw=true --output src/glyphs/font-logos.ttf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/materialdesignicons-webfont.ttf?raw=true --output src/glyphs/materialdesignicons-webfont.ttf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/octicons.ttf?raw=true --output src/glyphs/octicons.ttf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/original-source.otf?raw=true --output src/glyphs/original-source.otf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/glyphs/weathericons-regular-webfont.ttf?raw=true --output src/glyphs/weathericons-regular-webfont.ttf
curl -L https://github.com/ryanoasis/nerd-fonts/blob/${NERDFONTVERS}/src/unpatched-fonts/Hack/Regular/Hack-Regular.ttf?raw=true --output src/glyphs/Hack-Regular.ttf

# Extract additional PowerLine glyphs
fontforge -lang=ff -script extract-extra-glyphs

# Build patched fonts
./do_generate 01 -c -c BerkeleyMono-Bold.ttf XBerkMono-Bold.ttf "XBerkMono"
./do_generate 02 -c -c BerkeleyMono-BoldItalic.ttf XBerkMono-BoldItalic.ttf "XBerkMono"
./do_generate 03 -c -c BerkeleyMono-Regular.ttf XBerkMono.ttf "XBerkMono"
./do_generate 04 -c -c BerkeleyMono-Italic.ttf XBerkMono-Italic.ttf "XBerkMono"

# Rename (some) patched fonts for compliance
mv XBerkMono.ttf XBerkMono-Regular.ttf
mv XBerkMono-Italic.ttf XBerkMono-RegularItalic.ttf

# Prepare release
mkdir XBerkMono
mv XBerkMono*ttf XBerkMono
zip XBerkMono.zip XBerkMono/*
