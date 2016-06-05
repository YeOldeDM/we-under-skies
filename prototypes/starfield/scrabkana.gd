
extends Node


# Letter choices & weights
# Increase letter values to make
# them more likely to be chosen
# (based on Scrabble scores)
var vowels = {
		'a':	10,
		'e':	10,
		'i':	10,
		'o':	9,
		'u':	8}

var consonants = {
		'b':	8,
		'c':	8,
		'd':	9,
		'f':	7,
		'g':	9,
		'h':	7,
		'j':	4,
		'k':	6,
		'l':	9,
		'm':	8,
		'n':	10,
		'p':	8,
		'q':	1,
		'qu':	2,
		'r':	9,
		's':	9,
		't':	10,
		'v':	7,
		'w':	7,
		'x':	3,
		'z':	1,
		'th':	6,
		'ch':	6,
		'sh':	6,
		'rh':	2,
		'ts':	3,
		'ph':	3,
		'pf':	1,
		'xh':	1}

func _random_choice_Index(chances):
	var sum = 0
	for i in chances:
		sum += i
	var dice = int(rand_range(1, sum+1))
	var running_sum = 0
	var choice = 0
	for w in chances:
		running_sum += w
		if dice <= running_sum:
			return choice
		choice += 1

func _random_choice(chances_dict):
	var strings = chances_dict.keys()
	var chances = []
	for key in chances_dict:
		chances.append(chances_dict[key])
	return strings[_random_choice_Index(chances)]

func _make_syllable(style):
	var syllable = ""
	if style <= 6:
		syllable += _random_choice(consonants)
		syllable += _random_choice(vowels)
	elif style <= 8:
		syllable += _random_choice(vowels)
		syllable += _random_choice(consonants)
	else:
		syllable += _random_choice(vowels)
	return syllable
		
func _make_word(length):
	var word = ""
	for i in range(length):
		word += _make_syllable(int(rand_range(0,11)))
	return word.capitalize()


# CALL THIS function to generate a name of length words,
# minSyl minimum syllables, maxSyl maximum syllables
func makeName(length=1, minSyl=1, maxSyl=4):
	var name = ""
	if length < 2:
		minSyl = max(int(rand_range(3,5)),minSyl) #don't make one-word names too short
		
	for i in range(length):
		name += _make_word(int(rand_range(minSyl,maxSyl))) + " "
	return name

