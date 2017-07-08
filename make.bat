java -jar antlr-4.7-complete.jar Turing.g4 -o src
"C:\Program Files\MSBuild\14.0\Bin\MSBuild.exe" src\TuringTranslator.sln
md res /s
xcopy src\bin\Debug\* res /y
