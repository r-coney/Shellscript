#!/bin/bash

usage()
{
    # シェルスクリプトのファイル名を取得
    local script_name=$(basename "$0")

    # ヒアドキュメントでヘルプを表示
    cat << END
Usage: $script_name PATTERN [PATH] [NAME_PATTERN]
Find file in curent directory recursively, and print lines which PATTERN.

    PATH          find file in PATH directory, instead of current directory
    NAME_PATTERN  specify name pattern to find file

Examples:
    $script_name return
    $script_name return ~ '*.txt'
END
}

# コマンドライン引数が0個の場合
if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

pattern=$1
directory=$2
name=$3

# 検索ディレクトリが存在しない場合、エラーメッセージを表示して終了
if [ ! -d "$directory" ]; then
    echo "$0: ${directory}: No such directory" 1>&2
    exit 2
fi

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
