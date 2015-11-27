
extends Node

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

func randomChoiceIndex(chances):
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

func randomChoice(chances_dict):
	var strings = chances_dict.keys()
	var chances = []
	for key in chances_dict:
		chances.append(chances_dict[key])
	return strings[randomChoiceIndex(chances)]

func makeSyllable(style):
	#print('making syllable..')
	var syllable = ""
	if style <= 6:
		syllable += randomChoice(consonants)
		syllable += randomChoice(vowels)
	elif style <= 8:
		syllable += randomChoice(vowels)
		syllable += randomChoice(consonants)
	else:
		syllable += randomChoice(vowels)
	return syllable
		
func makeWord(length):
	#prints('making word..',length)
	var word = ""
	for i in range(length):
		word += makeSyllable(int(rand_range(0,11)))
	return word.capitalize()

func makeName(length=1, minSyl=1, maxSyl=4):
	#prints("making name..",length)
	var name = ""
	if length < 2:
		minSyl = max(int(rand_range(3,5)),minSyl) #don't make one-word names too short
		
	for i in range(length):
		name += makeWord(int(rand_range(minSyl,maxSyl))) + " "
	return name

#func _ready():
#	for i in range(10):
#		randomize()
#		var nick = makeName(int(rand_range(1,4)))
#		print(nick)
