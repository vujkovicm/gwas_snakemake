configfile: "config/config.yaml"

include:
        "rules/target.rules"
include:
        "rules/snptest.rules"

"""
run on PMACS
source activate promis

snakemake -j 300 --cluster-config config/cluster.yaml -c "bsub -V -l h_vmem={cluster.g_vmem} -l mem_free={cluster.mem_free} -l mem_free_l={cluster.m_mem_free} -pe smp {threads}"

"""
