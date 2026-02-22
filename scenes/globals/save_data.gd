class_name SaveData
extends Resource

const VERSION = 1

var scores: Dictionary
var intro_played: bool

func to_dict() -> Dictionary:
	return {
		"version": VERSION,
		"intro_played": intro_played,
		"scores": scores,
	}

func read_dict(p_dict: Dictionary) -> Error:
	if p_dict["version"] != VERSION:
		# TODO: handle upgrades via version changing.
		return FAILED
	
	scores = p_dict["scores"]
	intro_played = p_dict["intro_played"]
	
	return OK
