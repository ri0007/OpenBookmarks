# OpenBookmarks
yamlで記述されたブックマークを開けるプログラム
## Install
`~/bin`にインストールする場合  
```bash
cd ~   
git clone https://github.com/ri0007/OpenBookmarks/  
mkdir bin  
mv ~/OpenBookmarks/* ~/bin  
echo 'alias obm="ruby ~/bin/OpenBookmarks.rb"' >> ~/.bash_profile 
source ~/.bash_profile  
```
## Usege
Bookmarks.ymlに記述する
```yaml
# Bookmarks.yml
google: "https://www.google.com/"
apple: "http://www.apple.com/"

work:
  google:
    mail: "https://mail.google.com/"
    drive: "https://drive.google.com/"
  github: "https://github.com"
```

コマンドを実行する
```bash
obm apple
# => ブラウザで"http://www.apple.com/"が開かれる
obm work
# => ブラウザでwork以下のURLが全て開かれる
```

## Options
```bash
obm -a
# => ブラウザでBookmarks.ymlのURL全てが開かれる
obm -l
# => Bookmarks.ymlの内容が表示される
obm -c apple
# => Chromeで"http://www.apple.com/"が開かれる
obm -s apple
# => Safariで"http://www.apple.com/"が開かれる
```
