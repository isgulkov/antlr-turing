

var x : int
var y : int
var z : int

x := 1337
y := 1337
z := 1338


put "x: ", x
put "y: ", y
put "z: ", z

if x = y then
	put "Variable x equals y (expected)"
else
	put "Variable x doesn't equal y (unexpected)"
end if

if x = z then
	put "Variable x equals z (unexpected)"
else
	put "Variable x doesn't equal z (expected)"
end if

if x = 1336 then
	put "Variable x equals ", 1336, " (unexpected)"
else
	put "Variable x doesn't equal ", 1336, " (expected)"
end if

if x = 1337 then
	put "Variable x equals ", 1337, " (expected)"
else
	put "Variable x doesn't equal ", 1337, " (unexpected)"
end if

if x = 1337 + 10 then
	put "Variable x equals 1337 + 10 (unexpected)"
else
	put "Variable x doesn't equal 1337 + 10 (expected)"
end if


