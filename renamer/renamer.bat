@echo on
chcp 65001

rem バッチの実行ディレクトリを取得する
set cur_dir=%~dp0

rem ********************
rem メイン前処理
rem ********************
rem 置換前後の文字列を取得する

set /p origin_str="置換前の文字列を入力してください： "
set /p rename_str="置換後の文字列を入力してください： "

echo "[%origin_str%] を [%rename_str%] へ変換します。"

pause

rem 入力文字列の不正値チェックを行う
call :input_check "%origin_str%"
call :input_check "%rename_str%"

rem ********************
rem メイン処理
rem ********************
rem 閉じ丸括弧はファイル名でもよく使用しそうなため、
rem 置換時にエスケープされるように変換しておく
set origin_str=%origin_str:)=^^)%
set rename_str=%rename_str:)=^^)%

rem バックアップ用のディレクトリ作成
mkdir "%cur_dir%backup\%DATE:/=%\"
copy /y "%cur_dir%*.*" "%cur_dir%backup\%DATE:/=%\"

rem バッチ実行時の同階層ディレクトリを置換対象とする
setlocal enabledelayedexpansion

for /f "usebackq delims=" %%a in (`dir /b /n /A-D "%cur_dir%*.*"`) do (
    set origin_file="%%a"
    rem 置換処理
    set rename_file=!origin_file:%origin_str%=%rename_str%!
    echo rename detail... !origin_file! -^> !rename_file!
    pause

    rename %cur_dir%!origin_file! !rename_file!
)
endlocal
goto end

rem ********************
rem 入力不正値チェック
rem ********************
:input_check %1
echo %1 | findstr "[|&^/?<>\*]"
if "%errorlevel%"=="0" goto input_error


rem ********************
rem 入力不正値エラー出力
rem ********************
:input_error
echo 入力した文字列内に不正な文字が入力されています。
goto end

:end
exit /b %errorlevel%