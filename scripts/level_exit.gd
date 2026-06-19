extends Area2D

# PackedScene permite que você arraste o arquivo da próxima fase 
# direto do seu painel de arquivos para o Inspector!
@export var next_level: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if next_level:
			# Muda para a cena que você arrastou no Inspector
			get_tree().call_deferred("change_scene_to_packed", next_level)
		else:
			print("Você venceu o jogo! (Nenhuma fase selecionada)")
