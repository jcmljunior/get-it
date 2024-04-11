class_name GetIt extends Object


var store := []


func _init(cache: Array = []) -> void:
	store = cache


func _get(property: StringName) -> Variant:
	if not property.begins_with("_"):
		match property:
			"store_item":
				return get_store_item

			"store_list":
				return get_store_list


	return get(property)


func register(name: String, value: Variant, args: Dictionary = {}) -> Variant:
	var response := Collection.find.call(store, "name", name) as Array
	var index := store.size()

	if response.size():
		printerr("Oppss, %s ja foi definido." % [ name ])
		return


	store.append({
		"name": name,
		"value": value,
	})


	if args.size():
		store[index] = Collection.shallow_merge(store[index], args)


	return value


func unregister(name: String) -> void:
	var response := Collection.find.call(store, "name", name) as Array

	if not response.size():
		printerr("Oppss, %s nao existe." % [ name ])
		return


	store.remove_at(response.pop_front())


func get_store_item(name: String) -> Variant:
	var response := Collection.find.call(store, "name", name) as Array

	if not response.size():
		printerr("Oppss, %s nao existe." % [ name ])
		return


	return store[response.pop_front()]


func get_store_list() -> Array:
	return store
