#include "leaf.p4"
Pipeline(FalconIngressParser(),
         LeafIngress(),
         LeafIngressDeparser(),
         FalconEgressParser(),
         FalconEgress(),
         FalconEgressDeparser()
         ) pipe_leaf;

Switch(pipe_leaf) main;