extends Node
var db: SQLite

func _init() -> void:
	db = SQLite.new()
	db.path = "res://data.db"
	db.open_db()
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		db.close_db()
	
