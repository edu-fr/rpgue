class_name PlayerController

extends Control

var playerHealth: int
var playerShield: int

func _init() -> void:
    playerHealth = 100

func defend() -> void:
    playerShield += 10 

func get_player_attack_damage():
    return 10

func get_player_magic_damage():
    return 15