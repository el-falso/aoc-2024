extends Node2D

var reports: Array[PackedInt32Array] = []

var reports_safety: Array[bool] = []

func _ready() -> void:
	# Fill boths list from input file
	var file := FileAccess.open("res://Days/day_2/day_2.txt", FileAccess.READ)
	var error := FileAccess.get_open_error()
	if error != OK:
		print("Couldn't read file: ", error)
		return
	
	var file_string := file.get_as_text()
	while not file.eof_reached():
		var line := file.get_line()
		var report := PackedInt32Array(Array(line.split(" ", false)))
		if not report.is_empty():
			reports.append(report)
			var is_safe := is_report_save(report)
			reports_safety.append(is_safe)
		
	print("%d report are safe." % reports_safety.count(true))

func is_report_save(report: PackedInt32Array) -> bool:
	var is_save := false
	is_save = is_report_in_limit(report) and (is_report_all_increasing(report) or is_report_all_decreasing(report))
	return is_save


func is_report_all_increasing(report: PackedInt32Array)-> bool:
	var is_increasing := true
	for index: int in report.size()-1:
		if report[index+1] < report[index]:
			is_increasing = is_increasing and false
	return is_increasing


func is_report_all_decreasing(report: PackedInt32Array)-> bool:
	var is_decreasing := true
	for index: int in report.size()-1:
		if report[index+1] > report[index]:
			is_decreasing = is_decreasing and false
	return is_decreasing


func is_report_in_limit(report: PackedInt32Array)-> bool:
	var is_in_limit := true
	for index: int in report.size()-1:
		if abs(report[index] - report[index+1]) < 1 or abs(report[index] - report[index+1]) > 3:
			is_in_limit = is_in_limit and false
	return is_in_limit
