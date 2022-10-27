extends Spatial

const R1 = 1.74
const R2 = 6.37
const M1 = 3674
const M2 = 5972
const R12 = 384.4
const G = (R12/M2*900)

var t = 0
var score = 0
var scoreper = 0
var r1flag = false
var r2flag = false
var doubleflag = false
onready var clst1 = get_node("Star_1")
onready var clst2 = get_node("Star_2")
onready var shuttle = get_node("Satellite")

var tpx = float(Globalvar.posxt)
var tpy = float(Globalvar.posyt)
var tpz = float(Globalvar.poszt)
var tvx = float(Globalvar.velxt)
var tvy = float(Globalvar.velyt)
var tvz = float(Globalvar.velzt)
var tsp = float(Globalvar.velmagt)

var mass1
var radius1
var p1

var mass2
var radius2
var p2

var masssh
var radiussh
var psh

var stopper = false

func _ready():
	mass1 = clst1.mass
	radius1 = get_node("Star_1/CollisionShape").shape.get("radius")
	clst1.linear_velocity = Vector3(0,0,sqrt((G*M2)/R12))

	mass2 = clst2.mass
	radius2 = get_node("Star_2/CollisionShape").shape.get("radius")
	clst2.linear_velocity = Vector3(0,0,-(M1/M2)*sqrt((G*M2)/R12))
#	p2 = -p1
	masssh = shuttle.mass
	radiussh = get_node("Satellite/CollisionShape").shape.get("radius")
	shuttle.global_translation = Vector3(tpx,tpz,tpy)
	shuttle.linear_velocity = tsp*Vector3(tvx,tvz,tvy)

func _process(delta):

	var r12 = clst2.global_transform.origin - clst1.global_transform.origin
	var r1s = shuttle.global_transform.origin - clst1.global_transform.origin
	var r2s = shuttle.global_transform.origin - clst2.global_transform.origin

	var a212 = -G*M1*r12.normalized()/(r12.length()*r12.length())
	var a112 = -G*M2*r12.normalized()/(r12.length()*r12.length())
	var a1s = -G*M1*r1s.normalized()/(r1s.length()*r1s.length())
	var a2s = -G*M2*r2s.normalized()/(r2s.length()*r2s.length())

	clst2.linear_velocity += a212*delta
	clst1.linear_velocity -= a112*delta
	shuttle.linear_velocity += ((a1s + a2s)*delta)

	clst2.global_transform.origin = clst2.global_transform.origin + clst2.linear_velocity*delta
	clst1.global_transform.origin = clst1.global_transform.origin + clst1.linear_velocity*delta
	shuttle.global_transform.origin = shuttle.global_transform.origin + shuttle.linear_velocity*delta

	t = t + delta

	if 200 > r2s.length():
		r2flag = true
		score += 1-((r2s.length())/1000)
		if doubleflag == true:
			score += 1
	if 200 > r1s.length():
		r1flag = true
		score += 1-((r1s.length())/1000)
		if doubleflag == true:
			score += 1
	if r1flag == true:
		if r2flag == true:
			doubleflag = true
	var scorestr = str(round(score))
	get_node("score").set_text(scorestr)
	if r2s.length() > 1000:
		scoreper = scorestr
		get_node("score").set_text(scoreper)
		get_tree().change_scene("res://gameover2.tscn")
	if r1s.length() > 1000:
		scoreper = scorestr
		get_node("score").set_text(scoreper)
		get_tree().change_scene("res://gameover2.tscn")

func _on_star1_body_entered(body):
	if body.name == "Satellite":
		get_tree().change_scene("res://gameover.tscn")

func _on_star2_body_entered(body):
	if body.name == "Satellite":
		get_tree().change_scene("res://gameover.tscn")
	
		
