#!/bin/bash

# 日記データ保存のdirectory
directory="${HOME}/diary"

# データ保存のディレクトリがなければ作成する
if [ ! -d "$directory" ]; then
    mkdir "$directory"
fi

# 日記ファイルパスの組み立て
diaryfile="${directory}/$(date '+%Y-%m-%d').txt"

# 日記ファイルがなければ(今日はじめて書く場合)、先頭に日付を挿入
if [ ! -e "$diaryfile" ]; then
    date '+%Y/%m/%d' > "$diaryfile"
fi

vim "$diaryfile"