import sys
import os
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('Agg')
plt.style.use('ggplot')

# Ensure command line argument for filename is provided
if len(sys.argv) != 2:
    print("Usage: python plot_metrics.py <filename>")
    sys.exit(1)

# Get the input filename from the command line argument
input_filename = sys.argv[1]

txt_name = input_filename.replace('_', ' ')
txt_name = txt_name.replace('experiment', '')
txt_name = txt_name.replace('lr', 'LR=')
txt_name = txt_name.replace('wd', 'WD=')
txt_name = txt_name.replace('bn', 'BN')
txt_name = txt_name.replace('res', 'RC')

# Define paths
results_folder = '{0}/result_outputs'.format(input_filename)
plots_folder = 'plots/{0}'.format(input_filename)
summary_file = os.path.join(results_folder, 'summary.csv')

# Check if summary.csv file exists
if not os.path.exists(summary_file):
    print(f"Error: {summary_file} does not exist.")
    sys.exit(1)

# Load the CSV data
data = pd.read_csv(summary_file)

# Ensure required columns exist in the data
required_columns = {'train_loss', 'val_loss'}
if not required_columns.issubset(data.columns):
    print(f"Error: summary.csv must contain columns: {', '.join(required_columns)}")
    sys.exit(1)

# Create plots directory if it doesn't exist
os.makedirs(plots_folder, exist_ok=True)

# Plot Accuracy
plt.figure(figsize=(10, 6))
plt.plot(data['train_loss'], label=txt_name + ' train loss')
plt.plot(data['val_loss'], label=txt_name + ' val loss')
plt.xlabel("Epoch")
plt.ylabel("Loss")
plt.title("Training and Validation Loss per Epoch")
plt.legend()
loss_plot_path = os.path.join(plots_folder, f"{input_filename}_loss_plot.pdf")
plt.savefig(loss_plot_path)
plt.close()

print(f"Plots saved as:\n  {loss_plot_path}")
