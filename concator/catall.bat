@echo off
chcp 65001
set cur_dir=%~dp0

set /p target_file_pattern="結合対象となるファイル名を入力してください： "
set /p concatted_file_name="結合後のファイル名を入力してください： "

set concat_file=

setlocal enabledelayedexpansion

for /f "usebackq" %%a in (`dir /s /b "%cur_dir%%target_file_pattern%"`) do (

    if "!concat_file!"=="" (
        set concat_file="%%a"
    ) else (
        set concat_file=!concat_file!+"%%a"
    )
)

echo copy !concat_file!  "%cur_dir%%concatted_file_name%">%cur_dir%cmd.txt
copy !concat_file! "%cur_dir%%concatted_file_name%"
pause

endlocal