extends Node2D

var location_list_one: PackedInt32Array = []
var location_list_two: PackedInt32Array = []
var distance_list: PackedInt32Array = []
var similarity_list: PackedInt32Array = []

func _ready() -> void:
	# Fill boths list from input file
	var file := FileAccess.open("res://Days/day_1/day_1.txt", FileAccess.READ)
	var error := FileAccess.get_open_error()
	if error != OK:
		print("Couldn't read file: ", error)
		return
	
	var file_string := file.get_as_text()
	while not file.eof_reached():
		var line := file.get_line()
		var line_split := line.split("   ", false)
		if not line_split.is_empty():
			location_list_one.append(line_split[0].to_int())
			location_list_two.append(line_split[1].to_int())
	
	# Sort both Lists
	location_list_one.sort()
	location_list_two.sort()
	
	#region Part I
	# Get distance between elements with the same index of both lists
	# Push result into distance list
	if location_list_one.size() != location_list_two.size():
		print("Sizes of both lists don't match!")
		return
	for index: int in location_list_one.size():
		var absolute_difference := absi(location_list_one[index] - location_list_two[index])
	
		distance_list.append(absolute_difference)
	
	# Sum up all the elements in the distance list for the total distance 
	print("Total Distance: %s" % sum_array(distance_list))
	#endregion


	#region Part II
	var location_list_one_dup := Array(location_list_one.duplicate())
	while not location_list_one_dup.is_empty():
		var first_element: int = location_list_one_dup.pop_front()
		for num: int in location_list_one_dup.count(first_element):
			var index := location_list_one_dup.rfind(first_element)
			location_list_one.remove_at(index)
	
		var multiplier := location_list_two.count(first_element)
		similarity_list.append(first_element * multiplier)
	
	print("Similarity Score: %s" % sum_array(similarity_list))
	#endregion

func sum_array(array: PackedInt32Array) -> int:
	var sum := 0
	for element: int in array:
		sum += element
	return sum
