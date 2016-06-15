
extends Node

# Constants
const LOG_STAR = 0
const LOG_WORLD = 1
const LOG_PLANT = 2
const LOG_ANIMAL = 3

var collection = [
		[],
		[],
		[],
		[],
		]

func add_discovery( item, ID ):
	collection[ID].append(item)


