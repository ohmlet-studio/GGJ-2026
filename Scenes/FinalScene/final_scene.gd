extends Control
@onready var av_pct
@onready var av_error

func _ready() -> void:
	if Globalvar.tot_average_error.size() > 0:
		av_error = Globalvar.tot_average_error.reduce(func(a, b): return a + b, 0) / float(Globalvar.tot_average_error.size())
		print("Average: ", av_error)
	else:
		print("No average data available yet")
		
	if Globalvar.tot_complt_pct.size() > 0:
		av_pct = Globalvar.tot_complt_pct.reduce(func(a, b): return a + b, 0) / float(Globalvar.tot_complt_pct.size())
		print("Pct: ", av_pct)
	else:
		print("No percent data available yet")
		
	$av_error_lab.text = str("%.2f" % av_error)
	$av_pct_lab.text = str("%.0f" % av_pct)
