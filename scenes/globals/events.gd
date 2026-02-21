extends Node

###### level calls
signal level_selected(level_name : Level_Info.LEVEL_NAME) # read by gamestate for setup
signal level_start(level_info : Level_Info) # called by gamestate, read by conductor
signal level_ended() # read by gamestate, call to send end info to results screen
signal open_results() # read by the result screens (might not need this)

###### for tracking values in the gamestate
signal note_spawned() # gamestate counting
signal bonus_note_spawned() # gamestate counting
signal note_hit() # gamestate counting
signal group_finished(rating : Enums.GroupRating) #gamestate counting, also used by ui to show last group rating
signal score_updated(p_new_score: int, p_new_score_max: int)
