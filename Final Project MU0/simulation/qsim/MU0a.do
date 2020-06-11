onerror {exit -code 1}
vlib work
vlog -work work TASK_1.vo
vlog -work work Waveform27.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.LNK_RND_FBCV_Project_MU0_Basic_V1_vlg_vec_tst
vcd file -direction MU0a.msim.vcd
vcd add -internal LNK_RND_FBCV_Project_MU0_Basic_V1_vlg_vec_tst/*
vcd add -internal LNK_RND_FBCV_Project_MU0_Basic_V1_vlg_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
