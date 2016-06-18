
extends Node

var choices = [ "acamar", "achernar", "achird", "acrux", "acubens", "adara", "adhafera", "adhil", "agena", "ain", "rami", "ain", "anz", "kalb", "rai", "minliar", "asad", "minliar", "shuja", "al", "aladfar", "alathfar", "albaldah", "albali", "albireo", "alchiba", "alcor", "alcyone", "aldebaran", "alderamin", "aldhibah", "alfecca", "meridiana", "alfirk", "algenib", "algieba", "algol", "algorab", "alhena", "alioth", "alkaid", "alkalurops", "alkes", "alkurhah", "almaak", "alnair", "alnath", "alnilam", "alnitak", "alniyat", "alniyat", "alphard", "alphekka", "alpheratz", "alrai", "alrisha", "alsafi", "alsciaukat", "alshain", "alshat", "alsuhail", "altair", "altarf", "alterf", "aludra", "alula", "australis", "alula", "borealis", "alya", "alzirr", "ancha", "angetenar", "ankaa", "anser", "antares", "arcturus", "arkab", "posterior", "arkab", "prior", "arneb", "arrakis", "ascella", "asellus", "australis", "asellus", "borealis", "asellus", "primus", "asellus", "secondus", "asellus", "tertius", "asterope", "atik", "atlas", "auva", "avior", "azelfafage", "azha", "azmidiske", "baham", "baten", "kaitos", "becrux", "beid", "bellatrix", "betelgeuse", "botein", "brachium", "canopus", "capella", "caph", "castor", "cebalrai", "celaeno", "chara", "chort", "cor", "caroli", "cursa", "dabih", "deneb", "algedi", "dulfim", "okab", "shemali", "deneb", "denebola", "dheneb", "diadem", "diphda", "dschubba", "dsiban", "dubhe", "asich", "electra", "elnath", "enif", "etamin", "fomalhaut", "fornacis", "fum", "samakah", "furud", "gacrux", "gianfar", "gienah", "cygni", "gienah", "gomeisa", "gorgonea", "gorgonea", "gorgonea", "graffias", "grafias", "grumium", "hadar", "haedi", "hamal", "hassaleh", "hydrus", "herschel", "heze", "hoedus", "homam", "hyadum", "izar", "jabbah", "kaffaljidhma", "kajam", "kaus", "meridionalis", "keid", "kitalpha", "kocab", "kornephoros", "kraz", "kuma", "lesath", "maasym", "maia", "marfak", "marfak", "marfic", "marfik", "markab", "matar", "mebsuta", "megrez", "meissa", "mekbuda", "menkalinan", "menkar", "menkar", "menkent", "menkib", "merak", "merga", "merope", "mesarthim", "metallah", "miaplacidus", "minkar", "mintaka", "mira", "mirach", "miram", "mirphak", "mizar", "mufrid", "muliphen", "murzim", "muscida", "muscida", "muscida", "nair", "saif", "naos", "nash", "nashira", "nekkar", "nihal", "nodus", "secundus", "nunki", "nusakan", "peacock", "phad", "phaet", "pherkad", "minor", "pherkad", "pleione", "polaris", "pollux", "porrima", "praecipua", "prima ", "giedi", "procyon", "propus", "propus", "propus", "rana", "ras", "elased", "rasalgethi", "rasalhague", "rastaban", "regulus", "rigel", "kentaurus", "rijl", "awwa", "rotanev", "ruchba", "ruchbah", "rukbat", "sabik", "sadalachbia", "sadalmelik", "sadalsuud", "sadr", "saiph", "salm", "sargas", "sarin", "sceptrum", "scheat", "secunda", "segin", "seginus", "sham", "sharatan", "shaula", "shedir", "sheliak", "sirius", "situla", "skat", "spica", "sterope", "sualocin", "subra", "suhail", "muhlif", "sulafat", "syrma", "tabit", "talitha", "tania", "tarazed", "taygeta", "tegmen", "tejat", "terebellum", "thabit", "theemim", "thuban", "torcularis", "septentrionalis", "turais", "tyl", "unukalhai", "vega", "vindemiatrix", "wasat", "wezen", "wezn", "yed", "yildun", "zaniah", "zaurak", "zavijah", "zibal", "zosma", "zuben", "elakrab", "elakribi", "elgenubi", "elschemali" ]


#func _ready():
#	var cfg = ConfigFile.new()
#	# Star Names provided by:
#	# http://www.astro.wisc.edu/~dolan/constellations/starname_list.html
#	cfg.load('res://starnames.ini')
#	choices = cfg.get_value('STARS','names')

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
	var name = "p"
	for i in range(names):
		if i == 0:
			name = _get_name()
		else:
			name += _get_name()
		if i != names:
			name += " "
	return name

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


