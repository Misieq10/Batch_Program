@echo off
echo Hello. You're on the menu. Use the help command to display the available commands.
:menu
set/p "sterownik=>"
if %sterownik%==create goto create
if %sterownik%==in goto inside
if %sterownik%==add goto connect
if %sterownik%==exit goto leave
if %sterownik%==copy goto replicate
if %sterownik%==help goto help
if %sterownik%==path goto place
if %sterownik%==ext goto extension
if %sterownik%==mkdir goto directory
if %sterownik%==rmdir goto deleteDirectory
if %sterownik%==Del goto deleteFile
if %sterownik%==find goto search
if %sterownik%==takeDate goto dateBase
if %sterownik%==download goto dow
:help
echo Commands available:
echo add - combines the character strings of two files. The first file adds to the second.
echo create - creates a file with the specified name.
echo copy- Copies a sequence of characters from one file to another
echo Del - deletes a file, in a given path, with a given extension and name. 
echo ext - define which file type you want to create (.txt, .js, .pptx)
echo exit
echo in - enters a string of characters into the file.
echo mkdir - create directory
echo rmdir - removes the directory with that name.
echo path - paste the path to the folder you want to work in.
echo find - searches the file by its contents
echo takeDate - pulls a name from a line in the database. First you have to execute the command "download"
echo download - takes your name from the database
goto menu
:place
echo give the path to the folder you want to work in.
set/p "path=>"
echo  Your current path is %path%! You're on the menu. Type help to display the commands you get
goto menu
:create
echo Type the name of the file you want to create. The extension is added automatically. You can define it by going to the menu and typing ext
set/p "fileName=>"
echo >%path%\%fileName%.%ext%
echo You created a file named %fileName%.%ext%!You're on the menu. Type help to display the commands you get
goto menu
:deleteFile
echo Type the name of the file you want to delete. This operation can't be undone.
set/p "DeleteFile=>"
Del %path%\%DeleteFile%.%ext%
echo You deleted the file correctly %DeleteFile%.%ext%. You're on the menu. Type help to display the commands you get
goto menu 
:replicate
echo write the name of the first file. The file has an extension %ext%
set/p "copyFile=>"
echo enter the name of the second file. The file has an extension %ext%
set/p "replicateFile=>"
type %path%\%copyFile%.%ext%>>%path%\%replicateFile%.%ext%
echo Copying was successful. You're on the menu. Type help to display the commands you get
goto menu
:inside
echo give the name of the file to which you want to add a string of characters. The file has an extension %ext%
set/p "file=>"
echo give the string of signs to be in %file%.%ext% 
set/p "textInFile=>"
echo %textInFile%>>%path%\%file%.%ext%
echo A string of signs have been introduced recently You're on the menu. Type help to display the commands you get
goto menu
:connect
echo enter the name of the first file from which you want to copy data. The file has an extension %ext%
set/p "firstFile=>"
echo enter the name of the second file to which you want to copy the data. The file has extensions %ext% 
set/p "secondFile=>"
type %path%\%firstFile%.%ext%>>%path%\%secondFile%.%ext%
echo The addition of the sequence of signs was successful. You're on the menu. Type help to display the commands you get
goto menu
:extension
echo Give the extension you want to use. Don't use a dot, just type in the extension you want to use.
set/p "ext=>"
echo Current file type is %ext% . When you create files, copy, edit, you use this extension. 
echo You can change the echo at any time. 
echo You're running the menu. Type help to display the commands you get.
goto menu
:directory
echo Enter the name of the folder you want to create. You create it in the path %path% . 
set/p "mkdir=>"
md %path%\%mkdir%
echo You created the %TF% catalogue. You're on the menu. Type help to display the commands you get
goto menu
:deleteDirectory
echo Enter the name of the folder you want to delete. This operation can't be undone!
set/p "rmdir=>"
rmdir %path%\%rmdir%
echo You've correctly deleted the folder %rmdir%. 
goto menu
:search
echo Enter the string of characters you're looking for. For example, Krakow or Warsaw. The character string must not contain spaces!
set/p "Data=>"
echo Type the letter of the disk in which you want to look for the file. 
set/p "character=>"
findstr /s /i "%Data%" %character%:\*.txt 
goto menu
:dateBase
set line= %path%\linia.txt
set importantLine=
FINDSTR "'" "localpath" > %line%
for /f "tokens=1-5" %%a in (%line%) do (
    set importantLine=%%a %%b %%c %%d %%e
)
set "string=%importantLine%"
set "x=%string:VALUES (= " & set "substring=%"
set "substring=%substring:~0,-3%"
for /f "tokens=1 delims=," %%a in ("%substring%") do (
   set ID=%%a
)
for /F "tokens=2,3 delims='" %%a in ("%substring%") do (
   set Name=%%a
)
for /f "tokens=4 delims='" %%a in ("%substring%") do (
   set Surname=%%a
)
for /f "tokens=6 delims='" %%a in ("%substring%") do (
   set numberBankAccount=%%a
)
echo ID: %ID% > %path%\Dane.txt
echo %ID% is in the file Data.txt %path%
echo name: %Name% >> %path%\Dane.txt
echo %Name% is in the file Data.txt
echo Surname: %Surname% >> %path%\Dane.txt
echo %Surname% is in the file Data.txt
echo Account number: %numberBankAccount% >> %path%\Dane.txt
echo %numberBankAccount% is in the file Data.txt
del %path%\linia.txt
echo You're on the menu. Type help to display the commands you get
goto menu
:dow
set pathToDataBase="localpath"
cd %pathToDataBase%
echo Enter the name of the employee:
set /p nameAndSurname=
mysqldump -u hserwer_baza -p -h sql.serwer.com  database beneficiaries --where="Surname='%nameAndSurname%'" > localpath
cd "localpath"
pause
goto menu
:leave
exit