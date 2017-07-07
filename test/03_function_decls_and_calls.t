
function c () : int
	put "c will return", 7
	result 7
end c

function a () : int
	put "b returned ", b()
	put "a will return ", 14
	result 14
end a

function b () : int
	put "c returned ", c()
	put "b will return ", 88
	result 88
end b

put "a returned ", a()
