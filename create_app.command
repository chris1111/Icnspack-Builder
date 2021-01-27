# Icnspack-Builder
# (c) Copyright 2020 chris1111 
# This will create a Apple Bundle App Icnspack-Builder
# Dependencies: osacompile
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
# Declare some VARS
APP_NAME="Icnspack-Builder.app"
SOURCE_SCRIPT="./Icnspack-Builder.applescript"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Icnspack-Builder"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "

# see if the app is already in Desktop
if [ -d "${3}./Icnspack-Builder.app" ]; then
	rm -rf "${3}./Icnspack-Builder.app"
fi

Sleep 2

# Create the dir structure
/usr/bin/osacompile -o "$APP_NAME" "$SOURCE_SCRIPT"

# Copy Resources to the right place
cp -rp ./Contents/Resources/droplet.icns "$APP_NAME"/Contents/Resources
cp -rp ./Contents/Resources/IMGBadge.png "$APP_NAME"/Contents/Resources
cp -rp ./Contents/Resources/IMGDocumentIcon.png "$APP_NAME"/Contents/Resources
cp -rp ./Contents/Resources/ScreenShot.png "$APP_NAME"/Contents/Resources
cp -r ./Contents/Resources/Assets.car "$APP_NAME"/Contents/Resources
cp -r ./Contents/Resources/Base.lproj "$APP_NAME"/Contents/Resources
cp -rf ./Contents/Frameworks "$APP_NAME"/Contents
cp -r ./Contents/Resources/Credits.html "$APP_NAME"/Contents/Resources
cp -rp ./Contents/Info.plist "$APP_NAME"/Contents
rm -rf ./"$APP_NAME"/Contents/MacOS/droplet
cp -rp ./Contents/MacOS/FancyDroplet "$APP_NAME"/Contents/MacOS
cp -rp ./Contents/Resources/description.rtfd "$APP_NAME"/Contents/Resources
cp -r ./Contents/Resources/en.lproj "$APP_NAME"/Contents/Resources
cp -r ./Contents/Resources/Scripts/icnspack "$APP_NAME"/Contents/Resources/Scripts
cp -r ./Contents/Resources/Scripts/icnspack-Build "$APP_NAME"/Contents/Resources/Scripts
cp -r ./Contents/Resources/Scripts/pngquant "$APP_NAME"/Contents/Resources/Scripts

Sleep 1

# Change icons
./icon.py ./Contents/Resources/droplet.icns ./HP-Icon.icns "$APP_NAME"

echo " = = = = = = = = = = = = = = = = = = = = = = = = = 
Icnspack-Builder.app completed
= = = = = = = = = = = = = = = = = = = = = = = = =  "



