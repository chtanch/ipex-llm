@echo off
REM activate conda environment and run script from .\benchmark\

set CWD=%cd%

@REM Prep output folder
set OUTPUT_DIR=%cd%\results\%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
mkdir "%OUTPUT_DIR%"

@REM Ensure no csv files in all-in-one folder
cd ..\python\llm\dev\benchmark\all-in-one
if exist *.csv (
    echo csv file exists in all-in-one folder. Stopping.
    exit /b 1
)
cd %CWD%

@REM set environment variables
set "SYCL_CACHE_PERSISTENT=1"
set "BIGDL_LLM_XMX_DISABLED=1"
@REM "set IPEX_LLM_QUANTIZE_KV_CACHE=1"

@REM save files
copy run-mtl.bat "%OUTPUT_DIR%"
pip list > "%OUTPUT_DIR%\requirements.txt"

@REM Run benchmarks
@REM transformers==4.34.0
python -m pip install transformers==4.34.0
copy config_434.yaml ..\python\llm\dev\benchmark\all-in-one\config.yaml
copy config_434.yaml "%OUTPUT_DIR%"
cd ..\python\llm\dev\benchmark\all-in-one
python run.py
move *.csv "%OUTPUT_DIR%"
cd %CWD%

@REM @REM transformers==4.38.0
python -m pip install transformers==4.38.0
copy config_438.yaml ..\python\llm\dev\benchmark\all-in-one\config.yaml
copy config_438.yaml "%OUTPUT_DIR%"
cd ..\python\llm\dev\benchmark\all-in-one
python run.py
move *.csv "%OUTPUT_DIR%"
cd %CWD%

@REM @REM transformers==4.39.0
python -m pip install transformers==4.39.0
python -m pip install trl
copy config_439.yaml ..\python\llm\dev\benchmark\all-in-one\config.yaml
copy config_439.yaml "%OUTPUT_DIR%"
cd ..\python\llm\dev\benchmark\all-in-one
python run.py
move *.csv "%OUTPUT_DIR%"
cd %CWD%

@REM @REM transformers==4.40.0
python -m pip install transformers==4.40.0
copy config_440.yaml ..\python\llm\dev\benchmark\all-in-one\config.yaml
copy config_440.yaml "%OUTPUT_DIR%"
cd ..\python\llm\dev\benchmark\all-in-one
python run.py
move *.csv "%OUTPUT_DIR%"
cd %CWD%

@REM concatenate all csv files and save them to concatenated_output.csv
python concat_csv.py -i "%OUTPUT_DIR%"