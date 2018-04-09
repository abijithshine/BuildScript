IF "%1"=="" echo "Need Sql Src Folder path"
IF "%2"=="" echo "Need Sql Build Folder path"

set SRC_LOC=%1
set BUILD_LOC=%2

echo "Checking for source files...."

if not exist %SRC_LOC% (
	echo "Source file is expected at %SRC_LOC%"
	exit /b
)

echo "Starting Wrap Process...."

call :WRAP %SRC_LOC%
call :WRAP %SRC_LOC%\rep
call :WRAP %SRC_LOC%\Statistics
call :WRAP %SRC_LOC%\DataConverter
call :WRAP %SRC_LOC%\updates\Martab\AssetService
call :WRAP %SRC_LOC%\updates\sc\r2
call :WRAP %SRC_LOC%\updates\sc\r2integr8
call :WRAP %SRC_LOC%\updates\sc\Nav
call :WRAP %SRC_LOC%\updates\sc\Dataconversion\Retire_Nonserial
call :WRAP %SRC_LOC%\updates\sc\Dataconversion\Retire_Serial
call :WRAP %SRC_LOC%\updates\sc\Dataconversion\Scgl_Group_Category_InvSubCategory_DataConverter
call :WRAP %SRC_LOC%\updates\AXIA
call :WRAP %SRC_LOC%\updates\Bexel\AccPac
call :WRAP %SRC_LOC%\updates\Solotech\Integration
call :WRAP %SRC_LOC%\updates\Solotech\MarkMissingAssetAsLost
call :WRAP %SRC_LOC%\updates\XLvideo
call :WRAP %SRC_LOC%\updates\XLvideo\AP
call :WRAP %SRC_LOC%\updates\XLvideo\AR

echo "Wrap Process completed..."

cd %BUILD_LOC%

md %BUILD_LOC%\sqls
xcopy %SRC_LOC%\*.plb %BUILD_LOC%\sqls\ /s/r
xcopy %SRC_LOC%\*.txt %BUILD_LOC%\sqls\ /s/r
xcopy %SRC_LOC%\updateinvserial2.sql %BUILD_LOC%\sqls\ /s/r
xcopy %SRC_LOC%\updateinvserial3.sql %BUILD_LOC%\sqls\
xcopy %SRC_LOC%\drop.sql %BUILD_LOC%\sqls\ /s/r
xcopy %SRC_LOC%\sanitycheck.sql %BUILD_LOC%\sqls\ /s/r

del %BUILD_LOC%\sqls\drop.plb
del %BUILD_LOC%\sqls\sanitycheck.plb
del %BUILD_LOC%\sqls\sanitycheck2.plb
del %BUILD_LOC%\sqls\r2run.plb
del %BUILD_LOC%\sqls\updateinvserial2.plb
del %BUILD_LOC%\sqls\updateinvserial3.plb

REM xcopy r2\mantra\sqls\twhbuild.bat sqls\ /s/r
REM xcopy c:\r2\mantra\sqls\updatemwh.bat sqls\ /s/r
REM xcopy c:\r2\mantra\sqls\createmwhimportdmp.bat sqls\ /s/r
REM xcopy c:\r2\mantra\sqls\createtwhexportdmp.bat sqls\ /s/r
md %BUILD_LOC%\sqls\updates
xcopy %SRC_LOC%\updates\*.* /y %BUILD_LOC%\sqls\updates\
xcopy %SRC_LOC%\updates\Martab\AssetService\*.bat /y %BUILD_LOC%\sqls\updates\Martab\AssetService\
xcopy %SRC_LOC%\updates\Martab\AssetService\*.ctl /y %BUILD_LOC%\sqls\updates\Martab\AssetService\

del %BUILD_LOC%\sqls\updates\SC\DataConversion\*.plb
del %BUILD_LOC%\sqls\updates\SC\DataConversion\*.txt
del %BUILD_LOC%\sqls\updates\SC\*.txt

md %BUILD_LOC%\sqls\DataConverter
xcopy %SRC_LOC%\DataConverter\*.* /y %BUILD_LOC%\sqls\dataconverter\ /s/r

del %BUILD_LOC%\sqls\dataconverter\*.sql

md %BUILD_LOC%\sqls\ProductUtlMetrics
xcopy %SRC_LOC%\Updates\metrics\*.bat /y %BUILD_LOC%\sqls\ProductUtlMetrics\ /s/r
xcopy %SRC_LOC%\Updates\metrics\ProcedureExecution.sql /y %BUILD_LOC%\sqls\ProductUtlMetrics\ /s/r
xcopy %SRC_LOC%\Updates\metrics\ProcedureExecution1.sql /y %BUILD_LOC%\sqls\ProductUtlMetrics\ /s/r
xcopy %SRC_LOC%\Updates\metrics\*.doc /y %BUILD_LOC%\sqls\ProductUtlMetrics\ /s/r

md %BUILD_LOC%\sqls\CIDMaster
xcopy %SRC_LOC%\CIDmaster\*.xls %BUILD_LOC%\sqls\CIDMaster\

md %BUILD_LOC%\sc_sqls
md %BUILD_LOC%\sc_sqls\r2
md %BUILD_LOC%\sc_sqls\r2integr8
xcopy %SRC_LOC%\updates\sc\r2\*.plb  %BUILD_LOC%\sc_sqls\r2\ 
xcopy %SRC_LOC%\updates\sc\r2\*.txt %BUILD_LOC%\sc_sqls\r2\
xcopy %SRC_LOC%\updates\sc\r2integr8\*.plb %BUILD_LOC%\sc_sqls\r2integr8
xcopy %SRC_LOC%\updates\sc\r2integr8\*.txt %BUILD_LOC%\sc_sqls\r2integr8
xcopy %SRC_LOC%\updates\sc\*.txt %BUILD_LOC%\sc_sqls\

