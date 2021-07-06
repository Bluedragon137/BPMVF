import numpy as np
import random
import json
import re
import subprocess
import tensorflow as tf
import tensorflow_probability as tfp
from keras.models import load_model
from graph_shap import vis_shap


# def multinomial_nll(true_counts, logits):
#     """Compute the multinomial negative log-likelihood
#     Args:
#       true_counts: observed count values
#       logits: predicted logit values
#     """
#     counts_per_example = tf.reduce_sum(true_counts, axis=-1)
#     dist = tfp.distributions.Multinomial(total_count=counts_per_example,
#                                          logits=logits)
#     return (-tf.reduce_sum(dist.log_prob(true_counts)) / 
#             tf.to_float(tf.shape(true_counts)[0]))

# class MultichannelMultinomialNLL(object):
#     def __init__(self, n):
#         self.__name__ = "MultichannelMultinomialNLL"
#         self.n = n

#     def __call__(self, true_counts, logits):
#         for i in range(self.n):
#             loss = multinomial_nll(true_counts[..., i], logits[..., i])
#             if i == 0:
#                 total = loss
#             else:
#                 total += loss
#         return total

#     def get_config(self):
#         return {"n": self.n}



# def split(word):
#     return [char for char in word]
# def loadbpm(cell_type):
#     global model
#     global graph
#     # model = load_model('../ENCSR000EGM/models/model_split000.h5')
#     with tf.keras.utils.custom_object_scope({'MultichannelMultinomialNLL': MultichannelMultinomialNLL}):
#         model = load_model('../ENCSR000EGM/models/model_split000.h5')
#     graph = tf.get_default_graph()

def generate_output(cell_type, chromosome, position, allele1, allele2):
    subprocess.call(['sh', '../scripts/reset.sh'])
    #loadbpm(cell_type)
    with open('../ENCSR000EGM/data/peaks.bed', 'w') as peaks:
        peaks.write('\n{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}'.format(chromosome, str(position-120), str(position+120), '.', '1000', '.', '0.0', '0.0', '0.01', '120'))
    subprocess.call(['sh', '../scripts/predict.sh'])
    subprocess.call(['sh', '../scripts/shap.sh'])
    vis_shap('../ENCSR000EGM/shap/counts_scores.h5', '../ENCSR000EGM/shap/profile_scores.h5', 0)

if __name__ == '__main__':
    generate_output('abc', 'chr1', 35641660, 'A', 'G')
