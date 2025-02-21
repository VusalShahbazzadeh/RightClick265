REM @echo off
REM Check if the input argument is provided
if "%~1"=="" (
    echo Error: No file path specified.
    echo Usage: %0 "full_path\file.mp4"
    goto :eof
)

REM Set variables for the input file, directory, name, and extension
set "input=%~1"
set "folder=%~dp1"
set "filename=%~n1"
set "ext=%~x1"

REM Construct the output file name (same folder, name with _Compressed appended)
set "output=%folder%%filename%_Compressed%ext%"

REM Run ffmpeg using the libx265 encoder
ffmpeg -i "%input%" -c:v libx265 "%output%"
