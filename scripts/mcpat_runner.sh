#!/bin/bash

declare -a benchmarks=("bzip" "hmmer" "libm" "mcf" "sjeng")
declare -a options=("cls_128" "cls_32" "cls_64" "l1da_1" "l1da_2" "l1da_4" "l1ds_128kB_l1is_128kB" "l1ds_128kB_l1is_16kB" "l1ds_128kB_l1is_32kB" "l1ds_128kB_l1is_64kB" "l1ds_16kB_l1is_128kB"
 "l1ds_16kB_l1is_16kB" "l1ds_16kB_l1is_32kB" "l1ds_16kB_l1is_64kB" "l1ds_32kB_l1is_128kB" "l1ds_32kB_l1is_16kB" "l1ds_32kB_l1is_32kB" "l1ds_32kB_l1is_64kB" "l1ds_64kB_l1is_128kB"
 "l1ds_64kB_l1is_16kB" "l1ds_64kB_l1is_32kB" "l1ds_64kB_l1is_64kB" "l1ia_1" "l1ia_2" "l1ia_4" "l2a_1" "l2a_2" "l2a_4" "l2s_1024kB" "l2s_2048kB" "l2s_4096kB" "l2s_512kB")

for b in "${benchmarks[@]}"; do
    mkdir -p ./results/"$b"
    for o in "${options[@]}"; do
        ./mcpat/mcpat -o -infile ./configs/"$b"/"$o".xml -print_level 5 >> ./results/"$b"/"$o".txt
    done
done
