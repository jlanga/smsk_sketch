rule skmer__reference__:
    input:
        fasta=[GENOMES / f"{genome}.fa.gz" for genome in GENOME_LIST],
    output:
        SK_REFERENCE / "matrix.txt",
    log:
        f"{SK_REFERENCE}/reference.log",
    conda:
        "__environment__.yml"
    params:
        in_dir=GENOMES,
    shell:
        """
        skmer reference \
            -l {output} \
            {params.in_dir} \
        #2> {log} 1>&2
        """


rule skmer__reference:
    input:
        rules.skmer__reference__.output,
