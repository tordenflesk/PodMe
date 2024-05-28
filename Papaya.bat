@echo off
chcp 65001
for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G
set year2=%datetime:~2,2%
set year4=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set name=%year4%-%month%-%day%
pushd E:\Repo\Podme
echo.>> papaya.m3u
echo|set /p="#EXTINF: -1 , %year2%-%month%-%day% - %~2" >> papaya.m3u
echo.>> papaya.m3u
echo|set /p="%~1" >> papaya.m3u
pause
call _Podme_M3U_Update.bat
yt-dlp --concurrent-fragments 8 --no-overwrites %1 --exec r128gain -o "%TEMP%\%name%.m4a"
neroAacTag "%TEMP%\%name%.m4a" -meta:title="%~2" -meta:artist="Steinar Sagen, Tore Sagen og Bjarte Paul Tjøstheim" -meta:year="%year4%" -meta:album="Papaya" -meta:genre="Podcast" -meta:comment="Tre fete typer prøver seg i det private næringsliv" -add-cover:front:Papaya.jpg
REM RoboCopy.exe "%TEMP%" "F:\Podcast_Archive\PodMe\Papaya" %name%.m4a /MT:8 /COPY:DT
RoboCopy.exe "%TEMP%" "E:\Podcasts\Downloads\Papaya" %name%.m4a /MOV /MT:8 /COPY:DT
echo [%year2%-%month%-%day%](%~1) ^| %~2
popd
call;