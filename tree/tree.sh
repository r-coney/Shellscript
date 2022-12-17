#!/bin/bash

list_recursive()
{
	local filepath=$1
	local indent=$2

	# インデント付きで、パス部分を取り除いてファイル名を表示する
	echo "${indent}${filepath##*/}"

	if [ -d "$filepath" ]; then
		local filename

		_IFS=$IFS
		IFS=$'\n'
		for filename in $(ls "$filepath")
		do
			list_recursive "${filepath}/${filename}" "  $indent"
		done
		IFS=$_IFS
	fi
}

list_recursive "$1" ""