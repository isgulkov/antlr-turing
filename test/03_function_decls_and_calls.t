
function c () : int
	put "Inside c"
end a

function a () : int
	put "Inside a"
	b()
end a

function b () : int
	put "Inside b"
	c()
end b

a()
