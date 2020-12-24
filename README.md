# Dotfiles

自分用の設定ファイルなど。

- [Windows 版](./readme-windows.md)

## コマンド

ホスト環境のみ:

```sh
sudo apt update && \
sudo apt install -y git
```

仮想環境のみ:

```sh
USER_NAME='owner'

apt update && \
apt install -y git && \
git clone --depth=1 https://github.com/vain0x/dotfiles && \
cd dotfiles && \
./add_user $USER_NAME && \
su $USER_NAME -c bash
```

両方:

```sh
mkdir -p ~/repo/local/dotfiles && \
git clone https://github.com/vain0x/dotfiles ~/repo/local/dotfiles && \
cd ~/repo/local/dotfiles && \
./ubuntu_core && \
./ubuntu_tools && \
./ubuntu_host
```

## リンク

ファイラ:

- [fman](https://fman.io/download)

開発ツール:

- [.NET](https://dotnet.microsoft.com/download)
    - [Ubuntu に .NET Core をインストールする](https://docs.microsoft.com/ja-jp/dotnet/core/install/linux-ubuntu)
    - [F#](http://ionide.io/)
- [Node.js](https://nodejs.org)
    - [Yarn](https://yarnpkg.com/)
- [Rust](https://www.rust-lang.org/)

## 手順

### SSH 鍵を生成する

(SSH で接続するのに使う。)

```sh
ssh-keygen && cat ~/.ssh/id_rsa.pub
```

### GPG 鍵を生成する

(Git のコミットへの署名などに使う。)

```sh
# gpg コマンドをインストールする。 <https://www.gnupg.org/download/>
#   Windows: choco install -y gpg4win

# キーを生成する。(キー長を 4096 ビットにする以外は既定値。ユーザー名は vain0x, メールアドレスは vainzerox@gmail.com)
gpg --full-generate-key

# キー ID を確認する。
# 横棒の次の行、'sec   rsa4096/([A-F0-9]+) 20\d\d-\d\d-\d\d \[SC\]' の $1 部分を $KEY_ID とする。
gpg --list-secret-keys --keyid-format LONG

# キーをエクスポートする。
gpg --armor --export $KEY_ID
```

GitHub の [SSH and GPG keys](https://github.com/settings/keys) で鍵を登録する。

- 参考: <https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/managing-commit-signature-verification>

Git に登録する。

```sh
KEY_ID=$KEY_ID

git config gpg.program gpg
git config --global user.signingkey $KEY_ID
```

### VSCode の設定を同期する

- 拡張機能 Settings Sync をインストールして、拡張機能の設定を開く
- GitHub の Personal Access Token を生成する
    - [Personal Access Token を生成するページ](https://github.com/settings/tokens)
    - Gist の権限だけつける
- Gist URL を設定する
    - [Gist](https://gist.github.com/vain0x)

## その他

- Firefox のアカウントにログイン
- Thunderbird にメールアカウントを追加
- Clementine のインストール
    - 音楽ファイルなどの配置
