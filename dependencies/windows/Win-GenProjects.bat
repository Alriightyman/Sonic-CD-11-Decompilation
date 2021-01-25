@echo off
pushd ..\..\
call .\dependencies\windows\Premake5\executable\premake5.exe vs2019
popd
pause