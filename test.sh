#!/bin/bash

function delete(){

        dotfiles=(.zshrc .zshenv .zprofile .vim .vimrc .config .profile)
        # 削除対象ディレクトリ（今回は/home/prof-accord）
        DIR="/home/prof-accord";
        # 対象ディレクトリに移動
        cd $DIR;
        # メッセージ出力
        echo "dotfiles更新：既存ファイルを削除します"

        # ① 最終更新から100日を超過したファイルを再帰的に検索
        # ② ①の検索結果を強制的に削除し、詳細を出力
        # ③ 結果を/home/ec2-user/log配下のdelete_files_[年月日].logファイルに出力（ファイルが存在しない場合は新規作成される）
        # ④ 削除件数を取得
        # COUNT=$(find $dotfiles -type f | xargs rm -frv | tee -a /home/ec2-user/log/delete_files_`date +%Y%m%d`.log | wc -l)
        # 削除件数を出力
        if find $dotfiles -type f -delete; then
                echo "対象のファイルを確認"
        else
                echo "対象のファイルはありません"
        fi
        echo "${COUNT} ファイル削除しました"

}

echo "======= 処理開始=======" && (delete || fail) && echo "======= 処理終了======="