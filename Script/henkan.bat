echo off
echo テキスト変換を開始します。少しお待ちください。
perl JASWRIC2Himawari.pl "JASWRIC_Participant Survey.txt" JASWRIC_Tagged.txt Scanned > ../Package/Corpora/JASWRIC/corpus.xml
echo 処理が終了しました。エラーが表示されていないか，確認してください。
pause 
