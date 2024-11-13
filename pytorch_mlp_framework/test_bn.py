import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np

from model_architectures import *
import pytest

example_inputs = []
for i in range(0,20):
   img_dims = np.random.randint(50,100,size=2)
   N = np.random.randint(100,200)
   channel_num = np.random.randint(10,20)
   example_inputs.append(torch.rand(N,channel_num,img_dims[0],img_dims[1]))

@pytest.mark.parametrize("example_input",example_inputs)
def test_ConvolutionalProcessingBlockBN(example_input):
   input_shape = example_input.shape
   num_filters = np.random.randint(1,10)
   kernel_size = np.random.randint(1,5)
   padding = 1
   dilation = 1
   bias = torch.rand(1)
   ConvolutionalProcessingBlockBNTestObject = ConvolutionalProcessingBlockBN(input_shape, num_filters, kernel_size, padding, bias, dilation)
   out = None
   out = ConvolutionalProcessingBlockBNTestObject.forward(example_input)
   assert out != None


@pytest.mark.parametrize("example_input",example_inputs)
def test_ConvolutionalDimensionalityReductionBlockBN(example_input):
   input_shape = example_input.shape
   num_filters = np.random.randint(1,10)
   kernel_size = np.random.randint(1,9)
   padding = 1
   dilation = 1
   bias = torch.rand(1)
   reduction_factor = np.random.randint(1,4)
   ConvolutionalDimensionalityReductionBlockBNObject = ConvolutionalDimensionalityReductionBlockBN(input_shape, num_filters, kernel_size, padding, bias, dilation, reduction_factor)
   out = None
   out = ConvolutionalDimensionalityReductionBlockBNObject.forward(example_input)
   assert out != None
