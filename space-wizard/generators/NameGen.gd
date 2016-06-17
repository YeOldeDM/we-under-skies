
extends Node

var choices = []

func _rand(m=1,M=10):
	return int(round(rand_range(m,M)))


func _get_choice():
	var R = _rand(0,choices.size()-1)
	return choices[R]

func _get_slice(name, from_right=false):
	var len = name.length()
	var slice_point = len/2
	if len > 4:
		slice_point = _rand(len/3,len/2)
	if from_right:
		return name.right(slice_point)
	else:
		return name.left(slice_point)
		

func MakeName():
	var names = _rand(1,4)
	if names > 2:
		names -= _rand(1,2)
	var name = ""
	for i in range(names):
		name += _get_name()
		if i != names:
			name += " "

	var N = ""
	if randf() < 0.3:
		N = str(_rand(1,100))+" "
	
	return N+name

func _get_name():
	var N1 = _rand(0,choices.size()-1)
	var N2 = null
	var go = false
	while !go:
		var N2try = _rand(0,choices.size()-1)
		if N2try != N1:
			N2 = N2try
			go = true
	
	
	var name1 = choices[N1]
	var name2 = choices[N2]
	
	name1 = _get_slice(_get_choice())
	
	name2 = _get_slice(_get_choice(),true)
	

	return (name1+name2).capitalize()


