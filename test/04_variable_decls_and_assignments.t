

function a(a : int) : int
	var x : int

	x := a + 10

	put "Variable x declared inside function a equals ", x

	result x + 25
end a

var x : int

x := a(100)

put "Variable x declared in the outer scope equals ", x

