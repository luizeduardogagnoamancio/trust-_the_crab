extends CharacterBody2D

const BASE_WALK_ANIM_LENGTH: float = 0.4

@export var tile_size: int = 16
@export var speed: float = 4.0
@export var turn_delay: float = 0.1

@onready var anim_player: AnimationPlayer = $AnimationPlayer
# Pegamos a referência da nossa antena/laser
@onready var ray_cast: RayCast2D = $RayCast2D

var is_moving: bool = false
var facing_direction: Vector2 = Vector2.DOWN
var turn_timer: float = 0.0

func _ready() -> void:
	position = position.snapped(Vector2(tile_size, tile_size))
	anim_player.play("idle_down")

func _physics_process(delta: float) -> void:
	if is_moving:
		return

	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		direction.y = 0
	direction = direction.sign()

	if direction != Vector2.ZERO:
		if direction != facing_direction:
			facing_direction = direction
			turn_timer = turn_delay
			anim_player.play("idle_" + get_direction_name(facing_direction))
			
			# Atualiza a direção do RayCast quando o player apenas vira de lado
			update_raycast_direction(direction)
		else:
			if turn_timer > 0:
				turn_timer -= delta
			else:
				# Antes de andar, atualizamos o RayCast e checamos a colisão
				update_raycast_direction(direction)
				if not ray_cast.is_colliding():
					move_to_grid(direction)
	else:
		turn_timer = 0.0

func move_to_grid(direction: Vector2) -> void:
	is_moving = true
	
	var movement_time: float = 1.0 / speed
	var animation_speed: float = BASE_WALK_ANIM_LENGTH / movement_time
	
	anim_player.play("walk_" + get_direction_name(direction), -1, animation_speed)
	
	var target_position: Vector2 = position + (direction * tile_size)
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", target_position, movement_time)
	
	tween.tween_callback(func() -> void: 
		is_moving = false
		anim_player.play("idle_" + get_direction_name(direction))
	)

# Função nova para girar o sensor laser para a direção correta
func update_raycast_direction(direction: Vector2) -> void:
	ray_cast.target_position = direction * tile_size
	# Força o RayCast a atualizar a matemática dele imediatamente neste frame
	ray_cast.force_raycast_update()

func get_direction_name(dir: Vector2) -> String:
	match dir:
		Vector2.DOWN: return "down"
		Vector2.UP: return "up"
		Vector2.LEFT: return "left"
		Vector2.RIGHT: return "right"
		_: return "down"