md %BUILD_LOC%\sc_NAV_sqls
xcopy %SRC_LOC%\updates\sc\nav\*.plb %BUILD_LOC%\sc_NAV_sqls\
xcopy %SRC_LOC%\updates\sc\nav\*.txt %BUILD_LOC%\sc_NAV_sqls\
xcopy %SRC_LOC%\updates\sc\nav\*.bat %BUILD_LOC%\sc_NAV_sqls\

md %BUILD_LOC%\sqls\updates\SC
md %BUILD_LOC%\sqls\updates\SC\Dataconversion
md %BUILD_LOC%\sqls\updates\SC\DataConversion\Retire_Nonserial
md %BUILD_LOC%\sqls\updates\SC\DataConversion\Retire_Serial
md %BUILD_LOC%\sqls\updates\SC\DataConversion\Scgl_Group_Category_InvSubCategory_DataConverter

xcopy %SRC_LOC%\updates\sc\DataConversion\Retire_Nonserial\*.* /y %BUILD_LOC%\sqls\updates\SC\DataConversion\Retire_Nonserial\ /s/r
xcopy %SRC_LOC%\updates\sc\DataConversion\Retire_Serial\*.* /y %BUILD_LOC%\sqls\updates\SC\DataConversion\Retire_Serial\ /s/r
xcopy %SRC_LOC%\updates\sc\DataConversion\Scgl_Group_Category_InvSubCategory_DataConverter\*.* /y %BUILD_LOC%\sqls\updates\SC\DataConversion\Scgl_Group_Category_InvSubCategory_DataConverter\ /s/r

del %BUILD_LOC%\sqls\updates\SC\DataConversion\Retire_Serial\*.sql
del %BUILD_LOC%\sqls\updates\SC\DataConversion\Retire_Nonserial\*.sql
del %BUILD_LOC%\sqls\updates\SC\DataConversion\Scgl_Group_Category_InvSubCategory_DataConverter\*.sql

md %BUILD_LOC%\xlvideo_sqls
xcopy %SRC_LOC%\updates\XLvideo\*.plb %BUILD_LOC%\xlvideo_sqls\
xcopy %SRC_LOC%\updates\XLvideo\*.txt %BUILD_LOC%\xlvideo_sqls\
xcopy %SRC_LOC%\updates\XLvideo\*.bat %BUILD_LOC%\xlvideo_sqls\

md %BUILD_LOC%\Solotech_sqls
xcopy %SRC_LOC%\updates\Solotech\Integration\*.txt %BUILD_LOC%\Solotech_sqls\
xcopy %SRC_LOC%\updates\Solotech\Integration\*.plb %BUILD_LOC%\Solotech_sqls\


md %BUILD_LOC%\sqls\updates\Solotech\MarkMissingAssetAsLost
xcopy %SRC_LOC%\updates\Solotech\MarkMissingAssetAsLost\*.txt %BUILD_LOC%\sqls\updates\Solotech\MarkMissingAssetAsLost\
xcopy %SRC_LOC%\updates\Solotech\MarkMissingAssetAsLost\*.docx %BUILD_LOC%\sqls\updates\Solotech\MarkMissingAssetAsLost\


md %BUILD_LOC%\AXIA_sqls
xcopy %SRC_LOC%\updates\AXIA\*.plb %BUILD_LOC%\AXIA_sqls\
xcopy %SRC_LOC%\updates\AXIA\*.txt %BUILD_LOC%\AXIA_sqls\
xcopy %SRC_LOC%\updates\AXIA\*.bat %BUILD_LOC%\AXIA_sqls\
xcopy %SRC_LOC%\updates\AXIA\*.p7b %BUILD_LOC%\AXIA_sqls\

md %BUILD_LOC%\Bexel_ACCPAC_sqls
xcopy %SRC_LOC%\updates\Bexel\AccPac\*.plb %BUILD_LOC%\Bexel_ACCPAC_sqls\
xcopy %SRC_LOC%\updates\Bexel\AccPac\*.txt %BUILD_LOC%\Bexel_ACCPAC_sqls\
xcopy %SRC_LOC%\updates\Bexel\AccPac\*.bat %BUILD_LOC%\Bexel_ACCPAC_sqls\

rd/s/q %BUILD_LOC%\sqls\updates\XLVideo
rd/s/q %BUILD_LOC%\sqls\updates\sc\NAV
rd/s/q %BUILD_LOC%\sqls\updates\sc\R2
rd/s/q %BUILD_LOC%\sqls\updates\sc\R2INTEGR8
rd/s/q %BUILD_LOC%\sqls\updates\sc\Scripts
rd/s/q %BUILD_LOC%\sqls\updates\avhq
rd/s/q %BUILD_LOC%\sqls\updates\Solotech\Integration
rd/s/q %BUILD_LOC%\sqls\updates\AXIA
rd/s/q %BUILD_LOC%\sqls\updates\Bexel\AccPac

del %SRC_LOC%\*.plb /s

Exit /b

:WRAP
if not exist %~1 (
	echo "Specified path for WRAP not found %~1"
	exit /b
)

cd %~1
for %%k in (*.sql) do wrap iname=%%k
cd %BUILD_LOC%
Exit /b
)
