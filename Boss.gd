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
var timeractive = false
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
			pass
		ATTACKR:#for all attack and move, move to left or right position2d, when there start timer for (0) or just (.1)
			pass
		MOVEL:
			pass
		MOVER:
			pass
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

func summon():
	pass
	#spawn 2 summons


func _on_Timer_timeout():

	timeractive = false
	match state:
		IDLE:
			pass #rand to decide move left or right
		ATTACKL: #rand to decide summon or skill
			pass
		ATTACKR:#rand to decide summon or skill
			pass
		MOVEL: #attack right
			state = ATTACKR
		MOVER: #attack left
			state = ATTACKL
		SUMMON:#back to idle
			state = IDLE
		SKILL:#back to idle
			state = IDLE


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	#boss hurt noise
