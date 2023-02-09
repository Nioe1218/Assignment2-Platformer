extends KinematicBody2D
export var ACCELERATION = 600
export var MAX_Speed =150
export var FRICTION = .15
export var JUMP_Force =140
export var GRAVITY = 300
var motion = Vector2.ZERO
var num_jump =2

var jet_pack_speed = 20
var fuel = 100
var health  =100
onready var animation_player = $AnimationPlayer

onready var sprite = $Sprite




func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_horizontal_movemant(input_vector,delta)
	apply_friction(input_vector)
	jump()
	apply_animation(input_vector)
	apply_gravity(delta)
	motion = move_and_slide(motion,Vector2.UP)
	$Label.text = "fuel:"+ str(fuel)
	$ProgressBar.value = health
	if fuel>0:
		if Input.is_action_pressed("jetpack"):
			motion.y -= jet_pack_speed
			$jet_pack_fire/jetpack.emitting = true
			fuel-= 3
	
		else:
				$jet_pack_fire/jetpack.emitting = false
				
func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return input_vector

func apply_horizontal_movemant(input_vector,delta):
	if input_vector.x !=0:
		motion.x += input_vector.x *ACCELERATION*delta
		motion.x = clamp(motion.x,-MAX_Speed,MAX_Speed)

func apply_friction(input_vector):
	if input_vector.x==0 and is_on_floor():
		motion.x = lerp(motion.x,0,FRICTION)
		
func jump():
	if is_on_floor():
		num_jump = 2
	if num_jump > 0:
			if Input.is_action_just_pressed("jump"):
				num_jump -= 1
				motion.y = -JUMP_Force
			else:
				if Input.is_action_just_released("jump") and motion.y < -JUMP_Force/2:
					motion.y = -JUMP_Force/2
			
func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY*delta
		motion.y = min(motion.y,GRAVITY)
		print(motion) 



	
	# We use the sprite's scale to store Robi’s look direction which allows us to shoot
	# bullets forward.
	# There are many situations like these where you can reuse existing properties instead of
	# creating new variables.
	#var is_shooting = false
	#if Input.is_action_just_pressed("shoot" + action_suffix):
		#is_shooting = gun.shoot(sprite.scale.x)

	#var animation = get_new_animation(is_shooting)
	#if animation != animation_player.current_animation and shoot_timer.is_stopped():
	#	if is_shooting:
	#		shoot_timer.start()
	#	animation_player.play(animation)
func hurt():
	health -= 5



func apply_animation(input_vector):
	
		if input_vector.x!=0:
			sprite.scale.x = sign(input_vector.x)
			animation_player.play("run")
		else:
			animation_player.play("idle")
	
		if not is_on_floor():
			
			animation_player.play ("jumping") 
	
	



func _on_Timer_timeout():
	if fuel < 100:
		fuel += 1
