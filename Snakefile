configfile: "config/config.yaml"

include:
        "rules/target.rules"
include:
        "rules/gwas-assoc.rules"
include:
        "rules/gwas-qc.rules"
include:
        "rules/epacts.rules"
include:
        "rules/rvtest.rules"
include:
        "rules/snp-convert.rules"

"""
run on PMACS
source activate promis3

snakemake -j 900 --keep-going --cluster-config config/cluster.yaml -c "bsub -M 10240 " target_rule

"""
