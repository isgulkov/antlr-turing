java -jar antlr-4.7-complete.jar Turing.g4 -o src
xbuild src/TuringTranslator.sln
mkdir -p ./res
cp src/bin/Debug/* ./res
