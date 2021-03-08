#!/usr/bin/env bash

set -e
set -x

env | sort

echo "*****"

pwd

ls -laR


erlang_url="https://github.com/erlang/otp/releases/download/OTP-${ERLANG_VERSION}/otp_win64_${ERLANG_VERSION}.exe"
echo "Downloading Erlang ${ERLANG_VERSION} from ${erlang_url}"

curl -L -o "${TEMP}\erlang.exe" $erlang_url

echo "Installing Erlang"

"${TEMP}/erlang.exe" /S /D="c:\erlang"

echo "Waiting for c:\erlang\bin\erl.exe..."

while [ ! -f "c:\erlang\bin\erl.exe" ]; do sleep 1; done

echo "Downloading Elixir ${ELIXIR_VERSION"

elixir_url="https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip"
curl -L -o "${TEMP}/elixir.zip" $elixir_url

echo "Extracting Elixir"
unzip "${TEMP}/elixir.zip" -d "c:\elixir"

echo "Appending c:\elixir\bin and c:\erlang\bin to PATH"
echo "c:\erlang\bin" >> $GITHUB_PATH
echo "c:\elixir\bin" >> $GITHUB_PATH

echo "PATH:"
cat $GITHUB_PATH

echo "Finished"