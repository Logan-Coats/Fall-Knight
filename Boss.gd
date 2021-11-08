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
	pass

func summon():
	pass
