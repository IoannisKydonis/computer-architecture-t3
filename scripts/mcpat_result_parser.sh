#!/bin/bash

declare -a benchmarks=("bzip" "hmmer" "libm" "mcf" "sjeng")
declare -a options=("cls_128" "cls_32" "cls_64" "l1da_1" "l1da_2" "l1da_4" "l1ds_128kB_l1is_128kB" "l1ds_128kB_l1is_16kB" "l1ds_128kB_l1is_32kB" "l1ds_128kB_l1is_64kB" "l1ds_16kB_l1is_128kB"
 "l1ds_16kB_l1is_16kB" "l1ds_16kB_l1is_32kB" "l1ds_16kB_l1is_64kB" "l1ds_32kB_l1is_128kB" "l1ds_32kB_l1is_16kB" "l1ds_32kB_l1is_32kB" "l1ds_32kB_l1is_64kB" "l1ds_64kB_l1is_128kB"
 "l1ds_64kB_l1is_16kB" "l1ds_64kB_l1is_32kB" "l1ds_64kB_l1is_64kB" "l1ia_1" "l1ia_2" "l1ia_4" "l2a_1" "l2a_2" "l2a_4" "l2s_1024kB" "l2s_2048kB" "l2s_4096kB" "l2s_512kB")
declare -a parts=("Core:" "L2")
declare -a parameters=("Area" "Subthreshold Leakage" "Gate Leakage" "Runtime Dynamic")

for b in "${benchmarks[@]}"; do
    mkdir -p ./parsed_results
    declare res_file=./parsed_results/"$b"_res.md
    echo -n "| Option |" >> "$res_file"
    for pm in "${parameters[@]}"; do
        echo -n " ${pm/:/''} |" >> "$res_file"
    done
    echo " Total Power | Execution Time | Energy | Energy Efficiency | Energy Efficiency / Area |" >> "$res_file"
    echo -n "| --- | --- | --- | --- | --- | --- |" >> "$res_file"
    for pm in "${parameters[@]}"; do
        echo -n " --- |" >> "$res_file"
    done
    echo "" >> "$res_file"
    for o in "${options[@]}"; do
        echo -n "| $o |" >> "$res_file"
        declare total_power=0
        declare area=0
        for pm in "${parameters[@]}"; do
            declare val=0
            for p in "${parts[@]}"; do
                 declare new=$(grep -xn "$p" ./results/"$b"/"$o".txt | awk -F: '{s = $1 + 6} {print s}' | xargs -I {} head -n {} ./results/"$b"/"$o".txt | tail -n 7 | grep "$pm"" = " | awk -F= '{print $2}' | awk -F' '  '{print $1}')
                 val=$(echo "$val + $new" | bc)
            done
            if [ "$pm" = "Subthreshold Leakage" ] || [ "$pm" = "Gate Leakage" ] || [ "$pm" = "Runtime Dynamic" ]; then
                total_power=$(echo "$total_power + $val" | bc)
            fi
            if [ "$pm" = "Area" ]; then
                area=$val
            fi
            echo -n " $val |" >> "$res_file"
        done
        declare exec_time=$(find ./../my_gem5/spec_results/"$b"/"$o" -type f -name "stats.txt" | xargs -I {} grep "sim_seconds" {} | awk '{print $2}')
        declare energy=$(echo "$total_power * $exec_time" | bc)
        declare energy_efficiency=$(echo "scale=6; 1.0 / $energy" | bc)
        declare energy_efficiency_per_area=$(echo "scale=6; $energy_efficiency / $area" | bc)
        echo -n " $total_power | $exec_time | $energy | $energy_efficiency | $energy_efficiency_per_area |" >> "$res_file"
        echo "" >> "$res_file"
    done
done
