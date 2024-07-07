extends FlowContainer


@export var Board_X_Size = 8
@export var Board_Y_Size = 8

@export var Tile_X_Size: int = 50
@export var Tile_Y_Size: int = 50

var colorbit=0


signal send_location

func _ready():
	var styleboxwhite=StyleBoxFlat.new()
	styleboxwhite.bg_color = Color.BURLYWOOD
	var styleboxwhitehover=StyleBoxFlat.new()
	styleboxwhitehover.bg_color = Color.BURLYWOOD
	styleboxwhitehover.border_color = Color.BLACK
	styleboxwhitehover.set_border_width_all(4)
	
	var styleboxblack=StyleBoxFlat.new()
	styleboxblack.bg_color = Color.SADDLE_BROWN
	var styleboxblackhover=StyleBoxFlat.new()
	styleboxblackhover.bg_color = Color.SADDLE_BROWN
	styleboxblackhover.border_color = Color.BLACK
	styleboxblackhover.set_border_width_all(4)
	# stop negative numbers from happening
	if Board_X_Size < 0 || Board_Y_Size < 0:
		return
	var Number_X = 0
	var Number_Y = 0
	# Set up the board
	for j in range (8):
		self.size.y += Tile_Y_Size + 5
		self.size.x += Tile_X_Size + 5
		for i in range (8):
			var temp = Button.new()
			temp.set_custom_minimum_size(Vector2(Tile_X_Size, Tile_Y_Size))
			if i %2 == colorbit:
				temp.add_theme_stylebox_override("normal",styleboxwhite)
				temp.add_theme_stylebox_override("hover",styleboxwhitehover)
			else:
				temp.add_theme_stylebox_override("normal",styleboxblack)
				temp.add_theme_stylebox_override("hover",styleboxblackhover)
			temp.connect("pressed", func():
				emit_signal("send_location", temp.name))
			temp.set_name(str(Number_X) + "-" + str(Number_Y))
			add_child(temp)
			Number_X += 1
		if colorbit==0:
			colorbit=1
		else: colorbit=0
		Number_Y += 1
		Number_X = 0
	Regular_Game()

func Regular_Game():
	get_node("4-0").add_child(Summon("Bishop", 1))
	get_node("5-0").add_child(Summon("King", 1))
	
	
	get_node("4-1").add_child(Summon("Pawn", 1))
	get_node("5-1").add_child(Summon("Pawn", 1))
	get_node("6-1").add_child(Summon("Pawn", 1))
	get_node("7-1").add_child(Summon("Pawn", 1))
	
	
	get_node("4-7").add_child(Summon("King", 0))
	get_node("7-7").add_child(Summon("Rook", 0))
	
	get_node("6-3").add_child(Summon("Knight", 0))
	get_node("2-1").add_child(Summon("Bishop", 0))
	get_node("3-4").add_child(Summon("Queen", 1))
	get_node("2-6").add_child(Summon("Pawn", 0))


func Summon(Piece_Name: String, color: int):
	var Piece
	match Piece_Name:
		"Pawn":
			Piece = Pawn.new()
			Piece.name = "Pawn"
		"King":
			Piece = King.new()
			Piece.name = "King"
		"Queen":
			Piece = Queen.new()
			Piece.name = "Queen"
		"Knight":
			Piece = Knight.new()
			Piece.name = "Knight"
		"Rook":
			Piece = Rook.new()
			Piece.name = "Rook"
		"Bishop":
			Piece = Bishop.new()
			Piece.name = "Bishop"
	Piece.Item_Color = color
	Piece.position = Vector2(Tile_X_Size / 2, Tile_Y_Size / 2)
	return Piece
