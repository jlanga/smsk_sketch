rule sourmash__index__:
    input:
        [SOUR_GENOMES / f"{genome}.sig" for genome in GENOME_LIST],
    output:
        SOUR_INDEX / "genomes.sbt.zip",
    log:
        SOUR_INDEX / "genomes.log",
    conda:
        "__environment__.yml"
    params:
        prefix=SOUR_INDEX / "genomes",
    shell:
        """
        sourmash index \
            {params.prefix} \
            {input} \
        2> {log} 1>&2
        """


rule sourmash__index:
    input:
        rules.sourmash__index__.output,
