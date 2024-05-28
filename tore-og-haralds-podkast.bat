@echo off
chcp 65001
for /f "tokens=2 delims==" %%G in ('wmic os get localdatetime /value') do set datetime=%%G
set year2=%datetime:~2,2%
set year4=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set name=%year4%-%month%-%day%
pushd E:\Repo\Podme
echo.>> tore-og-haralds-podkast.m3u
echo|set /p="#EXTINF: -1 , %year2%-%month%-%day% - %~2" >> tore-og-haralds-podkast.m3u
echo.>> tore-og-haralds-podkast.m3u
echo|set /p="%~1" >> tore-og-haralds-podkast.m3u
pause
call _Podme_M3U_Update.bat
yt-dlp --concurrent-fragments 8 --no-overwrites %1 --exec r128gain -o "%TEMP%\%name%.m4a"
neroAacTag "%TEMP%\%name%.m4a" -meta:title="%~2" -meta:artist="Tore Sagen og Harald Eia" -meta:year="%year4%" -meta:album="Tore og Haralds podkast" -meta:genre="Podcast" -meta:comment="Tore Sagen og Harald Eia drøfter etikk og nye perspektiver." -add-cover:front:tore-og-haralds-podkast.jpg
REM RoboCopy.exe "%TEMP%" "F:\Podcast_Archive\PodMe\Tore og Haralds podkast" %name%.m4a /MT:8 /COPY:DT
RoboCopy.exe "%TEMP%" "E:\Podcasts\Downloads\Tore og Haralds podkast" %name%.m4a /MOV /MT:8 /COPY:DT
echo [%year2%-%month%-%day%](%~1) ^| %~2
popd
call;