extends Node


var default := func(cache: Array) -> Dictionary:
	return {
		"register": func(name: String, value: Variant) -> Variant:
			var check := Collection.find.call(cache, "name", name) as Array

			if check.size():
				printerr("Oppss, %s - cache[%s] ja existe." % [ name, check.pop_front() ])
				return


			cache.append({
				"name": name,
				"value": value,
			})


			return get_instance.call(cache),


		"unregister": func(name: String) -> bool:
			var check := Collection.find.call(cache, "name", name) as Array

			if not check.size():
				return false

			cache.remove_at(check.pop_front())

			return true,


		"get_store_list": func() -> Array:
			return cache,


		"get_store_item": func(name: String) -> Dictionary:
			var response := Collection.find.call(cache, "name", name) as Array

			if not response.size():
				return {}


			return cache[response.pop_front()],
	}


var get_instance := func(cache: Array = []) -> Dictionary:
	return default.call(cache)
