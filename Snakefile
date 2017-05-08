configfile: "config/config.yaml"

include:
        "rules/target.rules"
include:
        "rules/snptest.rules"

"""
run on PMACS
source activate promis

snakemake -j 900 --cluster-config config/cluster.yaml -c "bsub" target_rule

"""
