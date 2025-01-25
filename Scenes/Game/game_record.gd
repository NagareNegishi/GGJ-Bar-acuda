extends Node
class_name GameRecord

const SAVE_PATH = "user://game_record.save"

var total_orders: int = 0
var total_money: int = 0
var perfect_orders: int = 0
var time_played: float = 0.0
var customers_served: Dictionary = {
    "Fish": 0,
    "Turtle": 0
}
var rejected_customers: int = 0