
PLOT_DIR=plots

FILES=$(wildcard VGG*/)
TARGET_DIRS=$(patsubst %,plots/%,$(FILES))


.PHONY: plots
plots:  $(TARGET_DIRS)

plots/%/: %
	mkdir plots/$^
	python plot-acc.py $^
	python plot-loss.py $^
	cp $(^)/saved_models/gradient_flow_plots/epoch99.pdf plots/$(^)/$(^)_grad_flow.pdf

.PHONY : files
files :
	echo "$(FILES)"


.PHONY : clean
clean :
	rm -r plots/*
