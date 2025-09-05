extends CharacterBody2D

# SPEED
const SPEED = 460.0
const JUMP_VELOCITY = -1060.0
# WALL PUSHBACK
const wall_jump = 1050

# PLAYER NODES
@onready var sprite_2d = $Sprite2D
@onready var coyote_timer = $CoyoteTimer
@onready var coyote_timer_w = $CoyoteTimerW
@onready var coyote_timer_c = $CoyoteTimerC
@onready var coyote_timer_j = $CoyoteTimerJ
@onready var camera_2d = $Camera2D

# RAY CASTS
@onready var right_outer = $right_outer
@onready var right_inner = $right_inner
@onready var left_inner = $left_inner
@onready var left_outer = $left_outer

@onready var jump = $"../../jump"

@onready var bgm = $"../../bgm"
var is_playing = true

# Difference in jump velocity while on a wall
var jump_wall = 210

# Slide gravity
const wall_friction = 100
var is_wall_sliding = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grav_adjust: float = 0.7

# ORIENTATION
var facing = null



func _physics_process(delta):
	# MUSIC PLAY ON FALL
	if is_on_floor() and is_playing == true:
		bgm.play()
	if bgm.playing == true:
		is_playing = false
	# ORIENTATION
	if Input.is_action_pressed("left"):
		facing = 0
	if Input.is_action_pressed("right"):
		facing = 1
	
	# ANIMATION TREE
	if is_on_floor() and velocity.y == 0:
		if (velocity.x > 0.1):
			sprite_2d.animation = "run"
		elif (velocity.x < 0):
			sprite_2d.animation = "run-left"
		elif velocity.x == 0:
			if facing == 0:
				sprite_2d.animation = "idle-left"
			else:
				sprite_2d.animation = "idle"
	elif velocity.y > 0:
		if is_wall_sliding:
			if facing == 0:
				sprite_2d.animation = "slide-left"
			else:
				sprite_2d.animation = "slide"
		elif facing == 0:
			sprite_2d.animation = "fall-left"
		else:
			sprite_2d.animation = "fall"
	else:
		if facing == 0:
			sprite_2d.animation = "jump-left"
		else:
			sprite_2d.animation = "jump"
	
	
	# JUMP HELP WHEN BUMP ON EDGE
	if right_outer.is_colliding() and !right_inner.is_colliding() \
	and !left_inner.is_colliding() and !left_outer.is_colliding() and Input.is_action_pressed("right"):
		global_position.x += 10
		global_position.y -= 10
	if left_outer.is_colliding() and !left_inner.is_colliding() \
	and !right_inner.is_colliding() and !right_outer.is_colliding() and Input.is_action_pressed("left"):
		global_position.x -= 10
		global_position.y -= 10
	
	
	# GRAVITY  
	if not is_on_floor():
		velocity.y += gravity * delta
	elif velocity.y > 0:
		velocity.y += gravity * delta * grav_adjust
		
	# JUMP FUNCTION
	if Input.is_action_just_pressed("jump"):
		if (is_on_floor() || !coyote_timer.is_stopped()):
			jump.play()
			velocity.y = JUMP_VELOCITY
			coyote_timer_j.stop()
		if (is_on_wall_only() and Input.is_action_pressed("right") || !coyote_timer_w.is_stopped()):
			jump.play()
			velocity.y = JUMP_VELOCITY + jump_wall
			velocity.x = -wall_jump
			coyote_timer_j.stop()
		if (is_on_wall_only() and Input.is_action_pressed("left") || !coyote_timer_w.is_stopped()):
			jump.play()
			velocity.y = JUMP_VELOCITY + jump_wall
			velocity.x = wall_jump
			coyote_timer_j.stop()
			
	# JUMP DELAY
	if is_on_floor() and !coyote_timer_j.is_stopped():
		jump.play()
		velocity.y = JUMP_VELOCITY
		coyote_timer_j.stop()
	if is_on_wall_only() and Input.is_action_pressed("right") and !coyote_timer_j.is_stopped():
		jump.play()
		velocity.y = JUMP_VELOCITY + jump_wall
		velocity.x = -wall_jump
		coyote_timer_j.stop()
	if is_on_wall_only() and Input.is_action_pressed("left") and !coyote_timer_j.is_stopped():
		jump.play()
		velocity.y = JUMP_VELOCITY + jump_wall
		velocity.x = wall_jump
		coyote_timer_j.stop()
	
		
	# RUN FUNCTION
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 90.0)
	else:
		velocity.x = move_toward(velocity.x, 0, 40)
	
	
	# MOVE CAMERA
	var tween = get_tree().create_tween()
	if is_on_floor() and velocity.x == 0 and coyote_timer_c.is_stopped():
		if Input.is_action_pressed("cam_down"):
			tween.tween_property(camera_2d, "offset:y", 220, 0.2)
			tween.tween_property(camera_2d, "offset:y", 220, 2)
			tween.tween_property(camera_2d, "offset:y", 0, 0.5)
			coyote_timer_c.start()
		if Input.is_action_pressed("cam_up"):
			tween.tween_property(camera_2d, "offset:y", -100, 0.2)
			tween.tween_property(camera_2d, "offset:y", -100, 2)
			tween.tween_property(camera_2d, "offset:y", 0, 0.5)
			coyote_timer_c.start()
		if Input.is_action_pressed("cam_left"):
			facing = 0
			tween.tween_property(camera_2d, "offset:x", -130, 0.2)
			tween.tween_property(camera_2d, "offset:x", -130, 2)
			tween.tween_property(camera_2d, "offset:x", 0, 0.5)
			coyote_timer_c.start()
		if Input.is_action_pressed("cam_right"):
			facing = 1
			tween.tween_property(camera_2d, "offset:x", 130, 0.2)
			tween.tween_property(camera_2d, "offset:x", 130, 2)
			tween.tween_property(camera_2d, "offset:x", 0, 0.5)
			coyote_timer_c.start()
	
	
	# FOR JUMP MARGIN
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall()
	
	move_and_slide()
	
	# JUMP MARGIN
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	if was_on_wall && !is_on_wall():
		coyote_timer_w.start()
	if Input.is_action_pressed("jump"):
		coyote_timer.stop()
		coyote_timer_w.stop()
	if !is_on_floor() and !is_on_wall() and Input.is_action_just_pressed("jump"):
		coyote_timer_j.start()
	
	
	wall_slide(delta)
	
	

# WALL SLIDE DEFINITION
func wall_slide(delta):
	if is_on_wall_only(): 
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
	# WALL SLIDE FUNCTION
	if is_wall_sliding:
		velocity.y += (wall_friction * delta)
		velocity.y = min(velocity.y, wall_friction)
	
func respawn():
	velocity.y = 0
	velocity.x = 0
