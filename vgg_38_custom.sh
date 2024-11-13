while getopts b:cl: flag
do
    case "${flag}" in
        b) block_type_arg=${OPTARG};;
        c) cpu='True';;
        l) learning_rate=${OPTARG};;
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

experiment_name="VGG_38_${block_type_arg}_experiment" 


echo "using block type: $block_type";
echo "gpu: $gpu";
echo "learning_rate: $learning_rate";

python pytorch_mlp_framework/train_evaluate_image_classification_system.py --batch_size 100 --seed 0 --num_filters 32 --num_stages 3 --num_blocks_per_stage 5 --experiment_name $experiment_name --use_gpu $gpu --num_classes 100 --block_type $block_type --continue_from_epoch -1
