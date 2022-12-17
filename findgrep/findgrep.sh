#!/bin/bash

pattern=$1
directory=$2
name=$3

# 第二引数(起点ディレクトリ)が空文字の場合、
# デフォルト値としてカレントディレクトリを設定
if [ -z "$directory" ]; then
    directory='.'
fi

# 第三匹数が(検索ファイルパターン)が空文字の場合、
# デフォルト値として全てのファイルを設定
if [ -z "$name" ]; then
    name='*'
fi

find "$directory" -type f -name "$name" | xargs grep -nH "$pattern"