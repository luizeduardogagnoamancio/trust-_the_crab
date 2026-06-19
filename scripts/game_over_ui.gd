extends CanvasLayer

func _ready() -> void:
	# Opcional: Pausa o jogo quando a tela de morte aparecer para a menina parar de andar
	get_tree().paused = true

func _on_button_pressed() -> void:
	print("clicou pra sair")
	# Tira o jogo do pause e recarrega a fase atual!
	get_tree().paused = false
	get_tree().reload_current_scene()
