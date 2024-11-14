while getopts b:cl:w: flag
do
    case "${flag}" in
        b) block_type_arg=${OPTARG};;
        c) cpu='True';;
        l) learning_rate_arg=${OPTARG};;
	w) weight_decay_arg=${OPTARG};;
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
else
    block_type="conv_block_$block_type_arg"
fi

if [ -z "$learning_rate_arg" ]
then
    learning_rate="1e-3"
else
    learning_rate="$learning_rate_arg"
fi

if [ -z "$weight_decay_arg" ]
then
    weight_decay="0"
else
    weight_decay="$weight_decay_arg"
fi

experiment_name="VGG_38_${block_type_arg}lr${learning_rate}_wd${weight_decay}_experiment" 
echo "Experiment name: ${experiment_name}"

echo "using block type: $block_type";
echo "gpu: $gpu";
echo "learning_rate: $learning_rate";
echo "weight_decay: $weight_decay"

python pytorch_mlp_framework/train_evaluate_image_classification_system.py --batch_size 100 --seed 0 --num_filters 32 --num_stages 3 --num_blocks_per_stage 5 --experiment_name $experiment_name --use_gpu $gpu --num_classes 100 --block_type $block_type --continue_from_epoch -1 --learning_rate $learning_rate --weight_decay_coefficient $weight_decay
