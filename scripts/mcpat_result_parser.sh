#!/bin/bash

declare -a benchmarks=("bzip" "hmmer" "libm" "mcf" "sjeng")
declare -a options=("cls_128" "cls_32" "cls_64" "l1da_1" "l1da_2" "l1da_4" "l1ds_128kB_l1is_128kB" "l1ds_128kB_l1is_16kB" "l1ds_128kB_l1is_32kB" "l1ds_128kB_l1is_64kB" "l1ds_16kB_l1is_128kB"
 "l1ds_16kB_l1is_16kB" "l1ds_16kB_l1is_32kB" "l1ds_16kB_l1is_64kB" "l1ds_32kB_l1is_128kB" "l1ds_32kB_l1is_16kB" "l1ds_32kB_l1is_32kB" "l1ds_32kB_l1is_64kB" "l1ds_64kB_l1is_128kB"
 "l1ds_64kB_l1is_16kB" "l1ds_64kB_l1is_32kB" "l1ds_64kB_l1is_64kB" "l1ia_1" "l1ia_2" "l1ia_4" "l2a_1" "l2a_2" "l2a_4" "l2s_1024kB" "l2s_2048kB" "l2s_4096kB" "l2s_512kB")
declare -a parts=("Core:" "L2")
declare -a labels=("Core" "L2")
declare -a parameters=("Subthreshold Leakage" "Gate Leakage" "Runtime Dynamic")

for b in "${benchmarks[@]}"; do
    mkdir -p ./parsed_results/"$b"
    for o in "${options[@]}"; do
        declare res_file=./parsed_results/"$b"/"$o"_res.md
        echo -n "" >> "$res_file"

        echo -n "| Parameters |" >> "$res_file"
        for l in "${labels[@]}"; do
            echo -n " $l |" >> "$res_file"
        done
        echo "" >> "$res_file"
        echo -n "| --- |" >> "$res_file"
        for p in "${parts[@]}"; do
            echo -n " --- |" >> "$res_file"
        done
        echo "" >> "$res_file"
        for pm in "${parameters[@]}"; do
            echo -n "| $pm |" >> "$res_file"
            for p in "${parts[@]}"; do
                 declare val=$(grep -xn "$p" ./results/"$b"/"$o".txt | awk -F: '{s = $1 + 6} {print s}' | xargs -I {} head -n {} ./results/"$b"/"$o".txt | tail -n 7 | grep "$pm"" = " | awk -F= '{print $2}' | awk -F' '  '{print $1}')
                 echo -n " $val |" >> "$res_file"
            done
            echo "" >> "$res_file"
        done
    done
done
