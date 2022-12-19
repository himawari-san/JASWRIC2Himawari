echo off
echo テキスト変換を開始します。
echo perl JASWRIC2Himawari.pl JASWRIC_Participant_Survey.txt JASWRIC_Tagged.txt Scanned ^> corpus.xml
perl JASWRIC2Himawari.pl JASWRIC_Participant_Survey.txt JASWRIC_Tagged.txt Scanned > corpus.xml
echo 処理が終了しました。
pause 
