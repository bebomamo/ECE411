package cache_types;
    typedef enum logic [1:0] {
        idle = 2'b00,
        hit = 2'b01,
        allocate = 2'b11,
        writeback = 2'b10 
    } state_t;

    typedef enum logic [3:0]{
        hit_on_way_0 = 4'b0001,
        hit_on_way_1 = 4'b0010,
        hit_on_way_2 = 4'b0100,
        hit_on_way_3 = 4'b1000,
        total_miss   = 4'b0000
    } oh_miss_hit_detect_t;
endpackage