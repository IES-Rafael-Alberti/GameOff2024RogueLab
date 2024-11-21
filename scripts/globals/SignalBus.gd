extends Node
signal execute_event(event_id:String,aux:bool)
signal event_waiting(event_id:String)
signal execute_dialog(text:String, event_id:String)
signal execute_ending(text:String)
signal execute_canvas_option(canvas_options:String)
signal execute_camera_option(camera_options:String)
signal execute_puzzle(event_id:String)
signal input_required()
signal wait_input()
signal zoom_item(texture,maxScale,minScale,speed)
signal puzzle_exit(puzzleLayer:CanvasLayer)
signal puzzle_enter(puzzleLayer:CanvasLayer)
signal on_transition_finished()
signal exit_zoom_item(texture)
signal input_caja_fuerte(input:String)
signal input_rejilla(input:String)
