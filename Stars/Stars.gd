extends Node2D


var yellow_star = preload("res://yellow_star.tscn")
var red_star = preload("res://red_star.tscn")
var blue_star = preload("res://blue_star.tscn")
var white_dwarf = preload("res://white_dwarf.tscn")
var black_hole = preload("res://black_hole.tscn")

var Stars = []

func _ready():
	Stars.append(yellow_star)
	Stars.append(red_star)
	Stars.append(blue_star)
	Stars.append(white_dwarf)
	Stars.append(black_hole)
