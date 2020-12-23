@echo off

set cur_dir=%~dp0

set /p origin_str="置換元となる文字列を入力してください： "
set /p rename_str="置換する文字列を入力してください： "

echo [%origin_str%] を [%rename_str%] へ変換します。

pause

mkdir "%cur_dir%copy_dist\"
copy /y "%cur_dir%" "%cur_dir%copy_dist\"

setlocal enabledelayedexpansion

for /f "usebackq delims=" %%a in (`dir /b /n "%cur_dir%"`) do (
    set origin_file="%%a"
    set rename_file=!origin_file:%origin_str%=%rename_str%!
    echo rename detail... !origin_file! -^> !rename_file!

    pause

    rename %cur_dir%!origin_file! !rename_file!
)

endlocal