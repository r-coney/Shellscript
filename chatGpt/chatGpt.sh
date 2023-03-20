#!/bin/bash

while true; do
  read -p "

Assistant >> " prompt

  # 入力が空の場合はループを続ける
  if [ -z "$prompt" ]; then
    continue
  fi

  # JSONデータをエスケープする
  prompt=$(echo $prompt | jq -sRr @json)

  # APIリクエストを送信し、応答を変数に保存する
  response=$(curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "{
       \"model\": \"gpt-3.5-turbo\",
       \"messages\": [{\"role\": \"user\", \"content\": $prompt}],
       \"temperature\": 0.7
   }")

  # 応答から生成されたテキストを抽出する
  output_text=$(echo $response | jq -r  -R 'fromjson? | .choices[0].message.content')

  # APIから受信した応答を表示する
  echo $output_text
done

