#ifndef __HEADER_P4__
#define __HEADER_P4__ 1

#define NUM_SW_PORTS   48
#define NUM_LEAF_US    24
#define NUM_LEAF_DS    24
#define NUM_SPINE_DS   24
#define NUM_SPINE_US   24

#define PKT_TYPE_NEW_TASK 0
#define PKT_TYPE_NEW_TASK_RANDOM 1
#define PKT_TYPE_TASK_DONE 2
#define PKT_TYPE_TASK_DONE_IDLE 3
#define PKT_TYPE_QUEUE_REMOVE 4
#define PKT_TYPE_SCAN_QUEUE_SIGNAL 5
#define PKT_TYPE_IDLE_SIGNAL 6
#define PKT_TYPE_QUEUE_SIGNAL 7
#define PKT_TYPE_PROBE_IDLE_QUEUE 8
#define PKT_TYPE_PROBE_IDLE_RESPONSE 9
#define PKT_TYPE_IDLE_REMOVE 10

#define HDR_PKT_TYPE_SIZE 8
#define HDR_CLUSTER_ID_SIZE 16
#define HDR_LOCAL_CLUSTER_ID_SIZE 8
#define HDR_SRC_ID_SIZE 16
#define HDR_QUEUE_LEN_SIZE 8
#define HDR_SEQ_NUM_SIZE 16
#define HDR_FALCON_RAND_GROUP_SIZE 8
#define HDR_FALCON_DST_SIZE 8

#define QUEUE_LEN_FIXED_POINT_SIZE 8

// These are local per-rack values as ToR does not care about other racks
struct worker_t {
    bit<8> qlen;
    bit<8> wid;
}

header falcon_h {
    bit<HDR_PKT_TYPE_SIZE> pkt_type;
    bit<HDR_CLUSTER_ID_SIZE> cluster_id;
    bit<HDR_LOCAL_CLUSTER_ID_SIZE> local_cluster_id;
    bit<16> src_id;                 // workerID for ToRs. ToRID for spines.
    bit<16> dst_id;
    bit<8> qlen;                    // Also used for reporting length of idle list (from spine sw to leaf sw)
    bit<HDR_SEQ_NUM_SIZE> seq_num;   
}

struct falcon_header_t {
    ethernet_h ethernet;
    ipv4_h ipv4;
    udp_h udp;
    falcon_h falcon;
}

struct eg_metadata_t {

}

header resub_hdr_t {
    bit<16> udpate_worker_index;
}

struct falcon_metadata_t {
    
    bit<HDR_SRC_ID_SIZE> linked_sq_id;
    bit<HDR_SRC_ID_SIZE> linked_iq_id;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> queue_len_unit; // (1/num_worekrs) for each vcluster
    bit<HDR_SRC_ID_SIZE> cluster_idle_count;
    bit<16> idle_worker_index;
    bit<16> worker_index;
    bit<16> cluster_worker_start_idx;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> aggregate_queue_len;
    PortId_t egress_port;
    MulticastGroupId_t rand_probe_group;
    bit<16> cluster_num_valid_ds;
    bit<16> random_downstream_id_1;
    bit<16> random_downstream_id_2;
    bit<16> random_worker_index_1;
    bit<16> random_worker_index_2;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> worker_qlen_1;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> worker_qlen_2;

    bit<QUEUE_LEN_FIXED_POINT_SIZE> random_worker_qlen_1;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> random_worker_qlen_2;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> selected_worker_qlen;
    bit<QUEUE_LEN_FIXED_POINT_SIZE> not_selected_worker_qlen;
    bit<1> valid_list_random_worker_1;
    bit<1> valid_list_random_worker_2;
    bit<16> idle_worker_id;
    bit<8> selected_spine_iq_len;
    bit<8> last_iq_len;
	bit<16> last_probed_id;
	resub_hdr_t task_resub_hdr;
}


#endif // __HEADER_P4__