extends Node2D

var png_destination : String = "res://images/merged_tile.png"

func take_screenshot():
	var image = $SVContainer/SubViewport.get_viewport().get_texture().get_image()
	image.save_png(png_destination)
	print("Saved image to project at path: " + str(png_destination))
