extends KinematicBody2D

onready var stats = $Stats
onready var hitboxpivot = $Pivot
onready var hitbox = $Pivot/hitbox/collisionshape2d
onready var hurtbox = $hurtbox
onready var sprite = $AnimatedSprite
onready var animp = $AnimationPlayer
onready var timer = $Timer
onready var leftpt = get_parent().get_node("left").global_position
onready var rightpt = get_parent().get_node("right").global_position
var rand
enum{
	ATTACKR,
	ATTACKL,
	MOVER,
	MOVEL,
	IDLE,
	SUMMON,
	SKILL,
	DEAD
}
signal dead

export var state = IDLE
var timeractive = false
var velocity = Vector2.ZERO
var acceleration = 300
var maxspeed = 75

func _ready():
	randomize()

func _process(delta):
	match state:
		IDLE:
			animp.play("idle")
			if timeractive == false:
				timer.start(2)
				timeractive = true
		ATTACKL:
			sprite.flip_h = true
			animp.play("AttackL")
			var direction = global_position.direction_to(leftpt)
			velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
			#accelerate_towards_point(leftpt,delta)
			velocity = move_and_slide(velocity)
			if self.global_position.x < leftpt.x:
				velocity = Vector2.ZERO
				timer.emit_signal("timeout")
		ATTACKR:#for all attack and move, move to left or right position2d, when there start timer for (0) or just (.1)
			sprite.flip_h = false
			animp.play("AttackR")
			accelerate_towards_point(rightpt,delta)
			velocity = move_and_slide(velocity)
			if self.global_position.x > rightpt.x:
				velocity = Vector2.ZERO
				timer.emit_signal("timeout")
		MOVEL:
			sprite.flip_h = true
			animp.play("MoveL")
			var direction = global_position.direction_to(leftpt)
			velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
			#accelerate_towards_point(leftpt,delta)
			velocity = move_and_slide(velocity)
			if self.global_position.x < leftpt.x:
				velocity = Vector2.ZERO
				timer.start(.5)
		MOVER:
			sprite.flip_h = false
			animp.play("MoveR")
			accelerate_towards_point(rightpt,delta)
			velocity = move_and_slide(velocity)
			if self.global_position.x > rightpt.x:
				velocity = Vector2.ZERO
				timer.start(.5)
		SUMMON:
			animp.play("summon")
			if timeractive == false:
				timer.start(1)
				timeractive = true
		SKILL:
			animp.play("Skill")
			if timeractive == false:
				timer.start(1.5)
				timeractive = true
		DEAD:
			pass

func summon():
	pass
	#spawn 2 summons

func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	if sprite.flip_h == false:
		velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
	else:
		velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)

func _on_Timer_timeout():
	rand = randi() %100
	timeractive = false
	match state:
		IDLE:
			if rand > 50:
				state = MOVEL
			else: state = MOVER
			#rand to decide move left or right
		ATTACKL: #rand to decide summon or skill
			if rand > 50:
				state = SUMMON
			else: state = SKILL
		ATTACKR:#rand to decide summon or skill
			if rand > 50:
				state = SUMMON
			else: state = SKILL
		MOVEL: #attack right
			state = ATTACKR
		MOVER: #attack left
			state = ATTACKL
		SUMMON:#back to idle
			state = IDLE
		SKILL:#back to idle
			state = IDLE
		DEAD:
			queue_free()


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	if stats.health == 0:
		emit_signal("dead")
		animp.play("death")
		timer.start(2)
		state = DEAD
	#boss hurt noise
