#!/bin/bash
# 配置したい設定ファイル
dotfiles=(.zshrc .zshenv .zprofile .vim .vimrc .git .config)

#設定ファイルのシンボリックリンクをホームディレクトリ直下に
#作成する
for file in "${dotfiles[@]}"; do
        ln -svf $file ~/
done