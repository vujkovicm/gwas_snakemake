configfile: "config/config.yaml"

include:
        "rules/target.rules"
include:
        "rules/promis.rules"
include:
        "rules/epacts.rules"
include:
        "rules/which-snp.rules"

"""
run on PMACS
source activate promis

snakemake -j 900 --keep-going --cluster-config config/cluster.yaml -c "bsub -M 10240 " target_rule

"""
