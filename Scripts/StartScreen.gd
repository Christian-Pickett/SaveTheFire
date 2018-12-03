extends Control

func _on_TryAgain_pressed():
    get_tree().change_scene("res://Scenes/Level1.tscn")

func _on_Quit_pressed():
    get_tree().quit()
