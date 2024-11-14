
FILES=$(wildcard VGG*/)

FILE_NAMES=$(patsubst %/,%,$(FILES))

PLOT_DIR=plots

#PLOT_ACC_FILES=$(FILE_NAMES:%=$(PLOT_DIR)/%/%_acc_plot.pdf)
PLOT_ACC_FILES=$(foreach name,$(FILE_NAMES),$(PLOT_DIR)/$(name)/$(name)_acc_plot.pdf)
PLOT_LOSS_FILES=$(foreach name,$(FILE_NAMES),$(PLOT_DIR)/$(name)/$(name)_loss_plot.pdf)
PLOT_GRAD_FILES=$(foreach name,$(FILE_NAMES),$(PLOT_DIR)/$(name)/$(name)_grad_plot.pdf)


#$(PLOT_DIR)/%:
#	mkdir -p $@

.PHONY: plots
plots: $(PLOT_ACC_FILES) $(PLOT_LOSS_FILES) $(PLOT_GRAD_FILES)

$(PLOT_DIR)/%/%_acc_plot.pdf: %
		@if [ ! -f "$@" ]; then \
		echo "Generating plot for $*..."; \
		python plot-acc.py $*; \
	else \
		echo "$@ already exists, skipping."; \
	fi

$(PLOT_DIR)/%/%_loss_plot.pdf: %
		@if [ ! -f "$@" ]; then \
		echo "Generating plot for $*..."; \
		python plot-loss.py $*; \
	else \
                echo "$@ already exists, skipping."; \
	fi

$(PLOT_DIR)/%/%_grad_plot.pdf: %
		@if [ ! -f "$@" ]; then \
		echo "Copying grad plot $*..."; \
		echo "cp ${@}/saved_models/gradient_flow_plots/epoch99.pdf $@"; \
	else \
		echo "$@ already exists, skipping."; \
	fi
