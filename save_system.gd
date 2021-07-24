class_name EzSaveSystem
# Make sure the directory starts with "user://"
# to get a persistent data path across all platforms


static func save(data, directory := "user://saves/", file_name := "save", 
		extension := ".sav", password := "PASSWORD") -> void:
	
	var dir := Directory.new()
	var path := directory + file_name + extension
	var file := File.new()
	
	if not directory_exists(directory):
		dir.make_dir_recursive(directory)

	var error := file.open_encrypted_with_pass(path, File.WRITE, password)
	if error == OK:
		file.store_string(var2str(data))
		file.close()


static func load(directory := "user://saves/", file_name := "save",
		extension := ".sav", password := "PASSWORD"):
	var path = directory + file_name + extension
	var file := File.new()
	if file_exists(directory, file_name, extension):
		var error := file.open_encrypted_with_pass(path,
			File.READ, password)
		if error == OK:
			var data = str2var(file.get_as_text())
			file.close()
			return data
	else:
		# File does not exist
		return null


static func file_exists(directory := "user://saves/", file_name := "save",
	extension := ".sav") -> bool:
	var file := File.new()
	return file.file_exists(directory + file_name + extension)


static func directory_exists(directory := "user://saves/") -> bool:
	var dir := Directory.new()
	return dir.dir_exists(directory)

