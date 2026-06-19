extends Area2D

# Carrega o componente do menu de morte na memória
const GAME_OVER_SCENE = preload("res://scenes/game_over_ui.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Instancia (cria) o modal de morte, igual um document.createElement()
		var game_over_menu = GAME_OVER_SCENE.instantiate()
		
		# Adiciona o modal diretamente na raiz da fase atual
		get_tree().current_scene.call_deferred("add_child", game_over_menu)
