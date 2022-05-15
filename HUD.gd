extends CanvasLayer

signal start_game


func update_timer(number):
	$Time.text = str(number)

func update_ship_number(number):
	$ShipNumber.text = str(number)

func update_health(health):
	$Health.text = str(health)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("You Lost!")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$Message.text = "Destroy the Red ships.\nFind the treasure.\nEnjoy!"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func show_game_won():
	show_message("You Won!")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$Message.text = "Destroy the Red ships.\nFind the treasure.\nEnjoy!"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
