
while getopts b:cl:w:s: flag
do
    case "${flag}" in
        b) block_type_arg=${OPTARG};;
        c) cpu='True';;
        l) learning_rate_arg=${OPTARG};;
	w) weight_decay_arg=${OPTARG};;
	s) start_num_arg=${OPTARG};; 
    esac
done

if [ -z "${cpu}" ];
then
        gpu='True'
else
        gpu='False'
fi

if [ -z "$block_type_arg" ]
then
    block_type="conv_block"
    block_type_txt="_${block_type}"
else
    block_type="conv_block_$block_type_arg"
    block_type_txt="_${block_type}"
fi

if [ -z "$learning_rate_arg" ]
then
    learning_rate="1e-3"
    learning_rate_txt=""
else
    learning_rate="$learning_rate_arg"
    learning_rate_txt="_LR=${learning_rate}"
fi

if [ -z "$weight_decay_arg" ]
then
    weight_decay="0"
    weight_decay_txt=""
else
    weight_decay="$weight_decay_arg"
    weight_decay_txt="_WD=${weight_decay}"
fi

if [ -z "$start_num_arg" ]
then
    start_num="-1"
else
    start_num="$start_num_arg"
fi

experiment_name="VGG_38${block_type_txt}${learning_rate_txt}${weight_decay_txt}_experiment" 
echo "Experiment name: ${experiment_name}"

echo "using block type: $block_type";
echo "gpu: $gpu";
echo "learning_rate: $learning_rate";
echo "weight_decay: $weight_decay"

python pytorch_mlp_framework/train_evaluate_image_classification_system.py --batch_size 100 --seed 0 --num_filters 32 --num_stages 3 --num_blocks_per_stage 5 --experiment_name $experiment_name --use_gpu $gpu --num_classes 100 --block_type $block_type --continue_from_epoch $start_num --learning_rate $learning_rate --weight_decay_coefficient $weight_decay
