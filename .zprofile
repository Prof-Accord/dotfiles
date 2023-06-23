# linuxbrewにpathを通す
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# localeを修復し日本語が文字化けしないようにする
eval $(/usr/bin/locale-check C.UTF-8)