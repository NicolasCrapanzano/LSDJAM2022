extends CanvasLayer

onready var mainMenu = $mainMenu
onready var mainSection = $mainMenu/mainSection
onready var optionSection = $mainMenu/optionSection
onready var creditSection = $mainMenu/creditSection

func _ready():
	mainMenu.hide()
	mainSection.hide()
	optionSection.hide()
	creditSection.hide()
	
##toggle the entire menu window
func menuToggle():
	if (mainMenu.visible):
		mainMenu.hide()
		mainToggle(true)
		optionToggle(false)
		creditToggle(false)
		return;
	mainMenu.show()
	mainToggle(false)
	optionToggle(true)
	creditToggle(true)

## when this is called the main section will close and the options section will open
func openOptionSection():
	mainToggle(true)
	optionToggle(false)
## when this is called the main section will open and the options section will close
func closeOptionSection():
	optionToggle(true)
	mainToggle(false)

## when this is called the main section will close and the credits section will open
func openCreditSection():
	mainToggle(true)
	creditToggle(false)
## when this is called the main section will open and the credits section will close
func closeCreditSection():
	creditToggle(true)
	mainToggle(false)

## enable or disable the main section of the menu (this contains the buttons for the other sections)
func mainToggle(hide):
	if (hide):
		mainSection.hide()
		return;
	mainSection.show()

## enable or disable the configuration and options section of the menu
func optionToggle(hide):
	if (hide):
		optionSection.hide()
		return;
	optionSection.show()

func creditToggle(hide):
	if (hide):
		creditSection.hide()
		return;
	creditSection.show()


func _on_buttonOptions_pressed():
	openOptionSection()
	pass # Replace with function body.


func _on_buttonCredits_pressed():
	openCreditSection()
	pass # Replace with function body.


func _on_backFromOption_pressed():
	closeOptionSection()
	pass # Replace with function body.


func _on_backFromCredits_pressed():
	closeCreditSection()
	pass # Replace with function body.

func _on_buttonExit_pressed():
	get_tree().quit()
	pass # Replace with function body.
