function factorial (n: int) : int
	if n = 0 then
		result 1
	else
		result n * factorial (n - 1)
	end if
end factorial

var n: int

n := 7

put "Value of N : ", n
put "The factorial of ", n, " is ", factorial (n)
