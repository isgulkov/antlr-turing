mkdir -p ./test/compiled
for in_file in $(ls -1 ./test | grep .t)
do
	out_file="${in_file%.*}".cs
	mono ./res/TuringTranslator.exe ./test/$in_file ./test/compiled/$out_file 2> /dev/null
	mcs ./test/compiled/$out_file 2> /dev/null
	exe_file="${in_file%.*}".exe
	mono ./test/compiled/$exe_file
	echo
done
# rm -f ./test/compiled/*.cs ./test/compiled/*.exe