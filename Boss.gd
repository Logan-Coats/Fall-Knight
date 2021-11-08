extends KinematicBody2D

onready var stats = $Stats
onready var hitboxpivot = $Pivot
onready var hitbox = $Pivot/hitbox/collisionshape2d
onready var hurtbox = $hurtbox
onready var animp = $AnimationPlayer
onready var timer = $Timer

enum{
	ATTACKR,
	ATTACKL,
	MOVER,
	MOVEL,
	IDLE,
	SUMMON,
	SKILL,
}

var state = IDLE

func _ready():
	randomize()

func _process(delta):
	match state:
		IDLE:
			animp.play("idle")
			timer.start(2)
		ATTACKL:
			pass
		ATTACKR:
			pass
		MOVEL:
			pass
		MOVER:
			pass
		SUMMON:
			animp.play("summon")
		SKILL:
			animp.play("Skill")
			timer.start(1.5)

func summon():
	pass
	#spawn 2 summons then idle


func _on_Timer_timeout():
	pass
	#use another match here to avoid 100000 if statements and multiple timers.
	#if state=idle:
		#if flip_h true: moveR else; moveL
	#elif state = mover
		#attackL
	#elif state = moveL
		#attackR
